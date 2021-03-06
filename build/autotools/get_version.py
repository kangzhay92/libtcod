#!/usr/bin/env python
"""
    Print the version number for libtcod.

    The --so flag can be used to get the library version number instead.
"""

import sys

import re

RE_MAJOR = '.*#define TCOD_MAJOR_VERSION *([0-9]+)'
RE_MINOR = '.*#define TCOD_MINOR_VERSION *([0-9]+)'
RE_PATCH = '.*#define TCOD_PATCHLEVEL *([0-9]+)'
RE_VERSION = RE_MAJOR + RE_MINOR + RE_PATCH

def main():
    with open('../../include/libtcod_version.h') as f:
        header = f.read()
    major, minor, patch = re.match(RE_VERSION, header, re.DOTALL).groups()
    if '--so' in sys.argv:
        print('{major}:{minor}'.format(**locals()))
    else:
        print('{major}.{minor}.{patch}'.format(**locals()))

if __name__ == '__main__':
    main()
