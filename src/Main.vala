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

public class Scripture.Application : Granite.Application {

    public Application () {
        Object (application_id: "scripture.app",
        flags: ApplicationFlags.FLAGS_NONE);
    }

    protected override void activate () {
        var app_window = new Scripture.Window (this);
        this.add_window (app_window);
    }

    public static int main (string[] args) {

        string conf_dir = GLib.Environment.get_user_config_dir ()+"/scripture";
        if(!FileUtils.test (conf_dir, FileTest.IS_DIR)){
            try {
        		File file = File.new_for_path (GLib.Environment.get_user_config_dir ()+"/scripture");
        		file.make_directory ();
        	} catch (Error e) {
        		stdout.printf ("Unable to create conf dir. Error: %s\n", e.message);
        	}
        }

        var app = new Scripture.Application ();
        return app.run (args);
    }


}
