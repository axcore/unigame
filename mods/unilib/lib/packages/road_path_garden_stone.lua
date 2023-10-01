---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.road_path_garden_stone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.road_path_garden_stone.init()

    return {
        description = "Stone garden path",
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.road_path_garden_stone.exec()

    unilib.register_node("unilib:road_path_garden_stone", "xdecor:stonepath", mode, {
        -- From xdecor:stonepath
        description = S("Stone Garden Path"),
        tiles = {"unilib_stone_ordinary.png"},
        groups = {snappy = 3},
        sounds = unilib.sound_table.stone,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {0, -0.5, 0, 0.375, -0.46875, 0.375},
                {-0.4375, -0.5, -0.4375, -0.0625, -0.46875, -0.0625},
                {-0.4375, -0.5, 0.125, -0.125, -0.46875, 0.4375},
                {0.125, -0.5, -0.375, 0.375, -0.46875, -0.125},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},
        },
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From xdecor:stonepath
        output = "unilib:road_path_garden_stone 16",
        recipe = {
            {"group:cobble_stair_slab", "", "group:cobble_stair_slab"},
            {"", "group:cobble_stair_slab", ""},
            {"group:cobble_stair_slab", "", "group:cobble_stair_slab"},
        },
    })
    if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:road_path_garden_stone", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
