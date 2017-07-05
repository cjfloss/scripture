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
    using BibleNow.Entities;

    public class AppMenu : Gtk.ToggleButton {

        private Gtk.Window window;

        construct {

            Gtk.Popover menuPopover = new Gtk.Popover (this);
            bind_property ("active", menuPopover, "visible", GLib.BindingFlags.BIDIRECTIONAL);
            menuPopover.set_position (Gtk.PositionType.BOTTOM);
            menuPopover.get_style_context ().add_class ("app-menu");
            this.toggled.connect (() => {
                if (this.active) {
                    menuPopover.show_all ();
                }
            });
            Gtk.Box appMenu = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            var translationsItem =  new Gtk.Button.with_label ("Bible translations");
            Gtk.Label label1 = (Gtk.Label) translationsItem.get_child ();
            label1.set_xalign (0);

            var preferencesItem = new Gtk.Button.with_label ("Preferences");
            Gtk.Label label2 = (Gtk.Label) preferencesItem.get_child ();
            label2.set_xalign (0);

            appMenu.pack_start (translationsItem);
            appMenu.pack_start (preferencesItem);
            menuPopover.add (appMenu);

            translationsItem.activate.connect (() => {
                this.openTranslations ();
            });
            preferencesItem.clicked.connect (() => {
                this.openPreferences ();
            });
        }

        public AppMenu (Gtk.Window window)  {
            this.window = window;
            Gtk.Image icon = new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
            this.set_image (icon);
        }

        private void openTranslations () {

        }

        private void openPreferences () {
            var preferences = new BibleNow.Dialogs.Preferences (window);
            preferences.show_all ();
            this.set_active (false);
        }
    }
}
