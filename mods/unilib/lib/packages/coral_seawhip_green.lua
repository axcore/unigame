---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_seawhip_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_seawhip_green.init()

    return {
        description = "Green sea whip coral",
    }

end

function unilib.pkg.coral_seawhip_green.exec()

    unilib.register_node("unilib:coral_seawhip_green", "decorations_sea:coral_plantlike_03", mode, {
        -- From decorations_sea:coral_plantlike_03
        description = S("Green Sea Whip Coral"),
            tiles = {"unilib_coral_block_green.png"},
        groups = {cracky = 3},
        sounds = unilib.node_sound_stone_defaults({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = "unilib_coral_seawhip_green.png",
        paramtype = "light",
        paramtype2 = "meshoptions",
        place_param2 = 4,
        special_tiles = {{name = "unilib_coral_seawhip_green.png", tileable_vertical = true}},
    })

    unilib.pkg.shared_decorations_sea.register_simple_decoration(
        -- From decorations_sea/mapgen.lua
        "coral_seawhip_green", 1, "single_coral"
    )

end
