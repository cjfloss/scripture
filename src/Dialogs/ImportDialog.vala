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

namespace Scripture.Dialogs {

    using Scripture.Controllers;
    using Scripture.Entities;

    class Import : Gtk.Dialog {

        construct {
            title = "Importing";
            set_default_size (630, 430);
            resizable = false;
            deletable = true;


        }

        public Import (string file_uri) {

            var doc = Xml.Parser.parse_file (file_uri);
            if (doc == null) {
                stdout.printf("Not found!");
	        }
            Xml.XPath.Context cntx = new Xml.XPath.Context (doc);
            Xml.XPath.Object* res = cntx.eval_expression ("/XMLBIBLE/INFORMATION/title");
            if (res != null) {
                Xml.Node* node = res->nodesetval->item (0);
                Bible bible = new Bible.create (node->get_content (), new Language.selectByName ("English"));
            } else {
                stdout.printf("Not found2!");
            }
        }
    }
}
