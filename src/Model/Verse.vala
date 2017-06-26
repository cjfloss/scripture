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

namespace BibleNow.Entities {

    using BibleNow.Utils;

    public class Verse {

        public int id;
        public int number;
        public string content;
        public bool paragraph_end;
        private int chapter_id;
        private Chapter _chapter;
        private bool chapter_state = false;
        public Chapter chapter {
            set {
                Query.update_int (TABLE, id, "chapter_id", value.id);
                chapter_id = value.id;
                chapter_state = false;
            }
            get {
                init_chapter ();
                return _chapter;
            }
        }

        public const string TABLE = "verse";

        public Verse.create (int num, string content, Chapter chapter, bool paragraph_end = false, InsertQuery query = new InsertQuery (TABLE)) {
            this.number = num;
            this.content = content;
            this.chapter_id = chapter.id;
            query.set_int ("number", num);
            query.set_string ("content", content);
            query.set_int ("chapter_id", chapter_id);
            query.set_int ("paragraph_end", (paragraph_end?1:0));
            query.execute ();
            this.id = query.last_id;
        }

        public Verse.withParams (int id, int num, string content, int chapter_id, int paragraph_end) {
            this.id = id;
            this.number = num;
            this.content = content;
            this.chapter_id = chapter_id;
            this.paragraph_end = (paragraph_end==1);
        }

        private void init_chapter () {
            if (chapter_state == false) {
                _chapter = new Chapter.selectById (chapter_id);
                chapter_state = true;
            }
        }
    }
}
