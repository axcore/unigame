---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_seagrass_tape_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_seagrass_tape_green.init()

    return {
        description = "Green tape seagrass",
        depends = "shared_decorations_sea",
    }

end

function unilib.pkg.plant_seagrass_tape_green.exec()

    unilib.pkg.shared_decorations_sea.register_seagrass({
        -- From decorations_sea:seagrass_03. Creates unilib:plant_seagrass_tape_green
        part_name = "tape_green",
        orig_name = "decorations_sea:seagrass_03",

        replace_mode = mode,
        description = S("Green Tape Seagrass"),
        max_height = 5,
        sci_name = "Enhalus acoroides",
    })
    -- (not compatible with flowerpots)

    -- { y_max, y_min }
    local height_list = { {7, 4}, {4, 3}, {2, 2} }

    for i, mini_list in ipairs(height_list) do

        unilib.pkg.shared_decorations_sea.register_tall_grass_decoration(
            -- From decorations_sea/mapgen.lua
            "plant_seagrass_tape_green", i, "grass", mini_list
        )

        unilib.pkg.shared_decorations_sea.register_tall_grass_decoration(
            -- From decorations_sea/mapgen.lua
            "plant_seagrass_tape_green", i + 3, "grass", mini_list
        )

    end
    for i = 1, 2 do

        unilib.pkg.shared_decorations_sea.register_simple_decoration(
            -- From decorations_sea/mapgen.lua
            "plant_seagrass_tape_green", i, "grass"
        )

    end

end
