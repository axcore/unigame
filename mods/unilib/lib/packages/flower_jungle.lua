---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_jungle.init()

    return {
        description = "Jungle flower",
    }

end

function unilib.pkg.flower_jungle.exec()

    unilib.register_node("unilib:flower_jungle", "moreplants:jungleflower", mode, {
        -- From moreplants:jungleflower
        description = S("Jungle Flower"),
        tiles = {"unilib_flower_jungle.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 1, flower = 1, snappy = 3},
        groups = {
            attached_node = 1, color_red = 1, colour_red = 1, flammable = 1, flora = 1, flower = 1,
            snappy = 3,
        },
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_jungle.png",
        -- N.B. removed is_ground_content = false to match other flowers
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, 0.4, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1.1,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_flower_in_pot("unilib:flower_jungle", "moreplants:jungleflower")

    unilib.register_decoration_generic("moreplants_flower_jungle", {
        -- From moreplants:jungleflower
        deco_type = "simple",
        decoration = "unilib:flower_jungle",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 16,
    })

end
