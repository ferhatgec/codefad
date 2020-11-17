
/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

public class FadTerminal {
	public void init_fadterminal(Vte.Terminal terminal, Gtk.Frame frame) {
		terminal.cursor_blink_mode = Vte.CursorBlinkMode.ON;
		terminal.cursor_shape = Vte.CursorShape.BLOCK;
		terminal.input_enabled = true;
		terminal.allow_bold = true;

		Gdk.RGBA background = Gdk.RGBA();
		background.parse("#2d2d2d");

		Gdk.RGBA foreground = Gdk.RGBA();
		foreground.parse("#ffffff");
		terminal.set_colors(foreground,background,null);
	
		unowned string arg = GLib.Environment.get_variable("SHELL");
		
		try {
			terminal.spawn_sync(
				Vte.PtyFlags.DEFAULT, 
				null, 
				{ arg }, 
				null,
				SpawnFlags.DO_NOT_REAP_CHILD,
				null,
				null,
				null);
			} catch (Error e) {
				stderr.printf("Error: %s\n", e.message);
			}

		frame.show_all();
		terminal.grab_focus();
	}
}
