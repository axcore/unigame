---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_weed_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_weed_normal.init()

    return {
        description = "Normal weed",
        optional = "item_paper_ordinary",
    }

end

function unilib.pkg.plant_weed_normal.exec()

    unilib.register_node("unilib:plant_weed_normal", "moreplants:weed", mode, {
        -- From moreplants:weed
        description = S("Normal Weed"),
        tiles = {"unilib_plant_weed_normal.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_weed_normal.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.1,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    if unilib.pkg_executed_table["item_paper_ordinary"] ~= nil then

        unilib.register_craft({
            -- From moreplants:weed
            output = "unilib:item_paper_ordinary",
            recipe = {
                {
                    "unilib:plant_weed_normal",
                    "unilib:plant_weed_normal",
                    "unilib:plant_weed_normal",
                },
            },
        })

    end
    unilib.register_plant_in_pot("unilib:plant_weed_normal", "moreplants:weed")

    unilib.register_decoration("moreplants_plant_weed_normal", {
        -- From moreplants:weed
        deco_type = "simple",
        decoration = "unilib:plant_weed_normal",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 26,
    })

end
