namespace BibleNow {

    unowned string APP_STYLES = """

    .chapter-select-item {
        background: none;
        border-style: none;
        outline-style: none;
        transition-property: none;
        box-shadow: none;
        padding: 9px 6px;
    }
    .chapter-select-item:active{
        outline-style: none;
        box-shadow: none;
    }
    .chapter-select-item:hover{
        background-color: rgba(0,0,0,0.1);
    }
    .book-select-item {
        background: none;
        border-style: none;
        outline-style: none;
        transition-property: none;
        box-shadow: none;
        padding: 10px 20px;
    }
    .book-select-item:active{
        outline-style: none;
        box-shadow: none;
    }
    .book-select-item:hover{
        background-color: rgba(0,0,0,0.1);
    }

    GtkPopover GtkButton {
        background: none;
        border-style: none;
        outline-style: none;
        transition-property: none;
        box-shadow: none;
    }

    GtkPopover GtkButton:active{
        outline-style: none;
        box-shadow: none;
    }
    GtkPopover GtkButton:hover{
        background-color: rgba(0,0,0,0.1);
    }

    .book-select-button > * {
        padding: 3px 8px;
    }
    .chapter-select-button > * {
        padding: 3px 8px;
    }

    """;
}
