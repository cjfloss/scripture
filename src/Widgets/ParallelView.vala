namespace BibleNow.Widgets {

    using BibleNow.Entities;
    using Gee;

    public class ParallelView : Gtk.Paned {

        public BibleReadView readview1;
        public BibleReadView readview2;

        public ParallelView () {
            Object(orientation: Gtk.Orientation.HORIZONTAL);
            readview1 = new BibleNow.Widgets.BibleReadView ();
            readview2 = new BibleNow.Widgets.BibleReadView ();
            var box1 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            var box2 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            var toolbar1 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            var toolbar2 = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            var combo1 = new Gtk.ComboBox ();
            var combo2 = new Gtk.ComboBox ();
            combo1.margin = combo2.margin = 7;
            combo1.vexpand = combo2.vexpand = false;

            toolbar1.pack_start (combo1, false, false, 0);
            toolbar2.pack_start (combo2, false, false, 0);

            box1.pack_start(toolbar1, false, false);
            box2.pack_start(toolbar2, false, false);
            box1.pack_start(readview1);
            box2.pack_start(readview2);
            pack1(box1, true, false);
            pack2(box2, true, false);
        }
    }
}
