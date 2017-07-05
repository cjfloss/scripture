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

namespace BibleNow.Widgets {

    using Gee;

    class SettingsCombo : Gtk.ComboBox {

        public signal void selected (int selection);
        private int current = 0;
        private Gtk.ListStore liststore;
        private Gtk.TreeIter iter;
        Gtk.CellRendererText cell;

        private int _selection;
        public int selection {
            set {
                _selection = value;
                set_active (value);
            }
            get {
                return _selection;
            }
        }

        public SettingsCombo () {
            liststore = new Gtk.ListStore (1, typeof (string));
            set_model (liststore);

		    cell = new Gtk.CellRendererText ();
            pack_start (cell, false);
            set_attributes (cell, "text", 0);
            set_active (0);
            load_event_settings ();
        }

        public void fill (string*[] values) {
            for(int i = 0; i < values.length; i++){
                add_value (values[i]);
            }
        }

        public void bind_setting (string name) {
            this.bind_property("active", BibleNow.Settings.get_instance (), name, GLib.BindingFlags.BIDIRECTIONAL);
        }

        public void add_value (string val) {
            liststore.append (out iter);
			liststore.set (iter, 0, val);
            current++;
        }

        private void load_event_settings () {
            this.changed.connect (() => {
                this.selected (this.active);
                _selection = this.active;
    		});
        }
    }
}
