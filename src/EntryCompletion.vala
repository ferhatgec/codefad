/* MIT License
#
# Copyright (c) 2020-2021 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

public class EntryCompletion : Gtk.Window {
	private Gtk.ListStore liststore;
	private Gtk.EntryCompletion entrycompletion;
	
	private string line;

    public void EntryCompletion(Gtk.Entry entry) {
        liststore = new Gtk.ListStore(1, typeof(string));
	
		/* Default items */
        Gtk.TreeIter iter;

        File file = File.new_for_path (GLib.Environment.get_home_dir() + "/.config/codefad/settings_code.fad");

		try {
			FileInputStream @is = file.read ();
			DataInputStream dis = new DataInputStream (@is);
			
			while ((line = dis.read_line ()) != null) {
				liststore.append(out iter);
				liststore.set(iter, 0, line); 
			}
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}
        
        entrycompletion = new Gtk.EntryCompletion();
        entrycompletion.set_model(liststore);
        entrycompletion.set_text_column(0);
        entrycompletion.set_popup_completion(true);
        entry.set_completion(entrycompletion);
    }
}
