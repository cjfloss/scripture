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
namespace BibleNow.Utils {
    public class Transaction {

        private Transaction () { //Database db
        }

        public static void begin () {
            string query = "BEGIN;";
            string errmsg;
        	int ec = Database.connection.exec (query, null, out errmsg);
        	if (ec != Sqlite.OK) {
        		stderr.printf ("Exec error (begin): %s\n", errmsg);
        	}
        }

/*
        public static void update (string table, int id, string name, string val) {
            StringBuilder builder = new StringBuilder ();
            builder.printf("UPDATE %s SET %s = '%s' WHERE id = %i;\n", table, name, val, id);
            string query = builder.str;
            stdout.printf("Executing: \n------------\n%s", query);
        }
*/
        public static void commit () {
            string query = "COMMIT;";
            string errmsg;
        	int ec = Database.connection.exec (query, null, out errmsg);
        	if (ec != Sqlite.OK) {
        		stderr.printf ("Exec error (commit): %s\n", errmsg);
        	}
        }
    }
}
