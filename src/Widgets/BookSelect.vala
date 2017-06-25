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

    public class BookSelect : Gtk.ToggleButton {

        public signal void selection (BookPrototype prototype);

        private BookSelectPopover popover;
        public bool local_names = false;
        private ArrayList<Book> _books;
        private ArrayList<BookPrototype> _prototypes;
        private bool prototype_mode = true;
        public ArrayList<Book> books {
            set {
                _books = value;
                prototype_mode = false;
                popover.set_books (value);
            }
            get {
                return _books;
            }
        }
        public ArrayList<BookPrototype> prototypes {
            set {
                _prototypes = value;
                prototype_mode = true;
                popover.set_prototypes (value);
            }
            get {
                return _prototypes;
            }
        }
        private BookPrototype _selected_prototype;
        public BookPrototype selected_prototype {
            set {
                _selected_prototype = value;
                this.selection (value);
                this.set_label (value.name);
            }
            get { return _selected_prototype; }
        }
        private Book _selected_book;
        public Book selected_book {
            set {
                _selected_book = value;
                this.selection (value.prototype);
                if (local_names) {
                    set_label (value.name);
                } else {
                    set_label (value.prototype.name);
                }
            }
            get { return _selected_book; }
        }

        construct {
            get_style_context ().add_class ("book-select-button");
            popover = new BibleNow.Widgets.BookSelectPopover (this);
            bind_property ("active", popover, "visible", GLib.BindingFlags.BIDIRECTIONAL);
        }

        public BookSelect () {
            popover.select_prototype.connect ((prototype) => {
                selected_prototype = prototype;
                this.set_active (false);
            });
            popover.select_book.connect  ((book) => {
                selected_book = book;
                this.set_active (false);
            });
        }

        private void select_first_prototype (BookPrototype prototype) {

        }
    }

    public class BookSelectPopover : Gtk.Popover {

        public signal void select_prototype (BookPrototype prototype);
        public signal void select_book (Book book);
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

        public void set_books (ArrayList<Book> books) {
            box.forall ((element) => box.remove (element));
            foreach (Book book in books){
                var item = new BookSelectItem.withBook (book, this, btn.local_names);
                box.pack_start (item, false, false, 0);
            }
        }

        public void set_prototypes (ArrayList<BookPrototype> prototypes) {
            box.forall ((element) => box.remove (element));
            foreach (BookPrototype prototype in prototypes){
                var item = new BookSelectItem.withPrototype (prototype, this, btn.local_names);
                box.pack_start (item, false, false, 0);
            }
        }

    }

    public class BookSelectItem : Gtk.Button {

        private bool local_names = false;
        private Book _book;
        public Book book {
            set {
                _book = value;
                if (local_names) {
                    this.set_label (value.name);
                } else {
                    this.set_label (value.prototype.name);
                }
                stdout.printf("id: %i, name: %s, bible: %s (%s), prototype: %s (%i), chapters: %i\n", value.id, value.name, value.bible.name, book.bible.language.name, book.prototype.name, book.prototype.order, book.getChapterCount ());
            }
            get {
                return _book;
            }
        }
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

        public BookSelectItem.withPrototype (BookPrototype prototype, BookSelectPopover popover, bool local_names) {
            this.local_names = local_names;
            this.prototype = prototype;
            this.clicked.connect(() => {
                popover.select_prototype(this.prototype);
            });
        }

        public BookSelectItem.withBook (Book book, BookSelectPopover popover, bool local_names) {
            this.local_names = local_names;
            this.book = book;
            this.clicked.connect(() => {
                popover.select_book(this.book);
            });
        }
    }

}
