#!/usr/bin/env python3

import subprocess
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk

win = Gtk.Window(title='lastb')
lines = subprocess.check_output(('lastb'))
label = Gtk.Label(lines.decode('utf-8'))
label.set_name('lastb')
win.add(label)
win.set_position(Gtk.WindowPosition.CENTER)
win.connect("destroy", Gtk.main_quit)
win.show_all()
css = b'#lastb { font: monospace 10; padding: 0 4ex; }'
cssprovider = Gtk.CssProvider()
cssprovider.load_from_data(css)
Gtk.StyleContext.add_provider_for_screen(
    Gdk.Screen.get_default(),
    cssprovider,
    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )
Gtk.main()
