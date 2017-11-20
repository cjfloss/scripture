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

class Scripture.Settings : Granite.Services.Settings {
    private static Settings? instance = null;

    public bool parallel_mode { get; set; }
    public bool verse_mode { get; set; }
    public int theme { get; set; }
    public int num_mode { get; set; }
    public double font_size { get; set; }

    public static Settings get_instance () {
        if (instance == null) {
            instance = new Settings ();
        }
        return instance;
    }

    private Settings () {
        base ("com.github.jendamarek.scripture");
    }
}
