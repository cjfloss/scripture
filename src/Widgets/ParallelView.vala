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

    using BibleNow.Entities;
    using Gee;

    public class ParallelView : Gtk.Paned {

        public BibleReadView readview1;
        public BibleReadView readview2;

        public ParallelView () {
            Object(orientation: Gtk.Orientation.HORIZONTAL);
            readview1 = new BibleNow.Widgets.BibleReadView ();
            readview2 = new BibleNow.Widgets.BibleReadView ();
            var box1 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            var box2 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            var toolbar1 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            var toolbar2 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            var combo1 = new Gtk.ComboBox ();
            var combo2 = new Gtk.ComboBox ();
            combo1.margin = combo2.margin = 7;
            combo1.vexpand = combo2.vexpand = false;

            toolbar1.pack_start (combo1, false, false, 0);
            toolbar2.pack_start (combo2, false, false, 0);

            box1.pack_start(toolbar1, false, false);
            box2.pack_start(toolbar2, false, false);
            box1.pack_start(readview1);
            box2.pack_start(readview2);
            pack1(box1, true, false);
            pack2(box2, true, false);
        }
    }
}
