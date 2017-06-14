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

namespace BibleNow.Widgets {

    public class ChapterSelect : Gtk.ToggleButton {

        public signal void value_updated (int val);

        private int _selection;
        public ChapterSelectPopover popover;

        public int selection {
            set {
                _selection = value;
                this.set_label (_selection.to_string());
            }
            get { return _selection; }
        }

        public ChapterSelect () {

            selection = 1;
            popover = new BibleNow.Widgets.ChapterSelectPopover (this);
            get_style_context ().add_class ("chapter-select-button");
            bind_property ("active", popover, "visible", GLib.BindingFlags.BIDIRECTIONAL);
            popover.max = 37;

            this.value_updated.connect ((v) => {
                selection = v;
                this.set_active (false);
            });
        }
    }

    public class ChapterSelectPopover : Gtk.Popover {

        private Gtk.ScrolledWindow scroll;
        private Gtk.Grid grid;
        private int _max;
        private int max_rows = 8;
        private int row = 35;
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
            max = 39;

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
            double maxf = (double) max;
            int rows = (int) (maxf / 5.0);
            int output = ((rows+1) * row);
            if (output <= (max_rows*row)){
                return output;
            } else {
                return max_rows*row+15;
            }
        }

        private void reloadNumers (int max) {

            grid.forall ((element) => grid.remove (element));
            scroll.min_content_height = countHeight (max);

            for (int i = 0; (i * 5) < max; i++){
                for (int j = 0; j < 5 && j < (max - (i * 5)); j++){
                    int num = i*5+j+1;
                    var option = new ChapterSelectItem (num);
                    grid.attach (option, j, i);
                    option.item_selected.connect ((n) => {
                        this.btn.value_updated (n);
                    });
                }
            }
        }
    }

    public class ChapterSelectItem : Gtk.Button {

        public signal void item_selected (int v);

        private int _val;
        public int val {
            set {
                _val = value;
                this.set_label (_val.to_string ());
            }
            get { return _val; }
        }

        public ChapterSelectItem (int num){

            val = num;
            get_style_context ().add_class ("chapter-select-item");


            this.clicked.connect(() => {
                this.item_selected (this.val);
            });
        }
    }
}
