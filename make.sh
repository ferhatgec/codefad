#!/bin/sh

# Required Vala to C compiler, GTK3 library, GtkSourceView (devel) and GCC.
valac --pkg gtk+-3.0 --pkg gtksourceview-4 ./src/FileOperations.vala ./src/CommandParser.vala ./src/Settings.vala ./src/CodeFad.vala -o codefad

sudo mkdir /usr/share/pixmaps/codefad/
sudo cp resource/*.png /usr/share/pixmaps/codefad/
sudo cp codefad.desktop /usr/share/applications/
