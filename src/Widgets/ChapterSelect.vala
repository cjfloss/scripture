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

namespace Scripture.Widgets {

    public class ChapterSelect : Gtk.ToggleButton {

        public signal void selection (int val);

        private ChapterSelectPopover popover;
        private bool _empty;
        private bool empty {
            set {
                _empty = value;
                if(value){
                    set_label ("-");
                    set_sensitive (false);
                } else {
                    set_sensitive (true);
                }
            }
            get{
                return _empty;
            }
        }
        private int _selected_num;
        public int selected_num {
            set {
                _selected_num = value;
                selection (value);
                this.set_label (_selected_num.to_string());
            }
            get { return _selected_num; }
        }

        public ChapterSelect () {

            popover = new Scripture.Widgets.ChapterSelectPopover (this);
            get_style_context ().add_class ("chapter-select-button");
            bind_property ("active", popover, "visible", GLib.BindingFlags.BIDIRECTIONAL);
            empty = true;

            this.selection.connect (() => {
                this.set_active (false);
            });
        }

        public void set_chapters (int num) {
            if (num > 0){
                empty = false;
                popover.max = num;
                selected_num = 1;
            } else {
                empty = true;
            }

        }
    }

    public class ChapterSelectPopover : Gtk.Popover {

        private Gtk.ScrolledWindow scroll;
        private Gtk.Grid grid;
        private int _max;
        private int rows_limit = 8;
        private int row_height = 35;
        private ChapterSelect btn;

        public int max {
            set {
                _max = value;
                this.reloadNumers (_max);
            }
            get { return _max; }
        }

        public ChapterSelectPopover (ChapterSelect btn) {

            this.btn = btn;
            set_relative_to (btn);
            set_position (Gtk.PositionType.BOTTOM);

            get_style_context ().add_class ("chapter-select-popover");

            scroll = new Gtk.ScrolledWindow (null, null);
            scroll.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scroll.vscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            scroll.margin_top = scroll.margin_bottom = 10;
            grid = new Gtk.Grid ();
            max = 0;

            grid.margin_start = grid.margin_end = 12;
            scroll.add (grid);
            this.add (scroll);

            btn.toggled.connect (() => {
			    if (btn.active) {
				    this.show_all ();
			    }
		    });
        }

        private int countHeight (int max) {
            double maxd = (double) max;
            int rows = (int) Math.ceil (maxd / 5.0);
            int output = rows * row_height;
            if (output <= (rows_limit*row_height)){
                return output;
            } else {
                return rows_limit*row_height+15;
            }
        }

        private void reloadNumers (int max) {

            grid.forall ((element) => grid.remove (element));
            scroll.min_content_height = countHeight (max);

            for (int i = 0; (i * 5) < max; i++){
                for (int j = 0; j < 5 && j < (max - (i * 5)); j++){
                    int num = i*5+j+1;
                    var option = new ChapterSelectItem (num, btn);
                    grid.attach (option, j, i);
                }
            }
        }
    }

    public class ChapterSelectItem : Gtk.Button {

        private int _val;
        public int val {
            set {
                _val = value;
                this.set_label (_val.to_string ());
            }
            get { return _val; }
        }

        public ChapterSelectItem (int num, ChapterSelect btn){

            val = num;
            get_style_context ().add_class ("chapter-select-item");


            this.clicked.connect(() => {
                btn.selected_num = this.val;
            });
        }
    }
}
