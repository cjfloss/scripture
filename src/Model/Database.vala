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

    public class Database {

        private static bool connected = false;
        public const string NAME = "mydb.db";
        private static Sqlite.Database _connection;
        public static Sqlite.Database connection {
            get {
                if (!connected) {
                    try{
                    open ();
                    }catch(FileError e){
                        stderr.printf("error loading db");
                    }
                }
                return _connection;
            }
        }

        private Database () {
        }

        private static string get_db_path () {
            string conf_dir =  GLib.Environment.get_user_config_dir ()+"/biblenow/";
            return conf_dir+Database.NAME;
        }

        public static void open () throws FileError {
            int state;
            if ((state = Sqlite.Database.open_v2 (get_db_path(), out _connection)) == 1) {
                stderr.printf("DB connection error!\n");
                throw new FileError.ACCES ("Can't open database: "+_connection.errmsg ());
            } else {
                connected = true;
                stdout.printf("Database connection success at %s! :)\n", get_db_path());
            }

            if (!FileUtils.test (get_db_path(), FileTest.IS_REGULAR)) {
                stderr.printf("Err: Database file not created!\n");
            }

            string query = """
                DROP TABLE IF EXISTS lang;
                DROP TABLE IF EXISTS bible;
                DROP TABLE IF EXISTS book;
                DROP TABLE IF EXISTS prototype;
                DROP TABLE IF EXISTS chapter;
                DROP TABLE IF EXISTS verse;

                CREATE TABLE lang (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL
                );
                CREATE TABLE bible (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL,
                    lang_id INT NOT NULL
                );
                CREATE TABLE book (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL,
                    prototype_id INT NOT NULL,
                    bible_id INT NOT NULL
                );
                CREATE TABLE prototype (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL,
                    ord INT NOT NULL
                );
                CREATE TABLE chapter (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    number INT NOT NULL,
                    book_id INT NOT NULL
                );
                CREATE TABLE verse (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    number INT NOT NULL,
                    content TEXT NOT NULL,
                    chapter_id INT NOT NULL,
                    paragraph_end BOOLEAN DEFAULT 0
                );
        	""";
            stdout.printf("Execution attemp: %s\n", query);
            string errmsg;
        	int ec = connection.exec (query, null, out errmsg);
        	if (ec != Sqlite.OK) {
        		stderr.printf ("Create error: %s\n", errmsg);
        	}
        }

    }

}
