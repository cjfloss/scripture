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
    using Gee;

    public class Language {

        private const string TABLE = "lang";
        public int id;
        public string name;

        public Language.create (string name, InsertQuery query = new InsertQuery (TABLE)) {
            this.name = name;
            query.set_string("name", name);
            query.execute();
            this.id = query.last_id;
        }

        public Language.selectByName (string name) {
            ArrayList<Condition> where = new ArrayList<Condition>();
            where.add(new Condition("name", name));
            var query = new Query.selectWhereEquals (TABLE, where);
            ArrayList<ArrayList<string>> results = query.execute ();
            if(results.size >= 1){
                this.id = int.parse(results[0][0]);
                this.name = results[0][1];
            } else {
                stderr.printf ("Language (name: %s) not found!", name);
            }
        }

        public Language.selectById (int id) {
            var query = new Query.selectById(TABLE, id);
            ArrayList<ArrayList<string>> results = query.execute ();
            if(results.size == 1){
                this.id = id;
                this.name = results[0][1];
            } else {
                stderr.printf ("Language (id: %i) not found!", id);
            }
        }

        private Language.withParams (int id, string name) {
            this.id = id;
            this.name = name;
        }

        public static ArrayList<Language> selectAll () {
            var query = new BibleNow.Utils.Query.selectAll(TABLE);
            ArrayList<Language> langs = new ArrayList<Language>();
            ArrayList<ArrayList<string>> results = query.execute ();
            foreach (ArrayList<string> row in results) {
                langs.add(new Language.withParams(int.parse(row[0]), row[1]));
            }
            return langs;
        }

    }
}
