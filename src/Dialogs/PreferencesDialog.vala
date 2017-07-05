/* BibleNow - Desktop Bible reading app that works offline
 * Copyright (C) 2017  Jan Marek <janmarek28@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public class BibleNow.Dialogs.Preferences : Gtk.Dialog {

    construct {
        title = "Preferences";
        set_default_size (630, 430);
        resizable = false;
        deletable = false;

        create_layout ();
    }

    public Preferences (Gtk.Window parent) {
        if (parent != null) {
            set_transient_for (parent);
        }
    }

    private void create_layout () {
        var main_grid = new Gtk.Grid ();

        var close_button = new Gtk.Button.with_label ("Close");
        close_button.clicked.connect (() => {this.destroy ();});

        var button_box = new Gtk.ButtonBox (Gtk.Orientation.HORIZONTAL);
        button_box.set_layout (Gtk.ButtonBoxStyle.END);
        button_box.pack_end (close_button);
        button_box.margin = 12;
        button_box.margin_bottom = 0;
        button_box.pack_end (close_button);

        var settings_grid = new Gtk.Grid ();
        settings_grid.margin_end = settings_grid.margin_start = 10;
        add_options (settings_grid);
        main_grid.attach (settings_grid, 0, 0, 1, 1);
        main_grid.attach (button_box, 0, 1, 1, 1);
        ((Gtk.Container) get_content_area ()).add (main_grid);
    }

    private void add_options (Gtk.Grid grid) {

        var view_mode_label = new Gtk.Label ("Parallel mode");
        var view_mode_switch = new Gtk.Switch ();
        add_switch (grid, 1, view_mode_label, view_mode_switch);

        var theme_label = new Gtk.Label ("Theme");
        var theme_combo = new Gtk.ComboBox ();
        add_switch (grid, 2, theme_label, theme_combo);
    }

    private void add_switch (Gtk.Grid grid, int num, Gtk.Label label, Gtk.Widget gswitch) {
        label.set_xalign (1.0f);
        gswitch.margin_start = 7;
        label.margin_top = label.margin_bottom = gswitch.margin_top = gswitch.margin_bottom = 5;
        grid.attach (label, 0, (num-1), 1, 1);
        var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        box.pack_start (gswitch, false, false);
        grid.attach (box, 1, (num-1), 1, 1);
    }

}
