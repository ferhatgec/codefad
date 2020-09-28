#!/bin/sh

# Required Vala to C compiler, GTK3 library and GCC.
valac --pkg gtk+-3.0 FileDialogs.vala CodeFad.vala -o codefad && ./codefad 