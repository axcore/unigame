---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_starfish_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_starfish_red.init()

    return {
        description = "Red starfish",
        depends = "shared_decorations_sea",
    }

end

function unilib.pkg.misc_starfish_red.exec()

    unilib.pkg.shared_decorations_sea.register_sand_item({
        -- From decorations_sea:starfish_01, etc. Creates unilib:misc_starfish_red, etc
        part_name = "starfish_red",
        sand_orig_name = "decorations_sea:starfish_01_node",
        shell_orig_name = "decorations_sea:starfish_01",

        replace_mode = mode,
        sand_description = S("Red Starfish in Sand"),
        shell_description = S("Red Starfish"),
    })

    -- From decorations_sea/mapgen.lua
    unilib.pkg.shared_decorations_sea.register_sand_decoration("misc_starfish_red", 1, 0.005)

end
