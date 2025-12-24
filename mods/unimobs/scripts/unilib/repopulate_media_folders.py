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
#   folders, using files from the /archive and /custom folders:
#   /models     (.b3d, .obj, .blend, .png, .x)
#   /mts        (.mts)
#   /sounds     (.ogg)
#   /textures   (.png)
#
# The files are extracted from the /archive folder, in which they are sorted
#       into sub-folders, one for each original game/modpack/mod
# Files are also extracted from the /custom folder, in which they are sorted
#       into the sub-folders /models, /mts, /sounds and /textures
# Only the filetypes listed above are extracted; we do not copy CREDITS or
#       README files, for example
#
# Files are extracted from the /archive sub-folders in alphabetical order (so
#       hello.png in the ../alpha folder will be overwritten by hello.png in
#       the ../zulu folder)
# For the archive/textures_ARCHIVE folder, some special handling occurs: the
#       FIXED folder is extracted last of all, overwriting anything else
# Files are then extracted from the /custom folder, again overwriting anything
#       else

import os, pathlib, shutil

unilib_dir = str(pathlib.Path(os.getcwd()).parent.parent)
total_count = 0

# /models (.b3d, .obj, .blend, .png, .x) =====================================

print("Repopulating /models ...")

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
#model_dir_list.append(
#    os.path.abspath(os.path.join(unilib_dir, "custom", "models")),
#)

file_count = 0
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
            file_count += 1

print("Files copied: " + str(file_count))
total_count += file_count

# /mts (.b3d, .obj, .blend, .png) ============================================

print("Repopulating /mts ...")

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
#mts_dir_list.append(
#    os.path.abspath(os.path.join(unilib_dir, "custom", "mts")),
#)

file_count = 0
for this_dir in mts_dir_list:
    for path in os.listdir(this_dir):

        full_path = os.path.join(this_dir, path)
        filename, extension = os.path.splitext(full_path)
        if os.path.isfile(full_path) and extension == ".mts":
            shutil.copy(full_path, mts_dest)
            file_count += 1

print("Files copied: " + str(file_count))
total_count += file_count

# /sounds (.ogg) =============================================================

print("Repopulating /sounds ...")

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
#sound_dir_list.append(
#    os.path.abspath(os.path.join(unilib_dir, "custom", "sounds")),
#)

file_count = 0
for this_dir in sound_dir_list:
    for path in os.listdir(this_dir):

        full_path = os.path.join(this_dir, path)
        filename, extension = os.path.splitext(full_path)
        if os.path.isfile(full_path) and extension == ".ogg":
            shutil.copy(full_path, sound_dest)
            file_count += 1

print("Files copied: " + str(file_count))
total_count += file_count

# /textures (.png) ===========================================================

print("Repopulating /textures ...")

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

file_count = 0
for this_dir in texture_dir_list:
    for path in os.listdir(this_dir):

        if path != "FIXED":
            full_path = os.path.join(this_dir, path)
            filename, extension = os.path.splitext(full_path)
            if os.path.isfile(full_path) and extension == ".png":
                shutil.copy(full_path, texture_dest)
                file_count += 1

fixed_source = os.path.abspath(
    os.path.join(unilib_dir, "archive", "textures_ARCHIVE", "FIXED"),
)
if os.path.isdir(fixed_source):

    for path in os.listdir(fixed_source):
        full_path = os.path.join(fixed_source, path)
        filename, extension = os.path.splitext(full_path)
        if os.path.isfile(full_path) and extension == ".png":
            shutil.copy(full_path, texture_dest)
            file_count += 1

#custom_source = os.path.abspath(
#    os.path.join(unilib_dir, "custom", "textures"),
#)
#if os.path.isdir(custom_source):
#
#    for path in os.listdir(custom_source):
#        full_path = os.path.join(custom_source, path)
#        filename, extension = os.path.splitext(full_path)
#        if os.path.isfile(full_path) and extension == ".png":
#            shutil.copy(full_path, texture_dest)
#            file_count += 1

print("Files copied: " + str(file_count))
total_count += file_count

# ===========================================================================

print("Media folders repopulated, total files copied: " + str(total_count))
