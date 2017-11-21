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
namespace Scripture.Dialogs {

    using Scripture.Widgets;
    using Scripture.Controllers;

    public class Translations : Gtk.Dialog {

        private TranslationsList list;

        construct {
            title = "Translations";
            set_default_size (630, 430);
            resizable = false;
            deletable = true;

            create_layout();
        }

        public Translations (Gtk.Window parent) {
            Object (transient_for: parent);
            get_style_context ().add_class ("translations-dialog");
        }

        private void create_layout () {
            var main_grid = new Gtk.Grid ();

            var select_button = new Gtk.Button.with_label ("Select");
            select_button.get_style_context ().add_class ("suggested-action");
            select_button.clicked.connect (() => {
                var item = (TranslationItem) list.list.get_selected_row ().get_child ();
                var position = ReadingPosition.get_instance ();
                position.primary_bible = item.bible;
                position.position_selected ();
                this.destroy ();
            });

            var delete_button = new Gtk.Button.with_label ("Delete");
            delete_button.get_style_context ().add_class ("destructive-action");
            delete_button.clicked.connect (() => {
                var item = (TranslationItem) list.list.get_selected_row ().get_child ();
                var bible = item.bible;
                if (!item.selected) {
                    var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (
                         "Delete translation",
                         "Are you sure you want to delete "+bible.name+"?",
                         "edit-delete",
                         Gtk.ButtonsType.CANCEL
                    );

                    var suggested_button = new Gtk.Button.with_label ("Delete");
                    suggested_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
                    message_dialog.add_action_widget (suggested_button, Gtk.ResponseType.ACCEPT);

                    message_dialog.show_all ();
                    if (message_dialog.run () == Gtk.ResponseType.ACCEPT) {
                        list.list.get_selected_row ().destroy ();
                        bible.delete ();
                    }
                    message_dialog.destroy ();
                } else {
                    var message_dialog2 = new Granite.MessageDialog.with_image_from_icon_name (
                         "Item in use",
                         "You cant delete "+bible.name+" because it's in use.",
                         "edit-delete",
                         Gtk.ButtonsType.CANCEL
                    );
                    message_dialog2.run ();
                    message_dialog2.destroy ();
                }

            });

            var import_button = new Gtk.Button.with_label ("Import");
            import_button.clicked.connect (() => {
                Gtk.FileChooserDialog chooser = new Gtk.FileChooserDialog (
                    "Select your favorite file", this, Gtk.FileChooserAction.OPEN,
                    "_Cancel",
                    Gtk.ResponseType.CANCEL,
                    "_Open",
                    Gtk.ResponseType.ACCEPT
                );
                Gtk.FileFilter filter = new Gtk.FileFilter ();
        		chooser.set_filter (filter);
        		filter.add_mime_type ("text/xml");
                chooser.show_all ();
                if (chooser.run () == Gtk.ResponseType.ACCEPT) {
                    stdout.printf("Soubor vybrán "+chooser.get_uri()+"\n");
                }
                chooser.destroy ();
            });

            var button_box = new Gtk.ButtonBox (Gtk.Orientation.HORIZONTAL);
            button_box.set_spacing (5);
            button_box.set_layout (Gtk.ButtonBoxStyle.END);
            button_box.margin = 12;
            button_box.margin_bottom = 0;
            button_box.pack_end (import_button);
            button_box.pack_end (delete_button);
            button_box.pack_end (select_button);


            var settings_grid = new Gtk.Grid ();
            settings_grid.get_style_context ().add_class ("translation-list");
            settings_grid.margin_end = settings_grid.margin_start = 10;
            add_content (settings_grid);
            main_grid.attach (settings_grid, 0, 0, 1, 1);
            main_grid.attach (button_box, 0, 1, 1, 1);

            ((Gtk.Box) get_content_area ()).pack_start (main_grid);
        }

        private void add_content (Gtk.Grid grid) {
            list = new TranslationsList ();
            grid.attach (list, 0, 0, 1, 1);
        }
    }
}
