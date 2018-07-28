DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
LOC=(.bashrc .vimrc .vim .tmux.conf .inputrc)

for i in ${LOC[@]}; do
    echo "Making symlink for $DIR/$i to $HOME/$i"
    ln -sf $DIR/$i $HOME/$i
done
