
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
	
	/* Buttons */
	Gtk.Button openButton;
    Gtk.Button saveButton;
	Gtk.Button menuButton;

	public GLib.Menu menu_model { get; set; }
	
	private TextView text_view;
	private File file;
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
		openButton = new Gtk.Button.from_icon_name("document-open", Gtk.IconSize.LARGE_TOOLBAR);
		saveButton = new Gtk.Button.with_label("Save");
		menuButton = new Gtk.Button.from_icon_name("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);

		/* Title. */
		headerBar.set_title(title);

		/* Set subtitle with variable */
		headerBar.set_subtitle("Programming for everyone, everytime.");

		/* Show close button */
		headerBar.set_show_close_button (true);

		/* Append */
		headerBar.pack_start(openButton);
		headerBar.pack_end(menuButton);
		headerBar.pack_end(saveButton);
		
		/* Set new bar */
		this.set_titlebar(headerBar);

		/* Icon of button */
        var open_icon = new Gtk.Image.from_icon_name ("document-open", 
            IconSize.SMALL_TOOLBAR);
        
		/* Action */
        openButton.clicked.connect(on_open_clicked);
		saveButton.clicked.connect(on_save_clicked);

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
		/* FileChooser */
        Gtk.FileChooserDialog chooser = new Gtk.FileChooserDialog (
                "Select a file to edit", this, Gtk.FileChooserAction.OPEN,
                "_Cancel",
                Gtk.ResponseType.CANCEL,
                "_Open",
                Gtk.ResponseType.ACCEPT);
            chooser.set_select_multiple (false);
            chooser.run ();
            chooser.close ();
            
			/* Check */
			if (chooser.get_file () != null) {
                file = chooser.get_file ();

                try {
                    uint8[] contents;
                    string etag_out;
                    file.load_contents (null, out contents, out etag_out);

					/* Append contents to buffer of text view */
                    text_view.buffer.text = (string) contents;
                } catch (Error e) {
                    stdout.printf ("Error: %s\n", e.message);
                }
            }
    }

	/* Action */
    private void on_save_clicked () {
        if (file != null) {
            try {
				/* Replace */
                file.replace_contents (text_view.buffer.text.data, null, false, FileCreateFlags.NONE, null);
            } catch (Error e) {
            	stdout.printf ("Error: %s\n", e.message);
        	}
    	}
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