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

public class MainWindow : Gtk.Window {
    private ContentStack stack;

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            icon_name: "com.github.cassidyjames.principles",
            resizable: false,
            skip_taskbar_hint: true,
            title: _("Principles"),
            window_position: Gtk.WindowPosition.CENTER
        );
    }

    construct {
        var header = new Gtk.HeaderBar ();
        header.show_close_button = true;
        var header_context = header.get_style_context ();
        header_context.add_class ("titlebar");
        header_context.add_class ("default-decoration");
        header_context.add_class (Gtk.STYLE_CLASS_FLAT);

        var randomize_button = new Gtk.Button.from_icon_name ("media-playlist-shuffle-symbolic");
        randomize_button.margin_end = 12;
        randomize_button.tooltip_text = _("Load a random principle");

        var gtk_settings = Gtk.Settings.get_default ();

        var mode_switch = new ModeSwitch (
            "display-brightness-symbolic",
            "weather-clear-night-symbolic"
        );
        mode_switch.margin_end = 6;
        mode_switch.primary_icon_tooltip_text = _("Light background");
        mode_switch.secondary_icon_tooltip_text = _("Dark background");
        mode_switch.valign = Gtk.Align.CENTER;
        mode_switch.bind_property ("active", gtk_settings, "gtk_application_prefer_dark_theme");

        stack = new ContentStack ();

        var context = get_style_context ();
        context.add_class ("principles");
        context.add_class ("rounded");
        context.add_class ("flat");

        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/com/github/cassidyjames/principles/Application.css");
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        mode_switch.notify["active"].connect (() => {
            if (gtk_settings.gtk_application_prefer_dark_theme) {
                context.add_class ("dark");
            } else {
                context.remove_class ("dark");
            }
        });

        randomize_button.clicked.connect (() => randomize_principle (stack) );

        Principles.settings.bind ("dark", mode_switch, "active", GLib.SettingsBindFlags.DEFAULT);

        header.pack_end (mode_switch);
        header.pack_end (randomize_button);

        set_titlebar (header);
        set_keep_below (true);
        stick ();

        add (stack);

        stack.realize.connect (() => {
           randomize_principle (stack, true);
        });
    }

    private void randomize_principle (ContentStack stack, bool allow_current = false) {
        int rand = Random.int_range (1, 11);
        int current = int.parse (stack.visible_child_name);

        if (allow_current || rand != current) {
            stack.visible_child_name = rand.to_string ();
            return;
        }

        randomize_principle (stack);
    }

    public override bool configure_event (Gdk.EventConfigure event) {
        int root_x, root_y;
        get_position (out root_x, out root_y);
        Principles.settings.set_int ("window-x", root_x);
        Principles.settings.set_int ("window-y", root_y);

        return base.configure_event (event);
    }
}

