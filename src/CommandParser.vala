/* MIT License
#
# Copyright (c) 2020-2021 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

class CommandParser {
	FileOperations _op;
	Settings _set;
	
	public string line;
	public string _data;
	
	string ReadAndChange(string _cmd, string _change_with) {
		File file = File.new_for_path (GLib.Environment.get_home_dir() + "/.config/codefad/settings_code.fad");
			 	StringBuilder build = new StringBuilder(); 
			
		try {
			FileInputStream @is = file.read ();
			DataInputStream dis = new DataInputStream (@is);
		
			while ((line = dis.read_line ()) != null) {
				if(line.contains(_cmd) == true) {
					build.append(_change_with + "\n");
				} else {
					build.append(line + "\n");
				}
			}
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}
		
		return build.str;
	}
		
	public void ChangeSettings(string _str, string _command) {
		File file = File.new_for_path (GLib.Environment.get_home_dir() + "/.config/codefad/settings_code.fad");
		string _str_ = ReadAndChange(_str, _command);

		print(_str_);
		try {
			file.replace_contents (_str_.data, null, false, FileCreateFlags.NONE, null);
		} catch(Error e) {
    	  	stderr.printf ("Error: %s\n", e.message);
		}
	 }
	  
	  public void GetCommand(string _command) {
	  	   if(_command.contains("tab_width: ") == true) {
	  	   		ChangeSettings("tab_width: ", _command);	  	   
		   } else if(_command.contains("show_line_numbers: ") == true) {
		   		ChangeSettings("show_line_numbers: ", _command);
		   } else if(_command.contains("left_margin: ") == true) {
		   		ChangeSettings("left_margin: ", _command);
		   } else if(_command.contains("right_margin: ") == true) {
		   		ChangeSettings("right_margin: ", _command);
		   } else if(_command.contains("highlight_current_line: ") == true) {
		   		ChangeSettings("highlight_current_line: ", _command);
		   }
	  }
	  
	  public void Apply(Gtk.SourceView view) {
	  	_set.SetAll(view);
	  }
}
