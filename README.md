# ExodimacsSync

This tool helps keeping the configuration files versioned. It takes all the stuff from `.emacs.d/exodimacs` and the `.emacs.d/init.el` and syncs them with a repository. 

## Tutorial

Build the tool with `dmd main.d` and put it on your path. The first time you run the tool it will ask you for the location of your `.emacs.d` directory and your repository directory. You have to use absolute paths and don't forget the trailing `/` on your paths, otherwise you'll get crashes before the program even runs.

After you've installed and initialized everything, just run:
```
$ exodimacssync
```
and the repository is up to date and ready to commit and push.

## Roadmap

This tool currently only works from `.emacs.d` -> repository. So you need a working installation of exodimacs. But the next thing I want to implement is the opposite direction repository -> `.emacs.d`. Finally I want to implement some kind of installer that makes it even easiert to install.

- [X] Sync from `.emacs.d` to repository.
- [ ] Sync from repository to `.emacs.d`.
- [ ] Installer mode that does everything on its own.
