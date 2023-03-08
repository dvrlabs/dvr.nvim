# dvr.nvim

### Introduction

dvr.nvim is simply my nvim configuration, forked and reconfigured from [kickstart](https://github.com/nvim-lua/kickstart.nvim)

#### First Steps

Backup or delete your current neovim files..

Option 1. Backup

```
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

Option 2. Delete

```
sudo rm -r ~/.config/nvim 
sudo rm -r ~/.local/share/nvim 
sudo rm -r ~/.local/state/nvim 
sudo rm -r ~/.cache/nvim 
```

Option 3. Trash

```
trash-put ~/.config/nvim 
trash-put ~/.local/share/nvim 
trash-put ~/.local/state/nvim 
trash-put ~/.cache/nvim 
```

#### Clone the repo

```
git clone https://github.com/dvrlabs/dvr.nvim ~/.config/nvim
```

### Setup

#### PYLSP completions

To get proper completions with python (pylsp) in neovim

edit: $HOME/.local/share/nvim/mason/packages/python-lsp-server/venv/pyvenv.cfg

set `include-system-site-packages = true`

### Features

#### UI Enhancements
- mini.animate - Cool looking animations for common vim motions.
- mini.starter - Basic startup screen.
- mini.tabline - Tab line for buffers at the top.
- Noice - Noicer cmd line at top center of screen.
- Everforest colorscheme - nice.

#### Notes
- Neorg - Note taking and knowledge base.

#### Work flow
- mini.comment - basic comment plugin.
- mini.sessions - basic session manager, remembers what was opened previously.
- Neo-tree - file tree for working on multi-file projects.

### Design Intent
- 'Aesthetic'.
- Fast.
- Simple.
- Better keymaps.


