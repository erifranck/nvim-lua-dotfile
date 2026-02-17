return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "ray-x/cmp-treesitter",
      "dcampos/cmp-emmet-vim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      -- Your custom highlights
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


      -- Autopairs integration
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      -- Your custom kind icons
      local cmp_kinds = {
        Text = '  ',
        Method = '  ',
        Function = '  ',
        Constructor = '  ',
        Field = '  ',
        Variable = '  ',
        Class = '  ',
        Interface = '  ',
        Module = '  ',
        Property = '  ',
        Unit = '  ',
        Value = '  ',
        Enum = '  ',
        Keyword = '  ',
        Snippet = '  ',
        Color = '  ',
        File = '  ',
        Reference = '  ',
        Folder = '  ',
        EnumMember = '  ',
        Constant = '  ',
        Struct = '  ',
        Event = '  ',
        Operator = '  ',
        TypeParameter = '  ',
      }

      -- Your exact cmp setup
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
              treesitter = "[treesitter]",
              nvim_lua = "[Lua]",
              latex_symbols = "[LaTeX]",
            })[entry.source.name]
            lspkind.cmp_format()
            return vim_item
          end
        },
        view = {
          entries = "custom" -- can be "custom", "wildmenu" or "native"
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
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
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
          { name = 'nvim_lsp',   priority = 1 },
          { name = 'buffer',     priority = 2 },
          { name = 'luasnip',    priority = 4 },
          { name = 'treesitter', priority = 5 },
          { name = 'emmet_vim' },
        }, {
          { name = 'buffer' },
        })
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}