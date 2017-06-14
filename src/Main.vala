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

public class BibleNow.Application : Granite.Application {

    public Application () {
        Object (application_id: "biblenow.app",
        flags: ApplicationFlags.FLAGS_NONE);
    }

    protected override void activate () {
        var app_window = new BibleNow.Window (this);
        this.add_window (app_window);
    }

    public static int main (string[] args) {
        var app = new BibleNow.Application ();
        return app.run (args);
    }


}
