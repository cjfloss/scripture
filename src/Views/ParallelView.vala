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

namespace BibleNow.Views {

    using BibleNow.Entities;
    using BibleNow.Widgets;
    using Gee;

    public class ParallelView : Gtk.Paned {

        public ReadingArea readingArea1;
        public ReadingArea readingArea2;
        public BibleSelect bibleSelect1;
        public BibleSelect bibleSelect2;
        private Gtk.Box toolbar1;
        private Gtk.Box toolbar2;
        private string theme_class = "black-white";

        construct {
            readingArea1 = new ReadingArea ();
            readingArea2 = new ReadingArea ();
            var box1 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            var box2 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            toolbar1 = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            toolbar2 = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            toolbar1.get_style_context ().add_class ("parallelview-toolbar");
            toolbar2.get_style_context ().add_class ("parallelview-toolbar");

            bibleSelect1 = new BibleSelect ();
            bibleSelect2 = new BibleSelect ();
            bibleSelect1.margin = bibleSelect2.margin = 7;

            toolbar1.set_center_widget (bibleSelect1);
            toolbar2.set_center_widget (bibleSelect2);

            box1.pack_start(toolbar1, false, false);
            box2.pack_start(toolbar2, false, false);
            box1.pack_start(readingArea1);
            box2.pack_start(readingArea2);
            pack1(box1, true, false);
            pack2(box2, true, false);
            set_background ();
        }

        public ParallelView () {
            Object(orientation: Gtk.Orientation.HORIZONTAL);
            BibleNow.Settings.get_instance ().changed.connect (() => {
                set_background ();
            });
        }

        private void set_background () {
            BibleNow.ViewTheme theme = BibleNow.ViewTheme.get_from_int ((int) BibleNow.Settings.get_instance ().theme);
            toolbar1.get_style_context ().remove_class (theme_class);
            toolbar2.get_style_context ().remove_class (theme_class);
            theme_class = theme.to_string ();
            toolbar1.get_style_context ().add_class (theme_class);
            toolbar2.get_style_context ().add_class (theme_class);
        }
    }
}
