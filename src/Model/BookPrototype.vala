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

    public class BookPrototype {

        public const string TABLE = "prototype";
        public int id;
        public int order;
        public string name;

        public BookPrototype.create (string name, int order, InsertQuery query = new InsertQuery (TABLE)) {
            this.name = name;
            this.order = order;

            query.set_string("name", name);
            query.set_int("ord", order);
            query.execute();
            this.id = query.last_id;
        }

        public BookPrototype.selectByName (string name) {
            ArrayList<Condition> where = new ArrayList<Condition>();
            where.add(new Condition("name", name));
            var query = new Query.selectWhereEquals (TABLE, where);
            ArrayList<ArrayList<string>> results = query.execute ();
            if(results.size >= 1){
                this.id = int.parse(results[0][0]);
                this.name = results[0][1];
                this.order = int.parse(results[0][2]);
            } else {
                stderr.printf ("Prototype (name: %s) not found!", name);
            }
        }

        public BookPrototype.selectById (int id) {
            var query = new Query.selectById(TABLE, id);
            ArrayList<ArrayList<string>> results = query.execute ();
            if(results.size == 1){
                this.id = id;
                this.name = results[0][1];
                this.order = int.parse(results[0][2]);
            } else {
                stderr.printf ("Prototype (id: %i) not found!", id);
            }
        }

        public BookPrototype.withParams (int id, string name, int order) {
            this.id = id;
            this.name = name;
            this.order = order;
        }

        public static ArrayList<BookPrototype> selectAll () {
            var query = new Query.selectAll(TABLE);
            ArrayList<BookPrototype> prototypes = new ArrayList<BookPrototype>();
            ArrayList<ArrayList<string>> results = query.execute ();
            foreach (ArrayList<string> row in results) {
                prototypes.add(new BookPrototype.withParams(int.parse(row[0]), row[1], int.parse(row[2])));
            }
            return prototypes;
        }

    }
}
