/* Scripture - Desktop Bible reading app that works offline
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
namespace Scripture.Widgets {

    using Scripture.Controllers;
    using Scripture.Entities;

    class TranslationItem : Gtk.Box {

        public bool selected;
        public bool secondary;

        public Bible bible;

        private Gtk.Label gtk_label;
        public Gtk.Image gtk_selected;

        public string label {
            set {
                label = value;
                gtk_label.set_text (value);
            }
            get {
                return label;
            }
        }

        public TranslationItem (Bible bbl) {
            Object (orientation: Gtk.Orientation.HORIZONTAL, spacing: 0);
            bible = bbl;

            width_request = 300;
            gtk_label = new Gtk.Label (bible.name);
            gtk_label.set_max_width_chars (30);
            gtk_label.set_xalign (0f);
            gtk_label.ellipsize = Pango.EllipsizeMode.END;
            gtk_label.margin_top = gtk_label.margin_bottom = 10;
            pack_start(gtk_label, true, true, 10);

            gtk_selected = new Gtk.Image ();
            pack_end(gtk_selected, false, false, 10);

            reload_selections ();
        }

        public void reload_selections () {
            ReadingPosition position = ReadingPosition.get_instance ();
            if(bible.id == position.primary_bible.id){
                select (true);
            } else if (bible.id == position.secondary_bible.id) {
                select_secondary (true);
            } else {
                select_secondary (false);
            }
        }

        private void select (bool val) {
            if(val) {
                gtk_selected.set_from_icon_name ("selection-checked", Gtk.IconSize.MENU);
                selected = true;
            } else {
                if (selected = true) {
                    gtk_selected.clear ();
                }
                selected = false;
            }
        }
        private void select_secondary (bool val) {
            if(val) {
                gtk_selected.set_from_icon_name ("selection-add", Gtk.IconSize.MENU);
                selected = false;
                secondary = true;
            } else {
                if (secondary = true) {
                    gtk_selected.clear ();
                }
                secondary = false;
            }
        }
    }
}
