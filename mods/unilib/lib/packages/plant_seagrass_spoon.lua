---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_seagrass_spoon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_seagrass_spoon.init()

    return {
        description = "Spoon seagrass",
        depends = "shared_decorations_sea",
    }

end

function unilib.pkg.plant_seagrass_spoon.exec()

    unilib.pkg.shared_decorations_sea.register_seagrass({
        -- From decorations_sea:sea_pickle. Creates unilib:plant_seagrass_spoon
        part_name = "spoon",
        orig_name = "decorations_sea:sea_pickle",

        replace_mode = mode,
        description = S("Spoon Seagrass"),
        light_source = 8,
        max_height = 1,
        sci_name = "Halophila ovalis",
    })
    -- (not compatible with flowerpots)

    unilib.pkg.shared_decorations_sea.register_simple_decoration(
        -- From decorations_sea/mapgen.lua
        "plant_seagrass_spoon", 1, "seagrass_spoon"
    )

end
