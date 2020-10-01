#!/bin/sh

# Required Vala to C compiler, GTK3 library, GtkSourceView (devel) and GCC.
valac --pkg gtk+-3.0 --pkg gtksourceview-4 Settings.vala CodeFad.vala -o /bin/codefad 

mkdir /usr/share/pixmaps/codefad/
cp resource/*.png /usr/share/pixmaps/codefad/
cp codefad.desktop /usr/share/applications/
