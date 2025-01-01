---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_spatula = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_spatula.init()

    return {
        description = "Barbecue spatula",
        depends = {"item_stick_ordinary", "metal_tin", "shared_bbq"},
    }

end

function unilib.pkg.utensil_spatula.exec()

    unilib.register_node("unilib:utensil_spatula", "bbq:spatula", mode, {
        -- From bbq:spatula
        description = S("Spatula"),
        tiles = {"unilib_utensil_spatula_tile.png"},
        groups = {cracky = 1, dig_immediate = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        inventory_image = "unilib_utensil_spatula.png",
        -- N.B. is_ground_content = false not in original code; added to match other utensil and
        --      vessel packages
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.15, -0.45, 0.5, 0.125, -.218, 0.45},
                {-0.105, -0.218, 0.5, 0.085, -0.19, 0.45},
                {-0.0625, -0.19, 0.5, 0.03125, .5, 0.45},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        wield_image = "unilib_utensil_spatula.png",

        on_use = unilib.pkg.shared_bbq.on_use_play_sound("unilib_bbq_sizzle"),
    })
    unilib.register_craft({
        -- From bbq:spatula
        output = "unilib:utensil_spatula",
        recipe = {
            {"", "unilib:metal_tin_ingot", ""},
            {"", "unilib:metal_tin_ingot", ""},
            {"", "unilib:item_stick_ordinary", ""},
        },
    })

end
