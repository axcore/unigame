---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_fungus_glowing_purple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_fungus_glowing_purple.init()

    return {
        description = "Purple glowing fungus",
    }

end

function unilib.pkg.plant_fungus_glowing_purple.exec()

    unilib.register_node("unilib:plant_fungus_glowing_purple", "caverealms:fungus", mode, {
        -- From caverealms:fungus
        description = S("Purple Glowing Fungus"),
        tiles = {"unilib_plant_fungus_glowing_purple.png"},
        -- N.B. attached_node = 1, flora = 1 not in original code
        groups = {attached_node = 1, flora = 1, oddly_breakable_by_hand = 3},
        -- (no sounds)

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_fungus_glowing_purple.png",
        light_source = 5,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        visual_scale = 1.0,
        walkable = false,
        wield_image = "unilib_plant_fungus_glowing_purple.png",
    })
    unilib.register_plant_in_pot("unilib:plant_fungus_glowing_purple", "caverealms:fungus")

    unilib.register_decoration_spare("unilib:plant_fungus_glowing_purple")

end
