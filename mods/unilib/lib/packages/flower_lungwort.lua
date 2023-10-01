---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lungwort = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lungwort.init()

    return {
        description = "Lungwort",
    }

end

function unilib.pkg.flower_lungwort.exec()

    unilib.register_node("unilib:flower_lungwort", "moreplants:blueflower", mode, {
        -- From moreplants:blueflower
        description = unilib.annotate(S("Lungwort"), "Pulmonaria"),
        tiles = {"unilib_flower_lungwort.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 1, flower = 1, snappy = 3},
        groups = {
            attached_node = 1, color_blue = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_lungwort.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_flower_in_pot("unilib:flower_lungwort", "moreplants:blueflower")

    unilib.register_decoration("moreplants_flower_lungwort", {
        -- From moreplants:blueflower
        deco_type = "simple",
        decoration = "unilib:flower_lungwort",

        fill_ratio = 0.001,
        height = 1,
        sidelen = 16,
    })

end
