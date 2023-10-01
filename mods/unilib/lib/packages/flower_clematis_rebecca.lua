---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_clematis_rebecca = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_clematis_rebecca.init()

    return {
        description = "Clematis Rebecca",
        notes = "This flower is edible",
    }

end

function unilib.pkg.flower_clematis_rebecca.exec()

    unilib.register_node("unilib:flower_clematis_rebecca", "moreplants:medflower", mode, {
        -- From moreplants:medflower
        description = unilib.annotate(S("Clematis Rebecca"), "Clematis"),
        tiles = {"unilib_flower_clematis_rebecca.png"},
        -- N.B. Replaced original groups with standard flower groups. No food_flower in original
        --      code
--      groups = {attached_node = 1, flammable = 1, flower = 1, food_flower = 1, snappy = 3},
        groups = {
            attached_node = 1, color_magenta = 1, flammable = 1, flora = 1, flower = 1,
            food_flower = 1, snappy = 3,
        },
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_clematis_rebecca.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},

        on_use = unilib.cuisine_eat_on_use("unilib:flower_clematis_rebecca", 1),
    })
    unilib.register_flower_in_pot("unilib:flower_clematis_rebecca", "moreplants:medflower")

    unilib.register_decoration("moreplants_flower_clematis_rebecca", {
        -- From moreplants:medflower
        deco_type = "simple",
        decoration = "unilib:flower_clematis_rebecca",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
