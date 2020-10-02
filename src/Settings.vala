
/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

public class Settings {
    public void SetAll(Gtk.SourceView source_view) {
        /* SourceView */
        source_view.set_wrap_mode (Gtk.WrapMode.WORD);
        source_view.buffer.text = "";
		source_view.editable = true;
        source_view.cursor_visible = true;
		source_view.smart_backspace = true;
        source_view.left_margin = 0;
        source_view.right_margin = 0;
        //source_view.set_highlight_current_line(true);
        source_view.set_tab_width(4);
        source_view.set_show_line_numbers (true);
    }
}