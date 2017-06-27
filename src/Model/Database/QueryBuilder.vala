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

    using Gee;

    public class Query {

        public Sqlite.Statement stmt;
        private string _query;
        private string query {
            set {
                prepare (value);
                _query = value;
            }
            get {
                return _query;
            }
        }

        public Query (string query) {
            this.query = query;
        }

        public Query.selectById (string table, int id) { //BibleNow.Utils.Database db
            StringBuilder builder = new StringBuilder ();
            builder.printf("SELECT * FROM %s WHERE id=$BID;", table);
            query = builder.str;
            int param_position = stmt.bind_parameter_index ("$BID");
            stmt.bind_int (param_position, id);
        }

        public Query.selectWhereEquals (string table, ArrayList<Condition> conditions, string subject = "*") { //BibleNow.Utils.Database db
            string where = "";
            foreach (Condition c in conditions) {
                where += c.get_condition() + " AND ";
            }
            if (where.length > 5){
                where = where[0:where.length - 5];
            }
            StringBuilder builder = new StringBuilder ();
            builder.printf("SELECT %s FROM %s WHERE %s", subject, table, where);
            query = builder.str;
            foreach (Condition c in conditions) {
                int param_position = stmt.bind_parameter_index (c.get_param ());
                if (c.numeric){
                    stmt.bind_int (param_position, c.ival);
                } else {
                    stmt.bind_text (param_position, c.sval);
                }
            }
        }

        public Query.selectWhere (string table, string where) { //BibleNow.Utils.Database db
            StringBuilder builder = new StringBuilder ();
            builder.printf("SELECT * FROM %s WHERE %s;\n", table, where);
            this.query = builder.str;
        }

        public Query.selectAll (string table) { //BibleNow.Utils.Database db
            StringBuilder builder = new StringBuilder ();
            builder.printf("SELECT * FROM %s;\n", table);
            this.query = builder.str;
        }

        public ArrayList<ArrayList<string>> execute () {
            int cols = stmt.column_count ();
            ArrayList<ArrayList<string>> result = new ArrayList<ArrayList<string>>();
        	while (stmt.step () == Sqlite.ROW) {
                ArrayList<string> vals = new ArrayList<string> ();
        		for (int i = 0; i < cols; i++) {
        			vals.add (stmt.column_text (i) ?? "<none>");
        		}
                result.add (vals);
        	}
            stmt.reset ();
            return result;
        }

        private void prepare (string qry) {
            int state;
        	if ((state = Database.connection.prepare_v2 (qry, qry.length, out stmt)) == 1) {
        		stderr.printf ("Prepare error: %d: %s\n", Database.connection.errcode (), Database.connection.errmsg ());
        	}else{
            }
        }

        private static Sqlite.Statement prepare_stmt (string qry) {
            Sqlite.Statement stm;
            int state;
        	if ((state = Database.connection.prepare_v2 (qry, qry.length, out stm)) == 1) {
        		stderr.printf ("Prepare error: %d: %s\n", Database.connection.errcode (), Database.connection.errmsg ());
        	}else{
            }
            return stm;
        }

        public static void update_int (string table, int id, string column, int num){
            StringBuilder builder = new StringBuilder ();
            builder.printf("UPDATE %s SET %s = $VAL WHERE id = $ID;", table, column);
            Sqlite.Statement stm = prepare_stmt (builder.str);
            int val_pos = stm.bind_parameter_index ("$VAL");
            stm.bind_int (val_pos, num);
            int id_pos = stm.bind_parameter_index ("$ID");
            stm.bind_int (id_pos, id);
            stm.step ();
            stm.reset ();
        }

        public static void update_string (string table, int id, string column, string val){
            StringBuilder builder = new StringBuilder ();
            builder.printf("UPDATE %s SET %s = $VAL WHERE id = $ID;", table, column);
            Sqlite.Statement stm = prepare_stmt (builder.str);
            int val_pos = stm.bind_parameter_index ("$VAL");
            stm.bind_text (val_pos, val);
            int id_pos = stm.bind_parameter_index ("$ID");
            stm.bind_int (id_pos, id);
            stm.step ();
            stm.reset ();
        }
    }

    public class InsertQuery {

        private string table;
        private HashMap<string, int> ints;
        private HashMap<string, string> strings;
        private ArrayList<string> names;
        public int last_id;

        private Sqlite.Statement stmt;
        private bool is_prepared = false;

        public InsertQuery (string table) {
            this.table = table;
            names = new ArrayList<string> ();
            ints = new HashMap<string, int> ();
            strings = new HashMap<string, string> ();
        }

        public void set_int (string name, int val) {
            if(is_prepared && !names.contains (name)){
                stderr.printf("You can't add new names after first execution of the query.");
            }else{
                if (!names.contains (name)) {
                    names.add(name);
                }
                ints.set (name, val);
            }
        }
        public void set_string (string name, string val) {
            names.add(name);
            strings.set (name, val);
        }

        public string get_query () {
            string params = "";
            string pnames = "";
            foreach (string name in names) {
                pnames += name + ", ";
                params += "$" + name.up() + ", ";
            }
            pnames = pnames[0:pnames.length - 2];
            params = params[0:params.length - 2];

            StringBuilder builder = new StringBuilder ();
            builder.printf ("INSERT INTO %s (%s) VALUES (%s);", table, pnames, params);
            return builder.str;
        }



        public void execute () {

            // Create Sqlite.Statement object
            prepare ();

            // Bind parameters
            foreach (string name in names) {
                if(ints.has_key(name)){
                    int int_val = ints.get (name);
                    int param_pos = stmt.bind_parameter_index ("$" + name.up());
                    stmt.bind_int (param_pos, int_val);
                } else {
                    string str_val = strings.get (name);
                    int param_pos = stmt.bind_parameter_index ("$" + name.up());
                    stmt.bind_text (param_pos, str_val);
                }
            }

            stmt.step ();
            stmt.reset ();
            ints = new HashMap<string, int> ();
            strings = new HashMap<string, string> ();
            last_id = int.parse(Database.connection.last_insert_rowid ().to_string ());
        }

        private void prepare () {
            if(!is_prepared){
                string query = get_query ();
                int state;

                if ((state = Database.connection.prepare_v2 (query, query.length, out stmt)) == 1) {
                    stderr.printf ("Prepare error: %d: %s\n", Database.connection.errcode (), Database.connection.errmsg ());
                }else{
                    is_prepared = true;
                }
            }
        }

    }

    public class Condition {
        public string name;
        public string sval;
        public int ival;
        public bool numeric = false;

        public Condition (string name, string sval) {
            this.name = name;
            this.sval = sval;
        }
        public Condition.withInt (string name, int ival) {
            this.name = name;
            this.ival = ival;
            numeric = true;
        }
        public string get_condition () {
            return name + " = $" + name.up();
        }
        public string get_param () {
            return "$" + name.up();
        }
    }
}
