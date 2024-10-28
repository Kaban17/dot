-- Конфигурация nvim-cmp
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            -- Используй vsnip
            vim.fn["vsnip#anonymous"](args.body) -- For vsnip users.
            -- require('luasnip').lsp_expand(args.body) -- For luasnip users.
            -- require('snippy').expand_snippet(args.body) -- For snippy users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For ultisnips users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- Для vsnip
        -- { name = 'luasnip' }, -- Для luasnip
        -- { name = 'ultisnips' }, -- Для ultisnips
        -- { name = 'snippy' }, -- Для snippy
    }, {
        { name = 'buffer' },
    })
})

-- Настройки для gitcommit (опционально)
--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- Не забудь установить petertriho/cmp-git, если будешь использовать это
    }, {
      { name = 'buffer' },
    })
})
require("cmp_git").setup() ]]--

-- Для команд `/` и `?`
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Для командного режима `:`
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- Настройка LSP с nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Пример настройки lspconfig для Python (Pyright)
require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}

-- Добавь остальные языковые серверы по аналогии
-- Например:
-- require('lspconfig')['tsserver'].setup { capabilities = capabilities }

