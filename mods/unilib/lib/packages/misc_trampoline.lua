---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_trampoline = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

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

    unilib.register_node("unilib:misc_trampoline", "xdecor:trampoline", mode, {
        -- From xdecor:trampoline
        description = S("Trampoline"),
        tiles = {
            "unilib_misc_trampoline.png",
            "blank.png",
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
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
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
