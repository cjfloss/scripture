public class BibleNow.Window : Gtk.ApplicationWindow {

    private Granite.Application app;

    public Window (Granite.Application app) {
        Object (application: app);
        this.app = app;
        loadCss ();
        show_app ();
    }

    construct {
        var hb = new Gtk.HeaderBar ();
        hb.set_show_close_button (true);
        this.set_titlebar (hb);

        /* Create book and chapter switcher */

        var bookSelect = new BibleNow.Widgets.BookSelect ();
        var chapterSelect = new BibleNow.Widgets.ChapterSelect ();

        var buttonGrid = new Gtk.Grid ();
        buttonGrid.get_style_context ().add_class (Gtk.STYLE_CLASS_LINKED);
        buttonGrid.margin_start = buttonGrid.margin_end = 3;
        buttonGrid.add (bookSelect);
        buttonGrid.add (chapterSelect);

        /* Create search field */
        var searchField = new Gtk.SearchEntry ();

        /* Create menu */
        var appMenu = generateMenu ();

        hb.pack_start (buttonGrid);
        hb.pack_end (appMenu);
        hb.pack_end (searchField);


        /* Example text view */

        var verses = new Gee.ArrayList<BibleNow.Entities.Verse>();
        verses.add(new BibleNow.Entities.Verse(1, "Na počátku stvořil Bůh nebe a zemi."));
        verses.add(new BibleNow.Entities.Verse(2, "Země pak byla pustá a prázdná a nad vodami se vznášel Duch Boží."));
        verses.add(new BibleNow.Entities.Verse(3, "I řekl Bůh: \"Budiž světlo.\" a bylo světlo."));
        verses.add(new BibleNow.Entities.Verse(4, "Byl večer a bylo ráno den první."));
        verses.add(new BibleNow.Entities.Verse(5, "Na počátku stvořil Bůh nebe a zemi."));
        verses.add(new BibleNow.Entities.Verse(6, "Země pak byla pustá a prázdná a nad vodami se vznášel Duch Boží."));
        verses.add(new BibleNow.Entities.Verse(7, "I řekl Bůh: \"Budiž světlo.\" a bylo světlo."));
        var v = new BibleNow.Entities.Verse(8, "Byl večer a bylo ráno den první.");
        v.paragraph_end = true;
        verses.add(v);
        verses.add(new BibleNow.Entities.Verse(9, "Na počátku stvořil Bůh nebe a zemi."));
        verses.add(new BibleNow.Entities.Verse(10, "Země pak byla pustá a prázdná a nad vodami se vznášel Duch Boží."));
        verses.add(new BibleNow.Entities.Verse(11, "I řekl Bůh: \"Budiž světlo.\" a bylo světlo."));
        verses.add(new BibleNow.Entities.Verse(12, "Byl večer a bylo ráno den první."));
        verses.add(new BibleNow.Entities.Verse(13, "Na počátku stvořil Bůh nebe a zemi."));
        verses.add(new BibleNow.Entities.Verse(14, "Země pak byla pustá a prázdná a nad vodami se vznášel Duch Boží."));
        verses.add(new BibleNow.Entities.Verse(15, "I řekl Bůh: \"Budiž světlo.\" a bylo světlo."));
        verses.add(new BibleNow.Entities.Verse(16, "Byl večer a bylo ráno den první."));
        verses.add(new BibleNow.Entities.Verse(17, "Na počátku stvořil Bůh nebe a zemi."));
        verses.add(new BibleNow.Entities.Verse(18, "Země pak byla pustá a prázdná a nad vodami se vznášel Duch Boží."));
        verses.add(new BibleNow.Entities.Verse(19, "I řekl Bůh: \"Budiž světlo.\" a bylo světlo."));
        verses.add(new BibleNow.Entities.Verse(20, "Byl večer a bylo ráno den první."));
        verses.add(new BibleNow.Entities.Verse(21, "Na počátku stvořil Bůh nebe a zemi."));
        verses.add(new BibleNow.Entities.Verse(22, "Země pak byla pustá a prázdná a nad vodami se vznášel Duch Boží."));
        verses.add(new BibleNow.Entities.Verse(23, "I řekl Bůh: \"Budiž světlo.\" a bylo světlo."));
        verses.add(new BibleNow.Entities.Verse(24, "Byl večer a bylo ráno den první."));

        //var textview = new BibleNow.Widgets.ReadView ();
        //textview.content = verses;

        var readview = new BibleNow.Widgets.ParallelView ();
        readview.readview1.content = verses;
        readview.readview2.content = verses;

        this.add(readview);
    }

    public void show_app () {
        show_all ();
        show ();
    }

    private Gtk.MenuButton generateMenu () {
        var appMenuButton = new Gtk.MenuButton ();
        Gtk.Image icon = new Gtk.Image.from_icon_name ("open-menu", Gtk.IconSize.LARGE_TOOLBAR);
        appMenuButton.set_image (icon);

        var appMenu = new GLib.Menu ();


        var translationsItem =  new GLib.MenuItem ("Bible translations", null);
        var preferencesItem = new GLib.MenuItem ("Preferences", null);
        appMenu.append_item (translationsItem);
        appMenu.append_item (preferencesItem);

        var appMenuPopover = new Gtk.Popover.from_model (appMenuButton, appMenu);
        appMenuButton.set_popover (appMenuPopover);
        return appMenuButton;
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
