# Notes on our nvim configuration (init.lua)

Every time an LSP attaches to a buffer, our keymaps autocmd fires and creates buffer-local
keybindings. This means the keybindings only exist in files where an LSP is active.

## The Keybindings:

- K - Hover documentation (cursor on a symbol, press K to see docs)
- gd - Go to definition (jump to where something is defined)
- gD - Go to declaration (similar to definition)
- gr - Find all references (where is this used?)
- gi - Go to implementation
- Ctrl+s - Signature help (shows function parameters while typing)
- leader+rn - Rename symbol (refactor/rename across entire project)
- leader+ca - Code actions (quick fixes, add imports, etc.)
- leader+f - Format the file
