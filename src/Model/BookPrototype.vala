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

        public int id;
        public string name;

        public BookPrototype (int id, string name) {
            this.id = id;
            this.name = name;
        }

        public BookPrototype.selectByName (string name) {
            bool found = false;
            string[] prototypes = Scripture.Entities.BOOKPROTOTYPES;
            for (int i = 0; i < prototypes.length; i++) {
                if (prototypes[i] == name) {
                    found = true;
                    this.id = i+1;
                    this.name = prototypes[i];
                }
            }
            if (found == false) {
                stderr.printf ("Prototype (name: %s) not found!", name);
            }
        }

        public BookPrototype.selectById (int id) {
            string[] prototypes = Scripture.Entities.BOOKPROTOTYPES;
            if (prototypes.length >= id) {
                this.id = id;
                this.name = prototypes[id-1];
            } else {
                stderr.printf ("Prototype (id: %i) not found!", id);
            }
        }

        public static ArrayList<BookPrototype> selectAll () {
            string[] prototypes = Scripture.Entities.BOOKPROTOTYPES;
            ArrayList<BookPrototype> output = new ArrayList<BookPrototype> ();
            for (int i = 0; i < prototypes.length; i++) {
                output.add (new BookPrototype (i+1, prototypes[i]));
            }
            return output;
        }

    }

    public const string[] BOOKPROTOTYPES = {
        "Genesis",
        "Exodus",
        "Leviticus",
        "Numbers",
        "Deuteronomy",
        "Joshua",
        "Judges",
        "Ruth",
        "1 Samuel",
        "2 Samuel",
        "1 Kings",
        "2 Kings",
        "1 Chronicles",
        "2 Chronicles",
        "Ezra",
        "Nehemiah",
        "Esther",
        "Job",
        "Psalms",
        "Proverbs",
        "Ecclesiastes",
        "Song of Solomon",
        "Isaiah",
        "Jeremiah",
        "Lamentations",
        "Ezekiel",
        "Daniel",
        "Hosea",
        "Joel",
        "Amos",
        "Obadiah",
        "Jonah",
        "Micah",
        "Nahum",
        "Habakkuk",
        "Zephaniah",
        "Haggai",
        "Zechariah",
        "Malachi",
        "Matthew",
        "Mark",
        "Luke",
        "John",
        "Acts",
        "Romans",
        "1 Corinthians",
        "2 Corinthians",
        "Galatians",
        "Ephesians",
        "Philippians",
        "Colossians",
        "1 Thesalonians",
        "2 Thesalonians",
        "1 Timothy",
        "2 Timothy",
        "Titus",
        "Philemon",
        "Hebrews",
        "James",
        "1 Peter",
        "2 Peter",
        "1 John",
        "2 John",
        "3 John",
        "Jude",
        "Revelation"
    };
}
