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

    unowned string DB_CREATE = """

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

    INSERT INTO prototype (ord, name)
    VALUES
        (1, "Genesis"),
        (2, "Exodus"),
        (3, "Leviticus"),
        (4, "Numbers"),
        (5, "Deuteronomy"),
        (6, "Joshua"),
        (7, "Judges"),
        (8, "Ruth"),
        (9, "1 Samuel"),
        (10, "2 Samuel"),
        (11, "1 Kings"),
        (12, "2 Kings"),
        (13, "1 Chronicles"),
        (14, "2 Chronicles"),
        (15, "Ezra"),
        (16, "Nehemiah"),
        (17, "Esther"),
        (18, "Job"),
        (19, "Psalms"),
        (20, "Proverbs"),
        (21, "Ecclesiastes"),
        (22, "Song of Solomon"),
        (23, "Isaiah"),
        (24, "Jeremiah"),
        (25, "Lamentations"),
        (26, "Ezekiel"),
        (27, "Daniel"),
        (28, "Hosea"),
        (29, "Joel"),
        (30, "Amos"),
        (31, "Obadiah"),
        (32, "Jonah"),
        (33, "Micah"),
        (34, "Nahum"),
        (35, "Habakkuk"),
        (36, "Zephaniah"),
        (37, "Haggai"),
        (38, "Zechariah"),
        (39, "Malachi"),
        (40, "Matthew"),
        (41, "Mark"),
        (42, "Luke"),
        (43, "John"),
        (44, "Acts"),
        (45, "Romans"),
        (46, "1 Corinthians"),
        (47, "2 Corinthians"),
        (48, "Galatians"),
        (49, "Ephesians"),
        (50, "Philippians"),
        (51, "Colossians"),
        (52, "1 Thesalonians"),
        (53, "2 Thesalonians"),
        (54, "1 Timothy"),
        (55, "2 Timothy"),
        (56, "Titus"),
        (57, "Philemon"),
        (58, "Hebrews"),
        (59, "James"),
        (60, "1 Peter"),
        (61, "2 Peter"),
        (62, "1 John"),
        (63, "2 John"),
        (64, "3 John"),
        (65, "Jude"),
        (66, "Revelation");
    """;
}
