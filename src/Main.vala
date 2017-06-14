public class BibleNow.Application : Granite.Application {

    public Application () {
        Object (application_id: "biblenow.app",
        flags: ApplicationFlags.FLAGS_NONE);
    }

    protected override void activate () {
        var app_window = new BibleNow.Window (this);
        this.add_window (app_window);
    }

    public static int main (string[] args) {
        var app = new BibleNow.Application ();
        return app.run (args);
    }


}
