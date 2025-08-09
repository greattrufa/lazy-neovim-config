## Awesome Neovim Configuration :zap:

This configuration is made to provide a functional workspace with little to no requirements

>##### Note: This neovim config is still under development and being tested

> References:
>
> This configuration is created using lazy.nvim for personal use.
> It takes inspiration from my previous neovim configuration [here](https://github.com/greattrufa/neovim-config)
>

## Requirements :hammer:
This configuration is made to require absolutely nothing to run and get set up but since it's for c/c++ here are some things you should have:
*   A C/C++ compiler (preferably **clang** because of autocompletion and formatting but it should work with any)
*   Python installed on your system

If you have those things set up then you are ready for the installation

## Setup :rocket:
### Before getting started make sure you have a backup of your already existing configuration if you have one

#### After that to set it up you can clone it with git on your neovim configuration like this:

#### For Linux (And probably MacOS haven't tested it please make sure to leave comments from MacOS)

```bash
git clone https://github.com/greattrufa/lazy-neovim-config.git ~/.config/nvim
```

For Windows:

```powershell
git clone https://github.com/greattrufa/lazy-neovim-config.git $HOME\AppData\Local\nvim
```

#### After the cloning process has finished open neovim. Everything should be installed smoothly and if not try the setup again a few times

## Plugins and Keybindings
This configuration includes the following plugins that can be editted in the `lua/plugs` directory and the keybindings can be edited on the `lua/keys.lua` file

**Switch between windows:**

- control+h: on the left

- control+l: on the right

- control+j: for going down

- control+k: for going up

(Works for both insert and command mode)

**Handle open tabs:**

- control+t: To create a new tab

- control+w: To close the current tab

- alt+rightarrow: To move to the next one

- alt+leftarrow: To move to the previous one

- Space+t+m+p: To move the previus tab to the right

- Space+t+m+p: To move the current tab to the right

**Other stuff:**

- control+s: Save current file

- space+w: Save all buffer changes

- control+q: Quit neovim buffer

- space+q: Quit neovim as a whole
