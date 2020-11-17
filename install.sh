#!/bin/sh

# Required Vala to C compiler, GTK3 library, GtkSourceView (devel) and GCC.
sudo valac --pkg gtk+-3.0 --pkg gtksourceview-4 --pkg vte-2.91 ./src/FileOperations.vala ./src/CommandParser.vala ./src/Terminal.vala ./src/Settings.vala ./src/CodeFad.vala -o /bin/codefad

sudo mkdir /usr/share/pixmaps/codefad/
sudo cp resource/*.png /usr/share/pixmaps/codefad/
sudo cp codefad.desktop /usr/share/applications/
