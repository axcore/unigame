---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_tree_scorched_log = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_tree_scorched_log.init()

    return {
        description = "Scorched tree log as decoration",
        depends = {"biome_ethereal_plains", "dirt_dried", "tree_scorched"},
    }

end

function unilib.pkg.deco_ethereal_tree_scorched_log.exec()

    unilib.register_decoration_generic("ethereal_tree_scorched_log", {
        -- From ethereal-ng/decor.lua
        deco_type = "schematic",
        schematic = {
            size = {x = 3, y = 1, z = 1},
            data = {
                {name = "unilib:tree_scorched_trunk", param1 = 201, param2 = 16},
                {name = "unilib:tree_scorched_trunk", param1 = 255, param2 = 16},
                {name = "unilib:tree_scorched_trunk", param1 = 255, param2 = 16},
            },
        },

        fill_ratio = 0.0018,
        flags = "place_center_x",
        place_offset_y = 1,
        rotation = "random",
    })

end

function unilib.pkg.deco_ethereal_tree_scorched_log.post()

    unilib.register_decoration_complete("ethereal_tree_scorched_log", nil, {
        -- From ethereal-ng/schems.lua
        biomes = "ethereal_plains",
        place_on = "unilib:dirt_dried",
        num_spawn_by = 8,
        spawn_by = "unilib:dirt_dried",
        y_max = 100,
        y_min = 4,
    })

end
