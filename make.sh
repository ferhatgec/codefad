#!/bin/sh

# Required Vala to C compiler, GTK3 library, GtkSourceView (devel) and GCC.
valac --pkg gtk+-3.0 --pkg gtksourceview-4 ./src/FileOperations.vala ./src/Settings.vala ./src/CodeFad.vala -o codefad

./codefad 

