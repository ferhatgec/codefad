/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

/* Import GTK */
using Gtk;

/* FileDialogs class */
public class FileDialogs : Gtk.Window {
    public FileDialogs () {
        /* Prepare Gtk.Window: */
        this.window_position = Gtk.WindowPosition.CENTER;
        this.destroy.connect (Gtk.main_quit);

        Gtk.Box vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 5);
        this.add (vbox);

        /* Create HeaderBar: */
        Gtk.HeaderBar hbar = new Gtk.HeaderBar ();
        hbar.set_title ("Open file");
        hbar.set_subtitle ("Select file.");

        /* HeaderBar Buttons */
        Gtk.Button cancel = new Gtk.Button.with_label ("Cancel");
        Gtk.Button select = new Gtk.Button.with_label ("Select");

        /* Add */
        hbar.pack_start (cancel);
        hbar.pack_end (select);

        /* Set titlebar */
        this.set_titlebar (hbar);

        /* Add a chooser: */
        Gtk.FileChooserWidget chooser = new Gtk.FileChooserWidget (Gtk.FileChooserAction.OPEN);
        vbox.pack_start (chooser, true, true, 0);

        /* Multiple files cannot be selected: */
        chooser.select_multiple = false;

        /* Add a preview widget: */
        Gtk.Image preview_area = new Gtk.Image ();
        chooser.set_preview_widget (preview_area);
        
        /* Is clicked */
        chooser.update_preview.connect (() => {
            string uri = chooser.get_preview_uri ();
            // We only display local files:
            if (uri.has_prefix ("file://") == true) {
                try {
                    /* Get icons of files/folders */
                    Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file (uri.substring (7));
                    Gdk.Pixbuf scaled = pixbuf.scale_simple (150, 150, Gdk.InterpType.BILINEAR);
                    preview_area.set_from_pixbuf (scaled);
                    preview_area.show ();
                } catch (Error e) {
                    preview_area.hide ();
                }
            } else {
                    preview_area.hide ();
            }
        });

        Gtk.Box hbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 5);
        vbox.pack_start(hbox, false, false, 0);

        /* Setup buttons callbacks */
        cancel.clicked.connect (() => {
            this.destroy ();
        });

        select.clicked.connect (() => {
            SList<string> uris = chooser.get_uris ();
            foreach (unowned string uri in uris) {
                /* Print directory */
                stdout.printf (" %s\n", uri);
            }

            /* Destroy */
            this.destroy ();
        });
    }
}