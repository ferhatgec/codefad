
/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

public class Settings {
	FileOperations _operations = new FileOperations();
	
	public void Write() {
		if(_operations.IsExist(GLib.Environment.get_home_dir() + "/.config/codefad") == false) {
			_operations.CreateDirectory(GLib.Environment.get_home_dir() + "/.config/codefad");
		}

		if(_operations.IsExist(GLib.Environment.get_home_dir() + "/.config/codefad/settings_code.fad") == false) {
		    _operations.CreateFile(GLib.Environment.get_home_dir() + "/.config/codefad/settings_code.fad", "tab_width: 4\nshow_line_numbers: true\nleft_margin: 0\nright_margin: 0\n");
		}
	}
	
    public void SetAll(Gtk.SourceView source_view) {
		string tab_width = _operations.GetStringFromFile(GLib.Environment.get_home_dir() + "/.config/codefad/settings_code.fad", "tab_width: ");
		string left_margin = _operations.GetStringFromFile(GLib.Environment.get_home_dir() + "/.config/codefad/settings_code.fad", "left_margin: ");
		string right_margin = _operations.GetStringFromFile(GLib.Environment.get_home_dir() + "/.config/codefad/settings_code.fad", "right_margin: ");
		string show_line_numbers = _operations.GetStringFromFile(GLib.Environment.get_home_dir() + "/.config/codefad/settings_code.fad", "show_line_numbers: ");
		
		bool _line_numbers = true;

		/* Erase commands */		
		tab_width = tab_width.replace("tab_width: ", "");
		left_margin = left_margin.replace("left_margin: ", "");
		right_margin = right_margin.replace("right_margin: ", "");
		show_line_numbers = show_line_numbers.replace("show_line_numbers: ", "");
		
		if(show_line_numbers == "false") {
			_line_numbers = false;
		}
		
		/* SourceView */
        source_view.set_wrap_mode (Gtk.WrapMode.WORD);
        source_view.buffer.text = "";
		source_view.editable = true;
        source_view.cursor_visible = true;
		source_view.smart_backspace = true;
        source_view.left_margin = int.parse(left_margin);
        source_view.right_margin = int.parse(right_margin);
        //source_view.set_highlight_current_line(true);
        source_view.set_tab_width(int.parse(tab_width));
        source_view.set_show_line_numbers (_line_numbers);
    }
}
