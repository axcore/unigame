#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright (C) 2026 A S Lewis
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
# Simple python script to check the validity of every package, each of which
#       should have standard functions
# Each package should have exactly one .init() function, no more than one
#       .exec() function, and no more than one .post() function
# Packages in each of the following locations are checked:
#       ../lib/packages
#       ../lib/packages/dev
#       ../custom/packages
# Unlike unilib itself, we check all packages found; we don't ignore the
#   package ../custom/packages/stone_ordinary.lua, if we have already checked
#   ../lib/packages/stone_ordinary.lua

import os, pathlib, re

unilib_dir = str(pathlib.Path(os.getcwd()).parent.parent)

folder_list = [
    os.path.join(unilib_dir, "lib", "packages"),
    os.path.join(unilib_dir, "lib", "packages", "dev"),
#    os.path.join(unilib_dir, "custom", "packages"),
]

pkg_count = 0
success_count = 0
fail_count = 0

for folder_path in folder_list:

    print("Checking packages in " + folder_path)

    for pkg_path in os.listdir(folder_path):

        full_pkg_path = os.path.join(folder_path, pkg_path)
        if os.path.isfile(full_pkg_path) and full_pkg_path.endswith(".lua"):

            with open(full_pkg_path, "r", encoding="utf-8") as f:
                content = f.read()

            init_count = len(
                re.findall(r"function unilib\.pkg\.\w+\.init\s*\(\)", content),
            )
            exec_count = len(
                re.findall(r"function unilib\.pkg\.\w+\.exec\s*\(\)", content),
            )
            post_count = len(
                re.findall(r"function unilib\.pkg\.\w+\.post\s*\(\)", content),
            )

            fail_flag = False
            if init_count == 0:
                print(f"   {pkg_path}: No .init() function found")
                fail_flag = True

            elif init_count > 1:
                print(
                    f"   {pkg_path}: Multiple .init() functions found:" \
                    + " {init_count}",
                )
                fail_flag = True

            if exec_count > 1:
                print(
                    f"   {pkg_path}: Multiple .exec() functions found:" \
                    + " {exec_count}",
                )
                fail_flag = True

            if post_count > 1:
                print(
                    f"   {pkg_path}: Multiple .post() functions found:" \
                    + " {post_count}",
                )
                fail_flag = True

            pkg_count += 1
            if fail_flag:
                fail_count += 1
            else:
                success_count += 1

print("Total packages checked: " + str(pkg_count))
print("Total invalid packages: " + str(fail_count))
print("Total valid packages:   " + str(success_count))
