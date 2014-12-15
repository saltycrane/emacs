My Emacs config. (I do mostly Python programming)

JS files need jshist installed.

Setup
-----

    $ # delete existing ~/.emacs.d if it exists
    $ git clone git@github.com:saltycrane/emacs.git ~/.emacs.d
    $ cd ~/.emacs.d
    $ ./setup.sh <path to python executable>

Usage
-----
Keybindings to remember:

Movement:
M-b recenter text (normally C-l)

Text:
M-^ join line with previous line
M-\ delete horizontal space

Programming:
C-M-\ indent region
M-; comment region
