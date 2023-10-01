---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_table_simple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_table_simple.init()

    return {
        description = "Simple table",
    }

end

function unilib.pkg.furniture_table_simple.exec()

    unilib.register_node("unilib:furniture_table_simple", "xdecor:table", mode, {
        -- From xdecor:table
        description = S("Simple Table"),
        tiles = {"unilib_misc_wood_simple.png"},
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, 0.375, -0.5, 0.5, 0.5, 0.5},
                {-0.15625, -0.5, -0.15625, 0.15625, 0.375, 0.21875},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
    })
    -- N.B. original code used stairs:slab_wood
    unilib.register_craft({
        -- From xdecor:table
        output = "unilib:furniture_table_simple",
        recipe = {
            {"group:wood_stair_slab", "group:wood_stair_slab", "group:wood_stair_slab"},
            {"", "group:stick", ""},
            {"", "group:stick", ""}
        },
    })

end
