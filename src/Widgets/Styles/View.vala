namespace BibleNow {

    unowned string VIEW_STYLES = """

    body {
        color: #444;
    }
    #main {
        width: 700px;
        max-width: 100%;
        margin: 0px auto;
        position: relative;
        box-sizing: border-box;
        padding: 10px 15px;
        line-height: 1.6;
    }
    p {
        margin: 0em;
        padding: 0em;
        margin-bottom: 1.5em;
    }
    p:last-of-type {
        margin-bottom: 0px;
    }
    .verse {
        font-family: Roboto, sans-serif;
        margin: 0px;
        display: inline;
    }
    .verse .num {
        font-weight: 700;
    }
    [data-verse-mode] .verse {
        display: block;
        margin-bottom: 0.6em;
    }
    [data-verse-mode] p {
        margin: 0px;
    }
    [data-nums='small'] .num {
        vertical-align: super;
        font-size: 0.8em;
    }
    [data-nums='none'] .num {
        display: none;
    }

    body[data-theme='black-white'][data-night-mode] {
        background-color: #222;
        color: #bbb;
    }

    [data-theme='brick'] .num {
        color: rgb(180, 90, 90);
    }
    body[data-theme='brick'][data-night-mode] {
        background-color: #222;
        color: #aaa;
    }

    body[data-theme='paper'] {
        background-color: rgb(255, 250, 230);
    }



    """;

}
