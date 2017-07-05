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

using Gee;
using BibleNow.Utils;
using BibleNow.Entities;

public class BibleNow.Window : Gtk.ApplicationWindow {

    private Granite.Application app;
    public Gtk.Stack stack;
    public BibleNow.Views.ParallelView parallelView;
    public BibleNow.Views.SingleView singleView;
    public bool locked = false;

    public Window (Granite.Application app) {
        Object (application: app);
        this.app = app;
        loadCss ();
        show_app ();
    }

    construct {
        ///////////////////////////////////////////////////////////////////////////////////////////////////
       //           Testing model            /////////////////////////////////////////////////////////////
      ///////////////////////////////////////////////////////////////////////////////////////////////////
      ////
      /**/    Language lang = new Language.create ("English");
      /**/    Bible bible = new Bible.create ("King James Version", lang);
      /**/    BookPrototype gen_prototype = new BookPrototype.selectById (1);
      /**/    BookPrototype ex_prototype = new BookPrototype.selectById (2);
      /**/    BookPrototype lv_prototype = new BookPrototype.selectById (3);
      /**/    Book genesis = new Book.create ("Genesis", gen_prototype, bible);
      /**/    Book exodus = new Book.create ("Exodus", ex_prototype, bible);
      /**/    Book leviticus = new Book.create ("Leviticus", lv_prototype, bible);
      /**/    Chapter chapter1 = new Chapter.create (1, genesis);
      /**/    Verse v1 = new Verse.create (1, "In the beginning god created the heaven and the earth.", chapter1);
      /**/    Verse v2 = new Verse.create (2, "Země pak byla pustá a prázdná a nad vodami se vznášel Duch Boží.", chapter1);
      /**/    Verse v3 = new Verse.create (3, "I řekl Bůh: \"Budiž světlo.\" a bylo světlo.", chapter1);
      /**/
      /**/    Chapter chapter2 = new Chapter.create (2, genesis);
      /**/    Verse v4 = new Verse.create (1, "Tohle je druhá. Na počátku stvořil Bůh nebe a zemi.", chapter2);
      /**/    Verse v5 = new Verse.create (2, "Země pak byla pustá a prázdná a nad vodami se vznášel Duch Boží.", chapter2);
      /**/    Verse v6 = new Verse.create (3, "I řekl Bůh: \"Budiž světlo.\" a bylo světlo.", chapter2);
      /**/
      /**/    ArrayList<Book> books = bible.getBooks ();
      /**/
              Chapter c = new Chapter.selectByBookAndNum (genesis, 2);
              ArrayList<Verse> verses = c.getVerses ();

//      \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//        \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//          \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

        var hb = new Gtk.HeaderBar ();
        hb.set_show_close_button (true);
        this.set_titlebar (hb);

        stack = new Gtk.Stack ();

        /* Create book and chapter switcher */

        var bookSelect = new BibleNow.Widgets.BookSelect ();
        bookSelect.prototypes = BookPrototype.selectAll ();
        var chapterSelect = new BibleNow.Widgets.ChapterSelect ();

        var buttonGrid = new Gtk.Grid ();
        buttonGrid.get_style_context ().add_class (Gtk.STYLE_CLASS_LINKED);
        buttonGrid.margin_start = buttonGrid.margin_end = 3;
        buttonGrid.add (bookSelect);
        buttonGrid.add (chapterSelect);

        /* Create search field */
        var searchField = new Gtk.SearchEntry ();

        /* Create menu */
        var appMenu = new BibleNow.Widgets.AppMenu (this);

        hb.pack_start (buttonGrid);
        hb.pack_end (appMenu);
        hb.pack_end (searchField);

        parallelView = new BibleNow.Views.ParallelView ();
        singleView = new BibleNow.Views.SingleView ();

        singleView.readingArea.content = verses;
        parallelView.readingArea1.content = verses;
        parallelView.readingArea2.content = verses;
        stack.add_named(singleView, "Single view");
        stack.add_named(parallelView, "Parallel view");
        this.add(stack);

        BibleNow.Settings.get_instance ().changed.connect (() => {
            display_bible_view ();
        });
    }

    private void display_bible_view () {

        if (BibleNow.Settings.get_instance ().parallel_mode && !locked) {
            stack.visible_child = parallelView;
        } else {
            stack.visible_child = singleView;
        }
    }

    public void show_app () {
        show_all ();
        show ();
        display_bible_view ();
    }

    private void loadCss () {
        try {
            var css_provider = new Gtk.CssProvider ();
            css_provider.load_from_data (BibleNow.APP_STYLES);
            Gdk.Screen screen = Gdk.Screen.get_default ();
            Gtk.StyleContext.add_provider_for_screen(screen, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        } catch (GLib.Error e) {
            stdout.printf("Error: Styles not loaded!");
        }
    }


}
