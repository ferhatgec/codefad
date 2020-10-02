
/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */

public class FileOperations {
	public string line;
	
    public string GetStringFromFile(string _file, string _str) { 	
		File file = File.new_for_path (_file);

		try {
			FileInputStream @is = file.read ();
			DataInputStream dis = new DataInputStream (@is);
			
			while ((line = dis.read_line ()) != null) {
				if(line.contains(_str) == true) {
					return line;
				}
			}
		} catch (Error e) {
			print ("Error: %s\n", e.message);
		}

		return line;
    }
}	
