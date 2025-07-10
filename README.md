# Konnys Neovim Configuration

--- 

## Summary

Lightweight nvim client with only the most essential plugins for a functional workflow.

---

### Project Structure

```bash
 .
├──  init.lua
├──  lazy-lock.json
└──  lua
    ├──  config
    │   ├──  keymaps.lua
    │   ├──  lazy.lua
    │   └──  options.lua
    └──  plugins
        ├──  blink-cmp.lua
        ├──  conform.lua
        ├──  dressing.lua
        ├──  fzflua.lua
        ├──  kanagawa.lua
        ├──  lsp.lua
        ├──  neotree.lua
        ├──  project.lua
        ├──  rustacean.lua
        ├──  statusline.lua
        ├──  treesitter.lua
        └──  which-key.lua
```

---

### Plugins with short description

### Package manager of choise is Lazy.nvim

- **keymaps/options**: Some simple options and keymaps.

- **blink-cmp**: This plugins configures the autocomplete from LSP / Custom sources.- **conform**: Sets upp the custom formatters and potential LSP fallbacks.
- **dressing**: Cosmetic plugin that changes the buffer for refactoring and stuff to be a floating buffer (fixes some issues with screen space).
- **fzf-lua**: No intruduction needed helps you fuzzy find over projects.
- **kanagawa**: My choice of theme.
- **nvim-lspconfig**: Configures how diffrent LSPs interact with neovim.
- **neotree**: My choise of filemanager inside nvim.
- **project**: Helps fzf-lua to find the root of the project.
- **rustacean**: Compliments the LSP (rust-analyzer) with added functionality.
- **statusline**: Adds a statusline (lualine) that shows current mode,file and git status.
- **treesitter**: Well for obvious reasons.
- **which-key**: Nice cus im a noob and have alot of binds.

---
