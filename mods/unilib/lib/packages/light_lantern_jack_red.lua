---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_jack_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_jack_red.init()

    return {
        description = "Red Jack 'O Lantern",
        depends = {"misc_pumpkin_red_carved", "torch_ordinary"},
    }

end

function unilib.pkg.light_lantern_jack_red.exec()

    unilib.register_node("unilib:light_lantern_jack_red", "cropocalypse:jack_olantern", mode, {
        -- From cropocalypse:jack_olantern
        description = S("Red Jack O'Lantern"),
        tiles = {
            "unilib_plant_pumpkin_red_wild_top.png",
            "unilib_plant_pumpkin_red_wild_bottom.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_plant_pumpkin_red_wild.png",
            "unilib_light_lantern_jack_red.png"
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
        light_source = 11,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From cropocalypse:jack_olantern
        type = "shapeless",
        output = "unilib:light_lantern_jack_red",
        recipe = {"unilib:misc_pumpkin_red_carved", "unilib:torch_ordinary"}
    })

end
