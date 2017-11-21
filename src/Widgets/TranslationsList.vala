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

    class TranslationsList : Gtk.ScrolledWindow {

        public Gtk.ListBox list;

        construct {
            list = new Gtk.ListBox ();
            list.vexpand = false;
            list.width_request = 350;
            this.set_policy (Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC);
            add (list);
        }

        public TranslationsList () {
            Object(
                min_content_width: 350,
                min_content_height: 300
            );

            Gee.ArrayList<Bible> bibles = Bible.selectAll ();
            int s = 0;
            int i = 0;
            foreach (Bible tran in bibles) {
                var item = new TranslationItem(tran);
                list.add(item);
                if (tran.id == ReadingPosition.get_instance ().primary_bible.id){
                    s = i;
                }
                i++;
            }

            list.select_row (list.get_row_at_index (s));

        }

    }
}
