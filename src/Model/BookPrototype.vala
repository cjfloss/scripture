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
        public int chapter_count;

        public BookPrototype (int id, string name, int chapter_count) {
            this.id = id;
            this.name = name;
            this.chapter_count = chapter_count;
        }

        public BookPrototype.selectByName (string name) {
            bool found = false;
            string[] prototypes = Scripture.Entities.BOOKPROTOTYPES;
            int[] chaptercounts = Scripture.Entities.CHAPTERNUMS;
            for (int i = 0; i < prototypes.length; i++) {
                if (prototypes[i] == name) {
                    found = true;
                    this.id = i+1;
                    this.name = prototypes[i];
                    this.chapter_count = chaptercounts[i];
                }
            }
            if (found == false) {
                stderr.printf ("Prototype (name: %s) not found!", name);
            }
        }

        public BookPrototype.selectById (int id) {
            string[] prototypes = Scripture.Entities.BOOKPROTOTYPES;
            int[] chaptercounts = Scripture.Entities.CHAPTERNUMS;
            if (prototypes.length >= id) {
                this.id = id;
                this.name = prototypes[id-1];
                this.chapter_count = chaptercounts[id-1];
            } else {
                stderr.printf ("Prototype (id: %i) not found!", id);
            }
        }

        public static ArrayList<BookPrototype> selectAll () {
            string[] prototypes = Scripture.Entities.BOOKPROTOTYPES;
            int[] chaptercounts = Scripture.Entities.CHAPTERNUMS;
            ArrayList<BookPrototype> output = new ArrayList<BookPrototype> ();
            for (int i = 0; i < prototypes.length; i++) {
                output.add (new BookPrototype (i+1, prototypes[i], chaptercounts[i]));
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

    public const int[] CHAPTERNUMS = {
        50, 40, 27, 36, 34, 24, 21, 4, 31, 24, 22, 25, 29, 36, 10, 13, 10, 42, 150, 31, 12, 8, 66, 52, 5, 48, 12, 14, 3, 9, 1, 4, 7, 3, 3, 3, 2, 14, 4, 28, 16, 24, 21, 28, 16, 16, 13, 6, 6, 4, 4, 5, 3, 6, 4, 3, 1, 13, 5, 5, 3, 5, 1, 1, 1, 22
    };
}
