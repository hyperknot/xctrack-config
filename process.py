#!/usr/bin/env python3

import os
import sys

from lib.utils import read_json, write_json, ensure_dir


def process(file_path, new_screen_name):
    if not os.path.isfile(file_path):
        sys.exit('File not found')

    data = read_json(file_path)

    new_data = dict()
    new_data['layout'] = data['layout']
    new_data['info'] = {
        'versionCode': 63,
        'versionName': '0.6.0',
    }
    new_data['preferences'] = {
        'Display.Theme': 'WhiteHCTheme',
    }

    if '-por2lan' in sys.argv:
        new_data['layout']['landscape'] = new_data['layout']['portrait']

    if '-lan2por' in sys.argv:
        new_data['layout']['landscape'] = new_data['layout']['portrait']

    if '-por' in sys.argv:
        del new_data['layout']['landscape']
        new_data['preferences']['Display.Orientation'] = 'PORTRAIT'

    elif '-lan' in sys.argv:
        del new_data['layout']['portrait']
        new_data['preferences']['Display.Orientation'] = 'LANDSCAPE'

    else:
        sys.exit('Please specify either -por (portrait) or -lan (landscape)')

    sort_widgets_by_name(new_data['layout'])

    ensure_dir('screens')
    target_file = os.path.join('screens', new_screen_name + '.cfg')
    write_json(target_file, new_data)


def sort_widgets_by_name(layout):
    for orientation in ['landscape', 'portrait']:
        if orientation not in layout:
            continue

        for screen in layout[orientation]:
            screen['widgets'] = sorted(screen['widgets'], key=lambda s: s['CLASS'])


if len(sys.argv) < 3:
    sys.exit('Usage: process.py original_file.cfg new_screen_name [options]')

process(sys.argv[1], sys.argv[2])
