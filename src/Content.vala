/*
* Copyright (c) 2018 Cassidy James Blaede (https://cassidyjames.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Cassidy James Blaede <c@ssidyjam.es>
*/

public class ContentStack : Gtk.Stack {
    private struct Content {
        string title;
        string description;
    }

    static Content[] content = {
        Content () {
            title = "Good design is innovative",
            description = "The possibilities for innovation are not, by any means, exhausted. Technological development is always offering new opportunities for innovative design. But innovative design always develops in tandem with innovative technology, and can never be an end in itself."
        },
        Content () {
            title = "Good design makes a product useful",
            description = "A product is bought to be used. It has to satisfy certain criteria, not only functional, but also psychological and aesthetic. Good design emphasizes the usefulness of a product whilst disregarding anything that could possibly detract from it."
        },
        Content () {
            title = "Good design is aesthetic",
            description = "The aesthetic quality of a product is integral to its usefulness because products we use every day affect our person and our well-being. But only well-executed objects can be beautiful."
        },
        Content () {
            title = "Good design makes a product understandable",
            description = "It clarifies the product’s structure. Better still, it can make the product talk. At best, it is self-explanatory."
        },
        Content () {
            title = "Good design is unobtrusive",
            description = "Products fulfilling a purpose are like tools. They are neither decorative objects nor works of art. Their design should therefore be both neutral and restrained, to leave room for the user’s self-expression."
        },
        Content () {
            title = "Good design is honest",
            description = "It does not make a product more innovative, powerful or valuable than it really is. It does not attempt to manipulate the consumer with promises that cannot be kept."
        },
        Content () {
            title = "Good design is long-lasting",
            description = "It avoids being fashionable and therefore never appears antiquated. Unlike fashionable design, it lasts many years – even in today’s throwaway society."
        },
        Content () {
            title = "Good design is thorough down to the last detail",
            description = "Nothing must be arbitrary or left to chance. Care and accuracy in the design process show respect towards the user."
        },
        Content () {
            title = "Good design is environmentally-friendly",
            description = "Design makes an important contribution to the preservation of the environment. It conserves resources and minimizes physical and visual pollution throughout the lifecycle of the product."
        },
        Content () {
            title = "Good design is as little design as possible",
            description = "Less, but better – because it concentrates on the essential aspects, and the products are not burdened with non-essentials. Back to purity, back to simplicity."
        }
    };

    public ContentStack () {
        Object (
            margin_bottom: 24,
            transition_type: Gtk.StackTransitionType.CROSSFADE
        );
    }

    construct {
        int i = 1;
        foreach (var principle in content) {
            var number = new Gtk.Label (i.to_string ());
            number.margin_start = 12;
            number.margin_end = 24;
            number.valign = Gtk.Align.START;
            number.get_style_context ().add_class ("principle-number");

            var title = new Gtk.Label (principle.title);
            title.max_width_chars = 28;
            title.valign = Gtk.Align.END;
            title.wrap = true;
            title.xalign = 0;
            title.get_style_context ().add_class ("principle-title");

            var description = new Gtk.Label (principle.description);
            description.max_width_chars = 40;
            description.wrap = true;
            description.valign = Gtk.Align.START;
            description.xalign = 0;
            description.get_style_context ().add_class ("principle-description");

            var grid = new Gtk.Grid ();
            grid.column_spacing = grid.row_spacing = 12;
            grid.halign = Gtk.Align.CENTER;

            grid.attach (number,      0, 0, 1, 2);
            grid.attach (title,       1, 0);
            grid.attach (description, 1, 1);

            add_named (grid, i.to_string ());

            i++;
        }

        var rand = Random.int_range (1, 11);
        visible_child_name = rand.to_string ();
    }
}

