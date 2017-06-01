#Linux Command Lib

![Alt text](input.gif?raw=true "Demonstration")

Dependencies:
fzf

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
