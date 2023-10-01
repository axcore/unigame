---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_watermelon_carved = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_watermelon_carved.init()

    return {
        description = "Carved watermelon",
        depends = "plant_watermelon_wild",
    }

end

function unilib.pkg.misc_watermelon_carved.exec()

    unilib.register_node("unilib:misc_watermelon_carved", "cropocalypse:carved_watermelon", mode, {
        -- From cropocalypse:carved_watermelon
        description = S("Carved Watermelon"),
        tiles = {
            "unilib_plant_watermelon_wild_top.png",
            "unilib_plant_watermelon_wild_top.png",
            "unilib_plant_watermelon_wild.png",
            "unilib_plant_watermelon_wild.png",
            "unilib_plant_watermelon_wild.png",
            "unilib_misc_watermelon_carved.png"
        },
        groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 2, watermelon = 1},
        sounds = unilib.sound_table.wood,

        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            }
        },
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From cropocalypse:carved_watermelon
        type = "shapeless",
        output = "unilib:misc_watermelon_carved",
        -- N.B. Original code used default:sword_wood
        recipe = {"unilib:plant_watermelon_wild", "group:sword"}
    })

end
