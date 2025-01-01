---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_farming
-- Code:    MIT
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_straw_ordinary_dummy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_straw_ordinary_dummy.init()

    return {
        description = "Ordinary straw dummy",
        depends = "misc_straw_ordinary_bound",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.misc_straw_ordinary_dummy.exec()

    unilib.register_node("unilib:misc_straw_ordinary_dummy", "castle_farming:straw_dummy", mode, {
        -- From castle_farming:straw_dummy
        description = S("Straw Training Dummy"),
        tiles = {"unilib_misc_straw_ordinary_dummy.png"},
        groups = {choppy = 4, flammable = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.125, 0, 0.1875, 0.125},
                {0, -0.5, -0.125, 0.25, 0.1875, 0.125},
                {-0.25, 0.1875, -0.1875, 0.25, 0.875, 0.125},
                {0.25, 0.1875, -0.125, 0.5, 0.875, 0.125},
                {-0.5, 0.1875, -0.125, -0.25, 0.875, 0.125},
                {-0.25, 0.875, -0.25, 0.25, 1.3125, 0.1875},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From castle_farming:straw_dummy
        output = "unilib:misc_straw_ordinary_dummy",
        recipe = {
            {"group:stick", "unilib:misc_straw_ordinary_bound", "group:stick"},
            {"", "unilib:misc_straw_ordinary_bound", ""},
            {"group:stick", "", "group:stick"},
        },
    })
    if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

        local burn_time = core.get_craft_result(
            {method = "fuel", width = 1, items = {ItemStack("unilib:item_stick_ordinary")}}
        ).time

        unilib.register_craft({
            -- From castle_farming:straw_dummy
            type = "fuel",
            recipe = "unilib:misc_straw_ordinary_dummy",
            burntime = (10 * 2) + (4 * burn_time),
        })

    end

end
