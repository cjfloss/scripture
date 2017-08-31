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

namespace Scripture.Entities {

    using Scripture.Utils;
    using Gee;

    public class Chapter {

        public const string TABLE = "chapter";
        public int id;
        public int number;

        private int book_id;
        private Book _book;
        private bool book_state = false;
        public Book book {
            set {
                Query.update_int (TABLE, id, "book_id", value.id);
                book_id = value.id;
                book_state = false;
            }
            get {
                init_book ();
                return _book;
            }
        }

        public Chapter.selectById (int id) {
            var query = new Scripture.Utils.Query.selectById(TABLE, id);
            ArrayList<ArrayList<string>> results = query.execute ();
            if(results.size == 1){
                this.id = id;
                this.number = int.parse(results[0][1]);
                this.book_id = int.parse(results[0][2]);
            } else {
                stderr.printf ("Chapter (id: %i) not found!", id);
            }
        }

        public Chapter.selectByBookAndNum (Book book, int num) {
            ArrayList<Condition> where = new ArrayList<Condition>();
            where.add(new Condition.withInt("book_id", book.id));
            where.add(new Condition.withInt("number", num));
            var query = new Query.selectWhereEquals (TABLE, where);
            ArrayList<ArrayList<string>> results = query.execute ();
            if(results.size >= 1){
                this.id = int.parse(results[0][0]);
                this.number = int.parse(results[0][1]);
                this.book_id = int.parse(results[0][2]);
            } else {
                stderr.printf ("Chapter (book: %s num: %i) not found!", book.name, id);
            }
        }

        public Chapter.create (int num, Book book, InsertQuery query = new InsertQuery (TABLE)) {
            this.number = num;
            this.book_id = book.id;
            query.set_int("number", num);
            query.set_int("book_id", book_id);
            query.execute();
            this.id = query.last_id;
        }

        public ArrayList<Verse> getVerses () {
            ArrayList<Condition> where = new ArrayList<Condition>();
            where.add(new Condition.withInt("chapter_id", id));
            var query = new Scripture.Utils.Query.selectWhereEquals("verse", where);
            ArrayList<Verse> verses = new ArrayList<Verse>();
            ArrayList<ArrayList<string>> results = query.execute ();
            foreach (ArrayList<string> row in results) {
                verses.add(new Verse.withParams(int.parse(row[0]), int.parse(row[1]), row[2], int.parse(row[3]), int.parse(row[4])));
            }
            return verses;
        }

        private void init_book () {
            if (book_state == false) {
                _book = new Book.selectById (book_id);
                book_state = true;
            }
        }

    }
}
