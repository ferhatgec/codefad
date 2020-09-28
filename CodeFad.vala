/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

/* Import GTK */
using Gtk;

public class CodeFad : Gtk.Application {
	/* Initialize */
	public CodeFad() {
		Object (
			application_id: "com.fegeya.codefad",
			flags: ApplicationFlags.FLAGS_NONE
		);
	}

	public void SetHeaderBar(string title, string sub_title, Gtk.ApplicationWindow window) {
		/* Create header bar */
		Gtk.HeaderBar headerBar = new Gtk.HeaderBar();
		
		/* Set title with variable */
		headerBar.set_title(title);

		/* Set subtitle with variable */
		headerBar.set_subtitle(sub_title);

		/* Show close button */
		headerBar.set_show_close_button (true);

		/* Set as titlebar */
		window.set_titlebar(headerBar);
	} 

	protected override void activate () {
		/* Create application window */
		var window = new Gtk.ApplicationWindow (this);
		
		SetHeaderBar("CodeFad", "Code editor for everyone", window);
		
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