---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_trampoline = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_trampoline.init()

    return {
        description = "Trampoline",
        depends = {"item_string_ordinary", "metal_steel"},
    }

end

function unilib.pkg.misc_trampoline.exec()

    local c_ingot = "unilib:metal_steel_ingot"
    local c_string = "unilib:item_string_ordinary"

    -- N.B. In the original code, the trampoline is transparent from the bottom. Create a new
    --  nodebox and replaced the transparent texture
    unilib.register_node("unilib:misc_trampoline", "xdecor:trampoline", mode, {
        -- From xdecor:trampoline
        description = S("Trampoline"),
        tiles = {
            "unilib_misc_trampoline_top.png",
--          "blank.png",
            "unilib_misc_trampoline_bottom.png",
            "unilib_misc_trampoline_side.png",
        },
        groups = {
            bouncy = 90,
            cracky = 3,
            fall_damage_add_percent = -80,
            oddly_breakable_by_hand = 1,
        },
        sounds = {
            footstep = {
                name = "unilib_misc_trampoline",
                gain = 0.8,
            },
        },

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        --[[
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        ]]--
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -5/16, -8/16, 8/16, 0, 8/16},       -- Top
                {8/16, -6/16, 8/16, 2/16, 0, 2/16},         -- NW upper leg
                {8/16, -8/16, 8/16, 3/16, 0, 3/16},         -- NW lower leg
                {8/16, -6/16, -8/16, 2/16, 0, -2/16},       -- NE upper leg
                {8/16, -8/16, -8/16, 3/16, 0, -3/16},       -- NE lower leg
                {-8/16, -6/16, 8/16, -2/16, 0, 2/16},       -- SW upper leg
                {-8/16, -8/16, 8/16, -3/16, 0, 3/16},       -- SW lower leg
                {-8/16, -6/16, -8/16, -2/16, 0, -2/16},     -- SE upper leg
                {-8/16, -8/16, -8/16, -3/16, 0, -3/16},     -- SE lower leg
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From xdecor:trampoline
        output = "unilib:misc_trampoline",
        recipe = {
            {c_string, c_string, c_string},
            {c_ingot, c_ingot, c_ingot},
            {c_ingot, "", c_ingot},
        },
    })

end
