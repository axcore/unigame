---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_starfish_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_starfish_blue.init()

    return {
        description = "Blue starfish",
        depends = "shared_decorations_sea",
    }

end

function unilib.pkg.misc_starfish_blue.exec()

    unilib.pkg.shared_decorations_sea.register_sand_item({
        -- From decorations_sea:starfish_02, etc. Creates unilib:misc_starfish_blue, etc
        part_name = "starfish_blue",
        sand_orig_name = "decorations_sea:starfish_02_node",
        shell_orig_name = "decorations_sea:starfish_02",

        replace_mode = mode,
        sand_description = S("Blue Starfish in Sand"),
        shell_description = S("Blue Starfish"),
    })

    -- From decorations_sea/mapgen.lua
    unilib.pkg.shared_decorations_sea.register_sand_decoration("misc_starfish_blue", 1, 0.005)

end
