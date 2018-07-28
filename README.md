# Personal . files
Some things I want to keep when working on a different computer. In particular,
my `.bashrc`, `.vimrc`, `.tmux.conf`, `.inputrc` and `.vim` folder (without the
`bundle` and `view` subfolders, which can be redownloaded using `vundle` and
are irrelevant to a new system respectively).

## .bashrc
Note that `bash` always looks for the `.bashrc` in the `~` directory, so it
is recommended (in order to easily keep the true `.bashrc` under version
control) to create a symlink i.e.

    ln -s /<abs_path_to_repo>/.bashrc /<absolute_path_to_home_dir>/.bashrc

Note it is important to use absolute paths to avoid symlink problems (not sure
why).

## Other files
For other files, you can generally set a non-default location to find them
in your `.bashrc`, however I think its easiest, as with the `.bashrc` itself,
to symlink them to `~`.

The `make_symlinks.sh` script automatically creates symlinks to `~` for

    .bashrc
    .vimrc
    .tmux_conf
    .inputrc
    .vim
