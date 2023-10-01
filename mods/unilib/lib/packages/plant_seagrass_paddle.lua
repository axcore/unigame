---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_seagrass_paddle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_seagrass_paddle.init()

    return {
        description = "Paddle seagrass",
        depends = "shared_decorations_sea",
    }

end

function unilib.pkg.plant_seagrass_paddle.exec()

    unilib.pkg.shared_decorations_sea.register_seagrass({
        -- From decorations_sea:seagrass_05. Creates unilib:plant_seagrass_paddle
        part_name = "paddle",
        orig_name = "decorations_sea:seagrass_05",

        replace_mode = mode,
        description = S("Paddle Seagrass"),
        max_height = 1,
        sci_name = "Halophila decipiens",
    })
    -- (not compatible with flowerpots)

    unilib.pkg.shared_decorations_sea.register_simple_decoration(
        -- From decorations_sea/mapgen.lua
        "plant_seagrass_paddle", 1, "short_grass"
    )

end
