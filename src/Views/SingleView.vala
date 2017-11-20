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

namespace Scripture.Views {

    using Scripture.Entities;
    using Scripture.Controllers;
    using Scripture.Widgets;
    using Gee;

    public class SingleView : Gtk.Bin {

        public ReadingArea readingArea;

        construct {
            readingArea = new ReadingArea ();
            add(readingArea);
        }

        public SingleView () {
            ReadingPosition position = ReadingPosition.get_instance ();
            position.position_selected.connect (() => {
                loadChapter (position.book, position.chapter);
            });
        }

        private void loadChapter (BookPrototype prototype, int num) {
            bool cont = true;
            Book? book = null;
            Chapter? chapter = null;
            try {
                book = new Book.selectByBibleAndPrototype (ReadingPosition.get_instance ().primary_bible, prototype);
            } catch (BookNotFoundError err) {
                readingArea.throw_error ("Book "+prototype.name+" not found in this translation.");
                cont = false;
            }
            if (cont) {
                try {
                    chapter = new Chapter.selectByBookAndNum (book, num);
                } catch (ChapterNotFoundError err) {
                    readingArea.throw_error ("Chapter not found in this translation.");
                    cont = false;
                }
            }
            if (cont) {
                readingArea.content = chapter.getVerses ();
            }
        }
    }
}
