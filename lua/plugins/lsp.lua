return {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', opts = {} },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        { 'j-hui/fidget.nvim',       opts = {} },
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')
                -- Find references for the word under your cursor.
                map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map('<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, '[W]orkspace [S]ymbols')
                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')
                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                ---@param client vim.lsp.Client
                ---@param method vim.lsp.protocol.Method
                ---@param bufnr? integer some lsp support methods only in specific files
                ---@return boolean
                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has 'nvim-0.11' == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        vim.diagnostic.config {
            severity_sort = true,
            float = { border = 'rounded', source = 'if_many' },
            underline = { severity = vim.diagnostic.severity.ERROR },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '󰅚 ',
                    [vim.diagnostic.severity.WARN] = '󰀪 ',
                    [vim.diagnostic.severity.INFO] = '󰋽 ',
                    [vim.diagnostic.severity.HINT] = '󰌶 ',
                },
            },
            virtual_text = {
                source = 'if_many',
                spacing = 2,
                format = function(diagnostic)
                    local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                    }
                    return diagnostic_message[diagnostic.severity]
                end,
            },
        }

        local original_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require('blink.cmp').get_lsp_capabilities(original_capabilities)
        local servers = {
            marksman = {},
            clangd = {},
            rust_analyzer = {},
            lua_ls = {},
            ts_ls = {},
            jdtls = {},
            pylyzer = {},
            gopls = {},
            bashls = {},
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
            'prettierd',
            'google-java-format',
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
            ensure_installed = {},
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }
    end,
}
