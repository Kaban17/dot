-- Setup capabilities for nvim-cmp integration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup language servers.
local lspconfig = require('lspconfig')

-- Python (Pyright)
lspconfig.pyright.setup {
    capabilities = capabilities,
}

-- Go (gopls)
lspconfig.gopls.setup {
    capabilities = capabilities,
}

-- BibTeX/LaTeX (texlab)
lspconfig.texlab.setup {
    capabilities = capabilities,
    settings = {
        texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = true,
            },
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
        },
    }
}

-- C++ (clangd)
lspconfig.clangd.setup {
    capabilities = capabilities,
}

-- HTML (html)
lspconfig.html.setup {
    capabilities = capabilities,
}

-- Bash (bashls)
lspconfig.bashls.setup {
    capabilities = capabilities,
}

-- CSS (cssls)
lspconfig.cssls.setup {
    capabilities = capabilities,
}

-- GolangCI-Lint for Go
lspconfig.golangci_lint_ls.setup {
    capabilities = capabilities,
}

-- Rust (rust_analyzer)
lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true,
                },
            },
        },
    },
}

-- Global mappings for diagnostics
vim.keymap.set('n', '<leader>lD', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.setloclist)

-- LspAttach autocommand to setup buffer-specific keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = {buffer = ev.buf}
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<Leader>la', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<Leader>lf',
                       function() vim.lsp.buf.format {async = true} end, opts)
    end
})

