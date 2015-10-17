My Emacs config. (I do mostly Javascript programming)

Setup
-----

    $ # delete existing ~/.emacs.d if it exists
    $ git clone git@github.com:saltycrane/emacs.git ~/.emacs.d
    $ cd ~/.emacs.d
    $ ./setup.sh <path to python executable>

Javascript setup
----------------
http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html

    $ npm install -g eslint babel-eslint eslint-plugin-react


Usage
-----
Keybindings to remember:

Text:
M-^ join line with previous line
M-\ delete horizontal space

Programming:
C-M-\ indent region
M-; comment region
