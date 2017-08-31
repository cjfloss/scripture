/* Scripture - Desktop Bible reading app that works offline
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

namespace Scripture {

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
