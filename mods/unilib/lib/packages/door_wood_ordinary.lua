---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.doors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_ordinary.init()

    return {
        description = "Ordinary wooden door",
    }

end

function unilib.pkg.door_wood_ordinary.exec()

    local burnlevel = 3

    unilib.register_door({
        -- From doors:door_wood. Creates unilib:door_wood_ordinary_closed_left, etc
        part_name = "wood_ordinary",
        orig_name_list = {
            "doors:door_wood_a",
            "doors:door_wood_b",
            "doors:door_wood_c",
            "doors:door_wood_d",
        },
        def_table = {
            description = S("Ordinary Wooden Door"),
            tiles = {{name = "unilib_door_wood_ordinary.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            gain_close = 0.13,
            gain_open = 0.06,
            inventory_image = "unilib_door_wood_ordinary_inv.png",
            recipe = {
                {"group:wood", "group:wood"},
                {"group:wood", "group:wood"},
                {"group:wood", "group:wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_wood",
    })
    unilib.register_craft({
        -- From doors:door_wood
        type = "fuel",
        recipe = "unilib:door_wood_ordinary",
        burntime = unilib.global.tree_burn_table.door[burnlevel]
    })

    -- This package provides deliberate craft recipe conflicts
    unilib.register_craft_conflicts({
        {"unilib:door_wood_ordinary", "unilib:door_wood_acacia_exotic"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_aspen_exotic"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_bamboo_exotic"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_baobab"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_birch_mature"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_chestnut"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_clementine"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_exotic"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_ipe_yellow"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_jungle_exotic"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_larch"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_maple_red"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_oak_mature"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_palm_exotic"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_pine_exotic"},
        {"unilib:door_wood_ordinary", "unilib:door_wood_willow_exotic"},
    })

end
