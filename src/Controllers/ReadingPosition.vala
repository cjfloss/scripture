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

namespace Scripture.Controllers {

    using Scripture.Entities;

    class ReadingPosition {
        private static ReadingPosition? instance = null;

        public bool empty_app = true;
        public Bible? primary_bible = null;
        public Bible? secondary_bible = null;
        public BookPrototype? next_book = null;
        public BookPrototype? book = null;
        public int? chapter = null;

        public signal void reseted ();
        public signal void book_selected ();
        public signal void position_selected ();

        public static ReadingPosition get_instance () {
            if (instance == null) {
                instance = new ReadingPosition ();
            }
            return instance;
        }

        private ReadingPosition () {
            var bibles = Bible.selectAll ();
            if (bibles.size > 0) {
                secondary_bible = primary_bible = bibles.get(0);
                empty_app = false;
            }
            book = new BookPrototype.selectById (1);
            select_book(book);
            chapter = 1;
        }

        public void reset () {
            next_book = book;
            reseted ();
        }

        public void select_book (BookPrototype prototype) {
            next_book = prototype;
            book_selected ();
        }

        public void select_chapter (int num) {
            chapter = num;
            book = next_book;
            position_selected ();
        }
    }
}
