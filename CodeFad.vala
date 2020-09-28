
/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

/* Use Gtk namespace */
using Gtk;

/* CodeFad class */
public class CodeFad : Window {
	Gtk.HeaderBar headerBar = new Gtk.HeaderBar();
	Gtk.Button openButton;
    private TextView text_view;

	Gtk.Label label;

	/* show_all */
    public CodeFad () {
		/* Title */
        this.title = "CodeFad";
        
		/* Window pos. */
		this.window_position = WindowPosition.CENTER;
        
		/* Default window size */
		set_default_size (800, 500);

		/* Headerbar button */
		openButton = new Gtk.Button.from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR);

		/* Title. */
		headerBar.set_title(title);

		/* Set subtitle with variable */
		headerBar.set_subtitle("Programming for everyone, everytime.");

		/* Show close button */
		headerBar.set_show_close_button (true);

		/* Append */
		headerBar.pack_start (openButton);

		/* Set new bar */
		this.set_titlebar(headerBar);

		/* Icon of button */
        var open_icon = new Gtk.Image.from_icon_name ("document-open", 
            IconSize.SMALL_TOOLBAR);
        
		/* Action */
        openButton.clicked.connect (on_open_clicked);

		/* TextView */
        this.text_view = new TextView ();
		this.text_view.editable = true;
        this.text_view.cursor_visible = true;
		
		/* Scroll */
        var scroll = new ScrolledWindow (null, null);
        scroll.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scroll.add (this.text_view);

        var vbox = new Box (Orientation.VERTICAL, 0);
        vbox.pack_start (scroll, true, true, 0);
        add (vbox);
	}

	/* Action */
    private void on_open_clicked () {
        var file_chooser = new FileChooserDialog ("Open File", this,
                                      FileChooserAction.OPEN,
                                      "_Cancel", ResponseType.CANCEL,
                                      "_Open", ResponseType.ACCEPT);
        
		if (file_chooser.run () == ResponseType.ACCEPT) {
            open_file (file_chooser.get_filename ());
        }

        file_chooser.destroy ();
    }

    private void open_file (string filename) {
        try {
            string text;
            FileUtils.get_contents (filename, out text);
            this.text_view.buffer.text = text;
        } catch (Error e) {
            stderr.printf ("Error: %s\n", e.message);
        }
    }

    public static int main (string[] args) {
        Gtk.init (ref args);

        var window = new CodeFad ();
        window.destroy.connect (Gtk.main_quit);
        window.show_all ();

        Gtk.main ();
        return 0;
    }
}