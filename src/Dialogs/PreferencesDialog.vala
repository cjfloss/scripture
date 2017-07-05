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
        Object (transient_for: parent);
    }

    private void create_layout () {
        var main_grid = new Gtk.Grid ();

        var close_button = new Gtk.Button.with_label ("Close");
        close_button.clicked.connect (() => {this.destroy ();});

        var button_box = new Gtk.ButtonBox (Gtk.Orientation.HORIZONTAL);
        button_box.set_layout (Gtk.ButtonBoxStyle.END);
        button_box.margin = 12;
        button_box.margin_bottom = 0;
        button_box.pack_end (close_button);

        var settings_grid = new Gtk.Grid ();
        settings_grid.margin_end = settings_grid.margin_start = 10;
        add_options (settings_grid);
        main_grid.attach (settings_grid, 0, 0, 1, 1);
        main_grid.attach (button_box, 0, 1, 1, 1);

        ((Gtk.Box) get_content_area ()).pack_start (main_grid);
    }

    private void add_options (Gtk.Grid grid) {

        var view_mode_label = new Gtk.Label ("Parallel mode");
        var view_mode_switch = new Gtk.Switch ();
        view_mode_switch.active = BibleNow.Settings.get_instance ().parallel_mode;
        view_mode_switch.bind_property("active", BibleNow.Settings.get_instance (), "parallel_mode", GLib.BindingFlags.BIDIRECTIONAL);
        add_item (grid, 1, view_mode_label, view_mode_switch);

        var verse_mode_label = new Gtk.Label ("One verse per line");
        var verse_mode_switch = new Gtk.Switch ();
        verse_mode_switch.active = BibleNow.Settings.get_instance ().verse_mode;
        verse_mode_switch.bind_property("active", BibleNow.Settings.get_instance (), "verse_mode", GLib.BindingFlags.BIDIRECTIONAL);
        add_item (grid, 2, verse_mode_label, verse_mode_switch);

        var theme_label = new Gtk.Label ("Theme");
        var theme_combo = new BibleNow.Widgets.SettingsCombo ();
        theme_combo.fill (BibleNow.VIEW_THEME_COMBOTEXT);
        theme_combo.selection = BibleNow.Settings.get_instance ().theme;
        theme_combo.bind_setting ("theme");
        add_item (grid, 3, theme_label, theme_combo, true);

        var nummode_label = new Gtk.Label ("Display numbers");
        var nummode_combo = new BibleNow.Widgets.SettingsCombo ();
        nummode_combo.fill (BibleNow.NUM_MODE_COMBOTEXT);
        nummode_combo.selection = BibleNow.Settings.get_instance ().num_mode;
        nummode_combo.bind_setting ("num_mode");
        add_item (grid, 4, nummode_label, nummode_combo, true);

        var fontsize_label = new Gtk.Label ("Font size");
        var fontsize_spin = new Gtk.SpinButton.with_range (12.0, 20.0, 1.0);
        fontsize_spin.value = BibleNow.Settings.get_instance ().font_size;
        fontsize_spin.bind_property("value", BibleNow.Settings.get_instance (), "font_size", GLib.BindingFlags.BIDIRECTIONAL);
        add_item (grid, 5, fontsize_label, fontsize_spin);
    }

    private void add_item (Gtk.Grid grid, int num, Gtk.Label label, Gtk.Widget item, bool stretch = false) {
        label.set_xalign (1.0f);
        item.margin_start = 7;
        label.margin_top = label.margin_bottom = item.margin_top = item.margin_bottom = 5;
        grid.attach (label, 0, (num-1), 1, 1);
        if (stretch){
            grid.attach (item, 1, (num-1), 1, 1);
        } else {
            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            box.pack_start (item, false, false);
            grid.attach (box, 1, (num-1), 1, 1);
        }
    }
}
