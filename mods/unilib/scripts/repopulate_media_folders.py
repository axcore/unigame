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
# Simple python script to re-popuplate the contents of the following media
#   folders, using files from the /archive folder:
#   /models     (.b3d, .obj, .blend, .png, .x)
#   /mts        (.mts)
#   /sounds     (.ogg)
#   /textures   (.png)
#
# The files are extracted from the /archive folder, in which they are sorted
#       into sub-folders, one for each original game/modpack/mod
# Only the filetypes listed above are extracted; we do not copy CREDITS or
#       README files, for example
#
# Files are extracted from their sub-folders in alphabetical order (so
#       hello.png in the ../alpha folder will be overwritten by hello.png in
#       the ../zulu folder)
# For the archive/textures_ARCHIVE folder, some special handling occurs: the
#       FIXED folder is extracted last of all, overwriting anything else

import os, pathlib, shutil

unilib_dir = str(pathlib.Path(os.getcwd()).parent)

# /models (.b3d, .obj, .blend, .png, .x) =====================================

model_source = os.path.abspath(
    os.path.join(unilib_dir, "archive", "models_ARCHIVE"),
)
model_dest = os.path.abspath(os.path.join(unilib_dir, "models"))

for path in os.listdir(model_dest):
    full_path = os.path.join(model_dest, path)
    filename, extension = os.path.splitext(full_path)
    if os.path.isfile(full_path) and (
        extension == ".b3d"
        or extension == ".obj"
        or extension == ".blend"
        or extension == ".png"
        or extension == ".x"
    ):
        os.remove(full_path)

model_dir_list = []
for r, d, f in os.walk(model_source):
    for dir in d:
        model_dir_list.append(os.path.join(r, dir))

model_dir_list.sort()

for this_dir in model_dir_list:
    for path in os.listdir(this_dir):

        full_path = os.path.join(this_dir, path)
        filename, extension = os.path.splitext(full_path)
        if os.path.isfile(full_path) and (
            extension == ".b3d"
            or extension == ".obj"
            or extension == ".blend"
            or extension == ".png"
            or extension == ".x"
        ):
            shutil.copy(full_path, model_dest)


# /mts (.b3d, .obj, .blend, .png) ============================================

mts_source = os.path.abspath(
    os.path.join(unilib_dir, "archive", "mts_ARCHIVE"),
)
mts_dest = os.path.abspath(os.path.join(unilib_dir, "mts"))

for path in os.listdir(mts_dest):
    full_path = os.path.join(mts_dest, path)
    filename, extension = os.path.splitext(full_path)
    if os.path.isfile(full_path) and extension == ".mts":
        os.remove(full_path)

mts_dir_list = []
for r, d, f in os.walk(mts_source):
    for dir in d:
        mts_dir_list.append(os.path.join(r, dir))

mts_dir_list.sort()

for this_dir in mts_dir_list:
    for path in os.listdir(this_dir):

        full_path = os.path.join(this_dir, path)
        filename, extension = os.path.splitext(full_path)
        if os.path.isfile(full_path) and extension == ".mts":
            shutil.copy(full_path, mts_dest)

# /sounds (.ogg) =============================================================

sound_source = os.path.abspath(
    os.path.join(unilib_dir, "archive", "sounds_ARCHIVE"),
)
sound_dest = os.path.abspath(os.path.join(unilib_dir, "sounds"))

for path in os.listdir(sound_dest):
    full_path = os.path.join(sound_dest, path)
    filename, extension = os.path.splitext(full_path)
    if os.path.isfile(full_path) and extension == ".ogg":
        os.remove(full_path)

sound_dir_list = []
for r, d, f in os.walk(sound_source):
    for dir in d:
        sound_dir_list.append(os.path.join(r, dir))

sound_dir_list.sort()

for this_dir in sound_dir_list:
    for path in os.listdir(this_dir):

        full_path = os.path.join(this_dir, path)
        filename, extension = os.path.splitext(full_path)
        if os.path.isfile(full_path) and extension == ".ogg":
            shutil.copy(full_path, sound_dest)

# /textures (.png) ===========================================================

texture_source = os.path.abspath(
    os.path.join(unilib_dir, "archive", "textures_ARCHIVE"),
)
texture_dest = os.path.abspath(os.path.join(unilib_dir, "textures"))

for path in os.listdir(texture_dest):
    full_path = os.path.join(texture_dest, path)
    filename, extension = os.path.splitext(full_path)
    if os.path.isfile(full_path) and extension == ".png":
        os.remove(full_path)

texture_dir_list = []
for r, d, f in os.walk(texture_source):
    for dir in d:
        texture_dir_list.append(os.path.join(r, dir))

texture_dir_list.sort()

for this_dir in texture_dir_list:
    for path in os.listdir(this_dir):

        if path != "FIXED":
            full_path = os.path.join(this_dir, path)
            filename, extension = os.path.splitext(full_path)
            if os.path.isfile(full_path) and extension == ".png":
                shutil.copy(full_path, texture_dest)

fixed_source = os.path.abspath(os.path.join(unilib_dir, "textures"))


fixed_source = os.path.abspath(
    os.path.join(unilib_dir, "archive", "textures_ARCHIVE", "FIXED"),
)
if os.path.isdir(fixed_source):

    for path in os.listdir(fixed_source):
        full_path = os.path.join(fixed_source, path)
        filename, extension = os.path.splitext(full_path)
        if os.path.isfile(full_path) and extension == ".png":
            shutil.copy(full_path, texture_dest)

print("Media folders repopulated")
