---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_cave_pink = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_cave_pink.init()

    return {
        description = "Pink cave flower",
    }

end

function unilib.pkg.flower_cave_pink.exec()

    unilib.register_node("unilib:flower_cave_pink", "moreplants:caveflower", mode, {
        -- From moreplants:caveflower
        description = S("Pink Cave Flower"),
        tiles = {"unilib_flower_cave_pink.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 1, flower = 1, snappy = 3},
        groups = {
            attached_node = 1, color_pink = 1, colour_pink = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_cave_pink.png",
        -- N.B. removed is_ground_content = false to match other flowers
--      is_ground_content = false,
        light_source = 5,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_flower_in_pot("unilib:flower_cave_pink", "moreplants:caveflower")

    unilib.register_decoration_generic("moreplants_flower_cave_pink", {
        -- Original to unilib (but the "meta_moreplants_underground" package also spanws this item)
        deco_type = "simple",
        decoration = "unilib:flower_cave_pink",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
