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

    using Gee;
    using Scripture.Utils;

    public class Book {

        public Scripture.Utils.Transaction transaction;

        public const string TABLE = "book";
        public int id;
        public string name;
        private int prototype_id;
        private int bible_id;
        private BookPrototype _prototype;
        private bool prototype_state = false;
        public BookPrototype prototype {
            set {
                Query.update_int (TABLE, id, "prototype_id", value.id);
                prototype_id = value.id;
                prototype_state = false;
            }
            get {
                init_prototype ();
                return _prototype;
            }
        }
        private Bible _bible;
        private bool bible_state = false;
        public Bible bible {
            set {
                Query.update_int (TABLE, id, "bible_id", value.id);
                bible_id = value.id;
                bible_state = false;
            }
            get {
                init_bible ();
                return _bible;
            }
        }

        public Book.create (string name, BookPrototype prototype, Bible bible, InsertQuery query = new InsertQuery (TABLE)) {
            this.name = name;
            this.prototype_id = prototype.id;
            this.bible_id = bible.id;

            query.set_string("name", name);
            query.set_int("prototype_id", prototype_id);
            query.set_int("bible_id", bible_id);
            query.execute();
            this.id = query.last_id;
        }

        public Book.withParams (int id, string name, int prototype_id, int bible_id) { // Not finished, should parse more params
            this.id = id;
            this.name = name;
            this.prototype_id = prototype_id;
            this.bible_id = bible_id;
        }

        public Book.selectByBibleAndPrototype (Bible bible, BookPrototype prototype) throws BookNotFoundError {
            ArrayList<Condition> where = new ArrayList<Condition>();
            where.add(new Condition.withInt("bible_id", bible.id));
            where.add(new Condition.withInt("prototype_id", prototype.id));
            var query = new Query.selectWhereEquals (TABLE, where);
            ArrayList<ArrayList<string>> results = query.execute ();
            if(results.size >= 1){
                this.id = int.parse(results[0][0]);
                this.name = results[0][1];
                this.prototype_id = int.parse(results[0][2]);
                this.bible_id = int.parse(results[0][3]);
            } else {
                throw new BookNotFoundError.CODE_1A ("Book not found");
            }
        }

        public Book.selectById (int id) {
            var query = new Scripture.Utils.Query.selectById(TABLE, id);
            ArrayList<ArrayList<string>> results = query.execute ();
            if(results.size == 1){
                this.id = id;
                this.name = results[0][1];
                this.prototype_id = int.parse(results[0][2]);
                this.bible_id = int.parse(results[0][3]);
            } else {
                stderr.printf ("Book (id: %i) not found!", id);
            }
        }

        public int getChapterCount () {
            ArrayList<Condition> where = new ArrayList<Condition> ();
            where.add (new Condition.withInt ("book_id", id));
            var query = new Query.selectWhereEquals ("chapter", where, "MAX(number)");
            var results = query.execute ();
            if (results.size > 0) {
                return int.parse(results[0][0]);
            } else {
                return 0;
            }
        }

        public static ArrayList<Book> selectAll () {
            var query = new Scripture.Utils.Query.selectAll(TABLE);
            ArrayList<Book> books = new ArrayList<Book>();
            ArrayList<ArrayList<string>> results = query.execute ();
            foreach (ArrayList<string> row in results) {
                books.add(new Book.withParams(int.parse(row[0]), row[1], int.parse(row[2]), int.parse(row[3])));
            }
            return books;
        }

        private void init_bible () {
            if (bible_state == false) {
                _bible = new Bible.selectById (bible_id);
                bible_state = true;
            }
        }

        private void init_prototype () {
            if (prototype_state == false) {
                _prototype = new BookPrototype.selectById (prototype_id);
                prototype_state = true;
            }
        }
/*
        public static ArrayList<Book> selectByBible (Bible bible) {

            StringBuilder builder = new StringBuilder();
            builder.printf("booktype_id = %i", bible.id);
            string where = builder.str;

            var query = new Scripture.Utils.Query.selectWhere(TABLE, where);
            ArrayList<Book> books = new ArrayList<Book>();
            ArrayList<ArrayList<string>> results = query.execute ();
            foreach (ArrayList<string> row in results) {
                books.add(new Book.withParams(int.parse(row[0]), row[1]));
            }
            return books;
        }

        public void update (string name, string val) {
            QueryBuilder.update (table, id, name, val);
        }
*/
    }

    errordomain BookNotFoundError {
        CODE_1A
    }
}
