namespace BibleNow.Widgets {

    public class BookSelect : Gtk.ToggleButton {

        public signal void value_updated (string v);

        public BookSelectPopover popover;
        private string _selection;
        public string selection {
            set {
                _selection = value;
                this.set_label (_selection);
            }
            get { return _selection; }
        }

        public BookSelect () {
            selection = "Genesis";
            Gee.ArrayList<string> books = new Gee.ArrayList<string> (null);
            books.add ("Genesis");
            books.add ("Exodus");
            books.add ("Leviticus");
            books.add ("Numbers");
            books.add ("Genesis");
            books.add ("Exodus");
            books.add ("Leviticus");
            books.add ("Numbers");
            books.add ("Genesis");
            books.add ("Exodus");
            books.add ("Leviticus");
            books.add ("Numbers");

            get_style_context ().add_class ("book-select-button");

            popover = new BibleNow.Widgets.BookSelectPopover (this, books);
            bind_property ("active", popover, "visible", GLib.BindingFlags.BIDIRECTIONAL);
            this.value_updated.connect ((val) => {
                selection = val;
                this.set_active (false);
            });
        }

    }

    public class BookSelectPopover : Gtk.Popover {

        private Gtk.Box box;
        private Gtk.ScrolledWindow scroll;
        private BookSelect btn;

        public BookSelectPopover (BookSelect btn, Gee.ArrayList<string> books) {
            this.btn = btn;
            set_relative_to (btn);
            box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            scroll = new Gtk.ScrolledWindow (null, null);
            scroll.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scroll.vscrollbar_policy = Gtk.PolicyType.AUTOMATIC;
            scroll.min_content_height = 200;
            scroll.margin_top = scroll.margin_bottom = 4;
            add (scroll);
            scroll.add (box);

            get_style_context ().add_class ("book-select-popover");

            foreach (var book in books){
                var item = new BookSelectItem (book);
                box.pack_start (item, false, false, 0);
                item.item_selected.connect ((val) => {
                    this.btn.value_updated (val);
                });
            }

            btn.toggled.connect (() => {
			    if (btn.active) {
				    this.show_all ();
			    }
		    });
        }
    }

    public class BookSelectItem : Gtk.Button {

        public signal void item_selected (string v);

        private string _book;
        public string book {
            set {
                _book = value;
                this.set_label (book);
            }
            get { return _book; }
        }

        public BookSelectItem (string book) {
            this.book = book;

            get_style_context ().add_class ("book-select-item");

            this.clicked.connect(() => {
                this.item_selected (this.book);
            });
        }
    }

}
