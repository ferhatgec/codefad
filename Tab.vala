/* MIT License
#
# Copyright (c) 2020 Ferhat Geçdoğan All Rights Reserved.
# Distributed under the terms of the MIT License.
#
# */


using Gtk;

/* Tab class */
public class Tab : Window {
    public Widget create_notebook_child() {
        var child = new ScrolledWindow (null, null);
        child.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        child.add ( new TextView() );
        return child;
    }

    /* With close button */
    public Widget create_notebook_child_label(string text) {
        var label = new Label(text);

        var image = new Image.from_stock("gtk-close", IconSize.MENU);

        var button = new Button();
        button.relief = ReliefStyle.NONE;
        button.name = "sample-close-tab-button";
        // don't allow focus on this button
        button.set_focus_on_click(false);
        button.add(image);

    
        var hbox = new HBox(false, 2);
        hbox.pack_start(label, false, false ,0);
        hbox.pack_start(button, false, false ,0);
        hbox.show_all();

        return hbox;
    }
}