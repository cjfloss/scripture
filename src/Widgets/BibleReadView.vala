namespace BibleNow.Widgets {

    using BibleNow.Entities;
    using Gee;

    public class BibleReadView : WebKit.WebView {

        private string content_string;
        private ArrayList<Verse> _content;
        public ArrayList<Verse> content {
            get { return _content; }
            set { _set_content (value); }
        }
        private bool _verse_mode;
        public bool verse_mode {
            get { return _verse_mode; }
            set { _set_verse_mode (value); }
        }
        private bool _night_mode;
        public bool night_mode {
            get { return _night_mode; }
            set { _set_night_mode (value); }
        }
        private NumMode _num_mode;
        public NumMode num_mode {
            get { return _num_mode; }
            set { _set_num_mode (value); }
        }
        private int _font_size;
        public int font_size {
            get { return _font_size; }
            set { _set_font_size (value); }
        }
        private ViewTheme _theme;
        public ViewTheme theme {
            get { return _theme; }
            set { _set_theme (value); }
        }

        public BibleReadView () {
            Object(user_content_manager: new WebKit.UserContentManager ());
            load_template ();
            load_defaults ();
        }

        public void load_defaults () {
            load_styles ();
            content = new ArrayList<Verse> ();
            theme = ViewTheme.BLACK_WHITE;
            night_mode = false;
            verse_mode = false;
            num_mode = NumMode.NONE;
            font_size = 16;
            width_request = 250;
        }

        private void load_template () {
            string script = """
                document.body.innerHTML = `
                    <main id="main"><main>
                `;
            """;
            run_javascript (script, null);
        }

        private void load_html_content (string html) {
            string script = """
                document.getElementById("main").innerHTML = `%s`;
            """;
            var sb = new StringBuilder ();
            sb.printf (script, html);
            run_javascript (sb.str, null);
        }

        private void _set_content (ArrayList<Verse> content = this.content) {
            this._content = content;
            content_string = "";
            bool paragraph = false;
            foreach (Verse verse in content) {
                string template = "";
                if (!paragraph) {
                    template += "<p>";
                    paragraph = true;
                }
                template += """
                    <span class="verse">
                        <span class="num">%d </span><span class="content">%s</span>
                    </span>
                """;
                if (verse.paragraph_end){
                    template += "</p>";
                    paragraph = false;
                }
                var sb = new StringBuilder ();
                sb.printf (template, verse.number, verse.content);
                content_string += sb.str;
            }
            if(paragraph){
                content_string += "</p>";
            }
            load_html_content (content_string);
        }

        private void _set_theme (ViewTheme theme) {
            var name = theme.to_string ();
            string script = """
                document.body.setAttribute("data-theme", "%s");
            """;
            var sb = new StringBuilder ();
            sb.printf (script, name);
            run_javascript (sb.str, null);
        }

        private void _set_verse_mode (bool mode) {
            string add = "document.body.setAttribute(\"data-verse-mode\", \"\");";
            string remove = "document.body.removeAttribute(\"data-verse-mode\");";
            if (mode) {
                run_javascript (add, null);
            } else {
                run_javascript (remove, null);
            }
            _set_content ();
        }

        private void _set_night_mode (bool mode) {
            string add = "document.body.setAttribute(\"data-night-mode\", \"\");";
            string remove = "document.body.removeAttribute(\"data-night-mode\");";
            if (mode) {
                run_javascript (add, null);
            } else {
                run_javascript (remove, null);
            }
            _set_content ();
        }

        private void _set_num_mode (NumMode mode) {
            string script = "document.body.setAttribute(\"data-nums\", \"%s\");";
            var sb = new StringBuilder ();
            sb.printf (script, mode.to_string ());
            run_javascript (sb.str, null);
        }

        private void _set_font_size (int size) {
            string script = """
                document.body.style.fontSize = "%dpx";
                document.getElementById("main").style.width = "%dpx";

            """;
            var sb = new StringBuilder ();
            sb.printf (script, size, (size*45));
            run_javascript (sb.str, null);
        }

        private void load_styles () {
            user_content_manager.add_style_sheet (
                new WebKit.UserStyleSheet (BibleNow.VIEW_STYLES , WebKit.UserContentInjectedFrames.TOP_FRAME, WebKit.UserStyleLevel.AUTHOR, null, null)
            );
        }
    }

    public enum NumMode {
        NONE,
        SMALL,
        NORMAL;

        public string to_string () {
            switch (this) {
                case NONE:
                    return "none";
                case SMALL:
                    return "small";
                case NORMAL:
                    return "normal";
                default:
                    assert_not_reached();
            }
        }
    }

    public enum ViewTheme {
        BLACK_WHITE,
        BRICK,
        PAPER;

        public string to_string () {
            switch (this) {
                case BLACK_WHITE:
                    return "black-white";
                case BRICK:
                    return "brick";
                case PAPER:
                    return "paper";
                default:
                    assert_not_reached();
            }
        }
    }
}
