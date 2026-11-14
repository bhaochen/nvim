# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

rm -r ~/.config/nvim
rm -r ~/.local/share/nvim

```bash
# 使用 lazyvim 的 extra 中的 dap.core 要装
sudo pacman -Syu
sudo pacman -S python-debugpy
```

```bash
# 使用环境在 kitty 的 fish 终端中
set -Ux GROQ_API_KEY ""
echo $GROQ_API_KEY
```

或者备份，但是如果 同步nvim配置后一直崩溃的时候需要把这些全删最好

mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

git clone https://github.com/bhaochen/nvim.git ~/.config/nvim
