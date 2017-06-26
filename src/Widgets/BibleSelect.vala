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

    using Gee;
    using BibleNow.Entities;

    public class BibleSelect : Gtk.ToggleButton {

        public signal void selection (Bible bible);

        private BibleSelectPopover popover;
        private ArrayList<Bible> _bibles;
        public ArrayList<Bible> bibles {
            set {
                _bibles = value;
                popover.set_bibles (value);
                if(value.size > 0){
                    empty = false;
                    this.selected_bible = value[0];
                } else {
                    empty = true;
                }
            }
            get {
                return _bibles;
            }
        }
        private Bible _selected_bible;
        public Bible selected_bible {
            set {
                _selected_bible = value;
                this.selection (value);
                this.set_label (value.name);
            }
            get { return _selected_bible; }
        }
        private bool _empty;
        private bool empty {
            set {
                _empty = value;
                if(value){
                    set_label ("No bibles");
                    set_sensitive (false);
                } else {
                    set_sensitive (true);
                }
            }
            get{
                return _empty;
            }
        }

        construct {
            get_style_context ().add_class ("bible-select-button");
            popover = new BibleSelectPopover (this);
            bind_property ("active", popover, "visible", GLib.BindingFlags.BIDIRECTIONAL);
            empty = true;
        }

        public BibleSelect () {
            popover.select_bible.connect ((bible) => {
                selected_bible = bible;
                this.set_active (false);
            });
        }
    }

    public class BibleSelectPopover : Gtk.Popover {

        public signal void select_bible (Bible bible);
        private Gtk.Box box;
        private Gtk.ScrolledWindow scroll;
        private BibleSelect btn;

        construct {
            get_style_context ().add_class ("bible-select-popover");
            box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            scroll = new Gtk.ScrolledWindow (null, null);
            scroll.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scroll.vscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            scroll.min_content_height = 100;
            scroll.margin_top = scroll.margin_bottom = 4;
            add (scroll);
            scroll.add (box);
        }

        public BibleSelectPopover (BibleSelect btn) {
            this.btn = btn;
            set_relative_to (btn);

            btn.toggled.connect (() => {
			    if (btn.active) {
				    this.show_all ();
			    }
		    });
        }

        public void set_bibles (ArrayList<Bible> bibles) {
            box.forall ((element) => box.remove (element));
            foreach (Bible bible in bibles){
                var item = new BibleSelectItem (bible, this);
                box.pack_start (item, false, false, 0);
            }
        }
    }

    public class BibleSelectItem : Gtk.Button {

        private Bible _bible;
        public Bible bible {
            set {
                _bible = value;
                this.set_label (value.name);
            }
            get {
                return _bible;
            }
        }

        construct {
            get_style_context ().add_class ("bible-select-item");
        }

        public BibleSelectItem (Bible bible, BibleSelectPopover popover) {
            this.bible = bible;
            this.clicked.connect(() => {
                popover.select_bible(this.bible);
            });
        }
    }
}
