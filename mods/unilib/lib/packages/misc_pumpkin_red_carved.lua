---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_pumpkin_red_carved = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_pumpkin_red_carved.init()

    return {
        description = "Carved Red Pumpkin",
        depends = "plant_pumpkin_red_wild",
    }

end

function unilib.pkg.misc_pumpkin_red_carved.exec()

    unilib.register_node("unilib:misc_pumpkin_red_carved", "cropocalypse:carved_pumpkin", mode, {
        -- From cropocalypse:carved_pumpkin
        description = S("Carved Red Pumpkin"),
        tiles = {
            "unilib_plant_pumpkin_red_wild_top.png",
            "unilib_plant_pumpkin_red_wild_bottom.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_misc_pumpkin_red_carved.png"
        },
        groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 2, pumpkin = 1},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From cropocalypse:carved_pumpkin
        type = "shapeless",
        output = "unilib:misc_pumpkin_red_carved",
        -- N.B. Original code used default:sword_wood
        recipe = {"unilib:plant_pumpkin_red_wild", "group:sword"},
    })

end
