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

    using Gee;
    using Scripture.Entities;

    public class BookSelect : Gtk.ToggleButton {

        public signal void selection (BookPrototype prototype);

        private BookSelectPopover popover;

        private ArrayList<BookPrototype> _prototypes;
        public ArrayList<BookPrototype> prototypes {
            set {
                _prototypes = value;
                popover.set_prototypes (value);
                if(value.size > 0){
                    selected_prototype = value[0];
                    //empty = true;
                    //empty = false;
                } else {
                    //empty = true;
                }
            }
            get {
                return _prototypes;
            }
        }
        private BookPrototype _selected_prototype;
        public BookPrototype selected_prototype {
            set {
                _selected_prototype = value;
                this.set_label (value.name);
            }
            get { return _selected_prototype; }
        }
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
            get {
                return _empty;
            }
        }

        construct {
            get_style_context ().add_class ("book-select-button");
            popover = new Scripture.Widgets.BookSelectPopover (this);
            bind_property ("active", popover, "visible", GLib.BindingFlags.BIDIRECTIONAL);
        }

        public BookSelect () {
            /*
            popover.select_prototype.connect ((prototype) => {
                selected_prototype = prototype;
                this.set_active (false);
            });
            popover.select_book.connect  ((book) => {
                selected_book = book;
                this.set_active (false);
            });
            */
        }
    }

    public class BookSelectPopover : Gtk.Popover {

        private Gtk.Box box;
        private Gtk.ScrolledWindow scroll;
        private BookSelect btn;

        construct {
            get_style_context ().add_class ("book-select-popover");
            box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            scroll = new Gtk.ScrolledWindow (null, null);
            scroll.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scroll.vscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            scroll.min_content_height = 200;
            scroll.margin_top = scroll.margin_bottom = 4;
            add (scroll);
            scroll.add (box);
        }

        public BookSelectPopover (BookSelect btn) {
            this.btn = btn;
            set_relative_to (btn);

            btn.toggled.connect (() => {
			    if (btn.active) {
				    this.show_all ();
			    }
		    });
        }


        public void set_prototypes (ArrayList<BookPrototype> prototypes) {
            box.forall ((element) => box.remove (element));
            foreach (BookPrototype prototype in prototypes){
                var item = new BookSelectItem (prototype, btn);
                box.pack_start (item, false, false, 0);
            }
        }

    }

    public class BookSelectItem : Gtk.Button {

        private BookPrototype _prototype;
        public BookPrototype prototype {
            set {
                _prototype = value;
                this.set_label (value.name);
            }
            get {
                return _prototype;
            }
        }

        construct {
            get_style_context ().add_class ("book-select-item");
        }

        public BookSelectItem (BookPrototype prototype, BookSelect btn) {
            this.prototype = prototype;
            this.clicked.connect(() => {
                btn.selected_prototype = this.prototype;
                btn.selection (this.prototype);
            });
            Gtk.Label label = (Gtk.Label) this.get_child ();
            label.set_xalign (0);
        }

    }

}
