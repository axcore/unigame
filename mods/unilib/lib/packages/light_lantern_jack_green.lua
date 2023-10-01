---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_jack_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_jack_green.init()

    return {
        description = "Green Jack 'O Lantern",
        depends = {"misc_watermelon_carved", "torch_ordinary"},
    }

end

function unilib.pkg.light_lantern_jack_green.exec()

    unilib.register_node("unilib:light_lantern_jack_green", "cropocalypse:jack_o_lantern", mode, {
        -- From cropocalypse:jack_o_lantern
        description = S("Green Jack O'Lantern"),
        tiles = {
            "unilib_plant_watermelon_wild_top.png",
            "unilib_plant_watermelon_wild_top.png",
            "unilib_plant_watermelon_wild.png",
            "unilib_plant_watermelon_wild.png",
            "unilib_plant_watermelon_wild.png",
            "unilib_light_lantern_jack_green.png"
        },
        groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 2, watermelon = 1},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        light_source = 11,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From cropocalypse:jack_o_lantern
        type = "shapeless",
        output = "unilib:light_lantern_jack_green",
        recipe = {"unilib:misc_watermelon_carved", "unilib:torch_ordinary"}
    })

end
