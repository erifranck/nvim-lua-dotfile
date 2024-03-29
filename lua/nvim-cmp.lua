local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then return end

local lspkind_setup, lspkind = pcall(require, "lspkind")
if not lspkind_setup then return end

local lspconfig_setup, lspconfig = pcall(require, "lspconfig")
if not lspconfig_setup then return end

local cmp_nvim_lsp_setup, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_setup then return end

vim.api.nvim_set_hl(0, 'MyNormal', { fg = '#ffffff', bg = '#283747' })
vim.api.nvim_set_hl(0, 'MyFloatBorder', { fg = '#283747', bg = '#F7DC6F' })
vim.api.nvim_set_hl(0, 'Error', { fg = '#ffffff', bg = '#CD6155' })

vim.api.nvim_set_hl(0, 'MyItemAbbr', { fg = '#3498DB', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#F7DC6F', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#CD6155', bg = 'NONE' })

vim.cmd [[
  hi! link CmpItemKind MyItemAbbr
  hi! link CmpItemMenu MyItemAbbr
  hi! link CmpItemAbbr MyItemAbbr
  hi! link CmpItemAbbrMatch CmpItemAbbrMatch
  hi! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatchFuzzy
]]

cmp.event:on("menu_opened", function()
  vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on("menu_closed", function()
  vim.b.copilot_suggestion_hidden = false
end)

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

cmp.setup({
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
      -- Kind icons
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
      vim_item.kind_hl_group = hl_group
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        ultiSnips = "[ultisnips]",
        treesitter = "[treesitter]",
        -- copilot = "[copilot]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      if lspkind_setup then
        lspkind.cmp_format()
      end
      return vim_item
    end
  },
  view = {
    entries = "custom" -- can be "custom", "wildmenu" or "native"
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({
      border = { "◎", "─", "◎", "│", "◎", "─", "◎", "│" },
      winhighlight = "Normal:MyNormal,FloatBorder:MyFloatBorder,CursorLine:Cursor,Search:None",
      col_offset = -3,
      side_padding = 0,
    }),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-n>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(("<Down>"), "n", true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ["<C-p>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(("<Up>"), "n", true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
  }),
  sources = cmp.config.sources({
    -- { name = 'copilot',    priority = 1 },
    { name = 'nvim_lsp',   priority = 1 },
    { name = 'buffer',     priority = 2 },
    { name = 'ultisnips',  priority = 4 },
    { name = 'treesitter', priority = 5 },
    { name = 'emmet_vim' },
  }, {
    { name = 'buffer' },
  })
})

local capabilities = cmp_nvim_lsp.default_capabilities()

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local lsp_defaults = lspconfig.util.default_config
local cmp_capabiliries = require('cmp_nvim_lsp').default_capabilities()
lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, cmp_capabiliries)

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
