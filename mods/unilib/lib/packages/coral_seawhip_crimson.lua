---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_seawhip_crimson = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_seawhip_crimson.init()

    return {
        description = "Crimson sea whip coral",
    }

end

function unilib.pkg.coral_seawhip_crimson.exec()

    unilib.register_node(
        -- From decorations_sea:coral_plantlike_02
        "unilib:coral_seawhip_crimson",
        "decorations_sea:coral_plantlike_02",
        mode,
        {
            description = S("Crimson Sea Whip Coral"),
            tiles = {"unilib_coral_block_crimson.png"},
            groups = {cracky = 3},
            sounds = unilib.node_sound_stone_defaults({
                dig = {name = "unilib_dig_snappy", gain = 0.2},
                dug = {name = "unilib_grass_footstep", gain = 0.25},
            }),

            drawtype = "plantlike_rooted",
            inventory_image = "unilib_coral_seawhip_crimson.png",
            paramtype = "light",
            paramtype2 = "meshoptions",
            place_param2 = 4,
            special_tiles = {{name = "unilib_coral_seawhip_crimson.png", tileable_vertical = true}},
        }
    )

    unilib.pkg.shared_decorations_sea.register_simple_decoration(
        -- From decorations_sea/mapgen.lua
        "coral_seawhip_crimson", 1, "single_coral"
    )

end
