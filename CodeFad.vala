
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

	/* Menu & Menu Item */
	GLib.Menu menu = new GLib.Menu ();
    GLib.MenuItem about = new GLib.MenuItem ("About", null);
	GLib.MenuItem saveAs = new GLib.MenuItem ("Save as..", null);
	
	/* Menu Popover */
	Gtk.Popover menu_popover;
	
	private SourceFile file;
	Gtk.Label label;

    private SourceView source_view;
    private Gtk.SourceLanguageManager language_manager;

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
		
        menu.append_item(saveAs);
		menu.append_item(about);

        language_manager = Gtk.SourceLanguageManager.get_default();

		/* Set new bar */
		this.set_titlebar(headerBar);

		/* Icon of button */
        var open_icon = new Gtk.Image.from_icon_name ("document-open", 
            IconSize.SMALL_TOOLBAR);
        
		menu_popover = new Gtk.Popover(menuButton);
        menu_popover.position = Gtk.PositionType.BOTTOM;
		menu_popover.set_size_request (256, -1);
		menu_popover.modal = false;
        menu_popover.bind_model (menu, null);
       
		/* Action */
        openButton.clicked.connect(on_open_clicked);
		saveButton.clicked.connect(on_save_clicked);
		menuButton.clicked.connect(on_menu_clicked);

		/* SourceView */
        this.source_view = new SourceView();
        this.source_view.set_wrap_mode (Gtk.WrapMode.WORD);
        this.source_view.buffer.text = "";
        this.language_manager = Gtk.SourceLanguageManager.get_default ();
		this.source_view.editable = true;
        this.source_view.cursor_visible = true;
		this.source_view.smart_backspace = true;
        this.source_view.left_margin = 0;
        this.source_view.right_margin = 0;
        //this.source_view.set_highlight_current_line(true);
        this.source_view.set_tab_width(4);
        this.source_view.set_show_line_numbers (true);

		/* Scroll */
        var scroll = new ScrolledWindow (null, null);
        scroll.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scroll.add (this.source_view);

        var vbox = new Box (Orientation.VERTICAL, 0);
        vbox.pack_start (scroll, true, true, 0);
        add (vbox);

        /* Connect */
        source_view.populate_popup.connect (on_populate_menu);
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
                file = new Gtk.SourceFile();
                file.location = chooser.get_file();

                var file_loader = new Gtk.SourceFileLoader(source_view.buffer as Gtk.SourceBuffer, file);
                
                try {
                    file_loader.load_async.begin(Priority.DEFAULT, null, null);
                } catch (Error e) {
                    stdout.printf ("Error: %s\n", e.message);
                }
            }
    }

	/* Action */
    private void on_save_clicked () {
        if (file != null) {
            var file_saver = new Gtk.SourceFileSaver(source_view.buffer as Gtk.SourceBuffer, file);
            try {
                file_saver.save_async.begin(Priority.DEFAULT, null, null);
            } catch (Error e) {
            	stdout.printf ("Error: %s\n", e.message);
        	}
    	}
    }

	private void on_menu_clicked() {
        menu_popover.set_visible (true);		
	}

    void on_populate_menu (Gtk.Menu menu) {
        var language_menu = new Gtk.MenuItem();
        var submenu = new Gtk.Menu ();

        language_menu.set_label ("Language");
        language_menu.set_submenu (submenu);

        /* Create the list of language items */
        unowned SList<Gtk.RadioMenuItem> group = null;
        Gtk.RadioMenuItem? item = null;

        /* Add an entry with No Language, or normal. */
        item = new Gtk.RadioMenuItem (group);
        
        item.set_label ("Normal Text");

        item.toggled.connect (() => {
           /* Normal text edit. */
           (source_view.buffer as Gtk.SourceBuffer).set_language (null);
        });

        submenu.add (item);

        /* Set the Language entries */
        var ids = language_manager.get_language_ids ();
        foreach (var id in ids) {
            var lang = language_manager.get_language (id);
            group = item.get_group ();
            item = new Gtk.RadioMenuItem (group);
            item.set_label (lang.name);

            submenu.add (item);
            item.toggled.connect (() => {
                (source_view.buffer as Gtk.SourceBuffer).set_language (lang);
            });

            // Active item
            if ((source_view.buffer as Gtk.SourceBuffer).language != null && id == (source_view.buffer as Gtk.SourceBuffer).language.id) {
                item.active = true;
            }
        }

        /* Add our Language selection menu to the menu provided in the callback */
        menu.add (language_menu);
        menu.show_all ();
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