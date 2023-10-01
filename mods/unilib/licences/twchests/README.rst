=========================
Tweaked chests [twchests]
=========================

This is a mod for `Minetest <https://www.minetest.net/>`__, providing some new chests.

.. image:: screenshot.png
  :alt: Screenshot of new chests

The mod includes includes two new chests:

* The "compact" chest has a small capacity, only 3 x 2
* The "bottomless" chest has a near-infinite capacity
* In "bottomless" chests, items are arranged across multiple pages, with 12 x 5 items on each page. You can add as many pages as you need

Apart from their capacity, the new chests behave almost exactly like the chests in minetest_game:

* You can craft open or locked chests
* Locked chests can be used with skeleton keys
* All the chests are compatible with `Pipeworks <https://github.com/mt-mods/pipeworks>`__

Note that if you shift-click items from your inventory into the "bottomless" chest, they will appear in the first empty slot (which might not be on the visible page).

Dependencies
------------

Probably requires Minetest v5.0 (or later).

Hard dependencies: default

Soft dependencies: pipeworks

Licenses
--------

The code and textures have been adapted from minetest_game/default.

Author: A S Lewis

Licence (code): LGPL 2.1

Licence (media): CC BY-SA 3.0

API
---

If you're willing to get your hands dirty, you can edit the code to change the capacity of the chests, or to create new chests.

* Chests are created via a call to *twchests.register_chest()*
* See the comments in the *shared.lua* file for the API
* There are two types of chest: "large", and "small"
* The "small" chests have a *maximum* capacity of 8 x 4
* The "large" chests have a *minimum* capacity of 8 x 4
* You can specify a maximum number of pages for the "large" chests, in which case they won't have an infinite capacity any more
