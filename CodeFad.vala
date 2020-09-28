/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

/* Import GTK */
using Gtk;

public class CodeFad : Gtk.Application {
	protected override void activate () {
		/* Create application window */
		var window = new Gtk.ApplicationWindow (this);
		
		/* Create variable as label */
		var label = new Gtk.Label ("Hello CodeFad!");
		
		/* Add label (center position) */
		window.add (label);

		/* Set title */
		window.set_title ("CodeFad");

		/* Set Default size */
		window.set_default_size (900, 550);
		
		/* Show */
		window.show_all ();
	}
}

/* Main */
public int main (string[] args) {
	return new CodeFad ().run (args);
}