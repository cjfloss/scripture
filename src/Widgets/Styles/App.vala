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

namespace BibleNow {

    unowned string APP_STYLES = """

    GtkPopover GtkButton {
        background: none;
        border-style: none;
        outline-style: none;
        transition-property: none;
        box-shadow: none;
        padding: 10px 12px;
    }

    GtkPopover GtkButton:active{
        outline-style: none;
        box-shadow: none;
    }
    GtkPopover GtkButton:hover{
        background-color: rgba(0,0,0,0.1);
    }

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
    .parallelview-toolbar {
        background-color: rgb(255,255,255);
        border-bottom: 1px solid #bbb;
    }
    .parallelview-toolbar > * {
        padding: 7px;
    }
    .bible-select-item {
        padding: 7px;
    }
    """;
}
