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
    private const string CSS = """
        .cassidyjames-principles {
            color: black;
            text-shadow: 0 0 0.5em rgba(255, 255, 255, 0.75);
        }

        .cassidyjames-principles.dark {
            color: white;
            text-shadow: 0 0 0.5em rgba(0, 0, 0, 0.75);
        }

        .cassidyjames-principles:backdrop {
            background: transparent;
        }

        .cassidyjames-principles:backdrop .titlebar {
            opacity: 0;
        }

        .cassidyjames-principles:backdrop * {
            border: 0px solid transparent;
            box-shadow: 0 0 transparent;
        }

        .principle-title {
            font-size: 2.5em;
            font-weight: 700;
        }

        .principle-description {
            font-size: 1.25em;
        }

        .principle-number {
            font-size: 10em;
            font-weight: 200;
            margin-top: -0.25em;
        }
    """;

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

        var gtk_settings = Gtk.Settings.get_default ();

        var mode_switch = new ModeSwitch (
            "display-brightness-symbolic",
            "weather-clear-night-symbolic"
        );
        mode_switch.primary_icon_tooltip_text = _("Light background");
        mode_switch.secondary_icon_tooltip_text = _("Dark background");
        mode_switch.valign = Gtk.Align.CENTER;
        mode_switch.bind_property ("active", gtk_settings, "gtk_application_prefer_dark_theme");

        var main_layout = new Gtk.Grid ();
        main_layout.margin_start = 24;
        main_layout.margin_end = 24;
        main_layout.margin_top = 24;
        main_layout.margin_bottom = 60;

        var content_grid = new ContentGrid ();

        var context = get_style_context ();
        context.add_class ("cassidyjames-principles");
        context.add_class ("rounded");
        context.add_class ("flat");

        var provider = new Gtk.CssProvider ();
        try {
            provider.load_from_data (CSS, CSS.length);

            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        } catch (GLib.Error e) {
            return;
        }

        mode_switch.notify["active"].connect (() => {
            if (gtk_settings.gtk_application_prefer_dark_theme) {
                context.add_class ("dark");
            } else {
                context.remove_class ("dark");
            }
        });

        main_layout.attach (content_grid, 0, 0);
        header.pack_end (mode_switch);
        set_titlebar (header);
        set_keep_below (true);
        stick ();

        add (main_layout);
    }
}

