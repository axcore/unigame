---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    columnia
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_bracket_rusty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.columnia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_bracket_rusty.init()

    return {
        description = "Rusty bracket",
        depends = {"metal_steel", "misc_blueprint_column"},
    }

end

function unilib.pkg.misc_bracket_rusty.exec()

    local c_blueprint = "unilib:misc_blueprint_column"
    local c_steel_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:misc_bracket_rusty", "columnia:bracket", mode, {
        -- From columnia:bracket
        description = "Rusty Bracket",
        tiles = {"unilib_decor_block_metal_rusty.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.stone,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, 0, 0.4375, 0.25, 0.5, 0.5},
                {-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875},
                {-0.0625, -0.375, -0.0625, 0.0625, 0.1875, 0.0625},
                {-0.0625, 0.1875, -0.0625, 0.0625, 0.3125, 0.4375},
                {-0.1875, 0.0625, 0.3125, 0.1875, 0.4375, 0.4375},
                {-0.125, -0.375, -0.125, 0.125, -0.25, 0.125},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From columnia:bracket
        output = "unilib:misc_bracket_rusty 4",
        recipe = {
            {c_steel_ingot, c_blueprint, ""},
            {"", c_steel_ingot, ""},
            {"", c_steel_ingot, ""},
        },
        replacements = {
            {c_blueprint, c_blueprint},
        },
    })

end
