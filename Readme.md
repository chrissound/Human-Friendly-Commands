# Linux Command Lib

## What problem does this solve?
It's just a collection of verbose commands that abstract away all the more complicated commands.

For example to zip the contents of the current directory it's just `makeZip` instead of `zip -r filename.zip .`, and `makeOwnedByMyself filename` instead of `sudo chown $USER:$USER -R filname`.

If you use this with FZF, you only can fuzzily search for a command. For example `mz` for `MakeZip`.

## Demo
![Alt text](input.gif?raw=true "Demonstration")

## Dependencies:
- fzf

## Installation: 
Add `commands.sh` to your PATH. The functions and aliases will then be availble in your command prompt.

ZSH keybindng (bind `cat ~/Projects/LinuxCommandLib/commands.txt | fzf --height 25%` to `CTRL-Z`):

```
fzf-linuxlib-widget() {
	command=`cat ~/Projects/LinuxCommandLib/commands.txt | fzf --height 25%`
  RBUFFER=${RBUFFER}${command}
  zle redisplay
	zle end-of-line;
}

zle     -N   fzf-linuxlib-widget
bindkey '' fzf-linuxlib-widget
```
