#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright (C) 2023 A S Lewis
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
#
#
# Simple python script to check the lists of packages in the ../lib/packages
#       ../archive/packages_ARCHIVE folders, both of which should contain an
#       identical number of files (with the same names)

import os, pathlib, shutil

unilib_dir = str(pathlib.Path(os.getcwd()).parent.parent)

main_count = 0
main_check_dict = {}
main_missing_list = []
main_dir = os.path.abspath(os.path.join(unilib_dir, "lib", "packages"))

archive_count = 0
archive_check_dict = {}
archive_missing_list = []
archive_dir = os.path.abspath(
    os.path.join(unilib_dir, "archive", "packages_ARCHIVE"),
)

for path in os.listdir(main_dir):
    main_check_dict[path] = True
    main_count += 1

for path in os.listdir(archive_dir):
    archive_check_dict[path] = True
    archive_count += 1

if main_count != archive_count:

    for path in archive_check_dict.keys():
        if not path in main_check_dict:
            main_missing_list.append(path)
            
    for path in main_check_dict.keys():
        if not path in archive_check_dict:
            archive_missing_list.append(path)

print("Files in ../lib/packages: " + str(main_count))
print("Files in ../archive/packages_ARCHIVE: " + str(archive_count))

if main_missing_list:
    main_missing_list.sort()
    print("\nMissing from ../lib/packages:")
    for path in main_missing_list:
        print(path)
        
if archive_missing_list:
    archive_missing_list.sort()
    print("\nMissing from ../archive/packages_ARCHIVE:")
    for path in archive_missing_list:
        print(path)
