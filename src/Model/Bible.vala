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

    public class Bible {

        public Scripture.Utils.Transaction transaction;

        public const string TABLE = "bible";
        public int id;
        public string name;
        private int lang_id;
        private Language _language;
        private bool language_state = false;
        public unowned Language language {
            set {
                Query.update_int (TABLE, id, "lang_id", value.id);
                lang_id = value.id;
                language_state = false;
            }
            get {
                init_language ();
                return _language;
            }
        }

        public Bible.create (string name, Language lang, InsertQuery query = new InsertQuery (TABLE)) {
            this.name = name;
            this.lang_id = lang.id;
            query.set_string("name", name);
            query.set_int("lang_id", lang_id);
            query.execute();
            this.id = query.last_id;
        }

        private Bible.withParams (int id, string name, int lang_id) {
            this.id = id;
            this.name = name;
            this.lang_id = lang_id;
        }

        public Bible.selectById (int id) {
            var query = new Scripture.Utils.Query.selectById(TABLE, id);
            ArrayList<ArrayList<string>> results = query.execute ();
            if(results.size == 1){
                this.id = id;
                this.name = results[0][1];
                this.lang_id = int.parse(results[0][2]);
            } else {
                stderr.printf ("Bible (id: %i) not found!", id);
            }
        }

        public static ArrayList<Bible> selectAll () {
            var query = new Scripture.Utils.Query.selectAll(TABLE);
            ArrayList<Bible> bibles = new ArrayList<Bible>();
            ArrayList<ArrayList<string>> results = query.execute ();
            foreach (ArrayList<string> row in results) {
                bibles.add(new Bible.withParams(int.parse(row[0]), row[1], int.parse(row[2])));
            }
            return bibles;
        }

        public void delete () {
            Query.delete_by_id (Bible.TABLE, this.id);
        }

        public ArrayList<Book> getBooks () {
            ArrayList<Condition> where = new ArrayList<Condition>();
            where.add(new Condition.withInt("bible_id", id));
            var query = new Scripture.Utils.Query.selectWhereEquals("book", where);
            ArrayList<Book> books = new ArrayList<Book>();
            ArrayList<ArrayList<string>> results = query.execute ();
            foreach (ArrayList<string> row in results) {
                books.add(new Book.withParams(int.parse(row[0]), row[1], int.parse(row[2]), int.parse(row[3])));
            }
            return books;
        }

        private void init_language () {
            if (language_state == false) {
                _language = new Language.selectById (lang_id);
                language_state = true;
            }
        }
    }
}
