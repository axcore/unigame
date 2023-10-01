---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_ivy_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_ivy_normal.init()

    return {
        description = "Normal ivy",
        notes = "Seems to be a decorative item, that must be crafted, not found in nature",
    }

end

function unilib.pkg.plant_ivy_normal.exec()

    unilib.register_node("unilib:plant_ivy_normal", "xdecor:ivy", mode, {
        -- From xdecor:ivy
        description = unilib.annotate(S("Normal Ivy"), "Hedera"),
        tiles = {"unilib_plant_ivy_normal.png"},
        groups = {attached_node = 1, flammable = 3, flora = 1, plant = 1,  snappy = 3},
        sounds = unilib.sound_table.leaves,

        climbable = true,
        drawtype = "signlike",
        inventory_image = "unilib_plant_ivy_normal.png",
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {type = "wallmounted"},
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_plant_ivy_normal.png",
    })
    unilib.register_craft({
        -- From xdecor:ivy
        output = "unilib:plant_ivy_normal 4",
        recipe = {
            {"group:leaves"},
            {"group:leaves"},
        },
    })
    unilib.register_plant_in_pot("unilib:plant_ivy_normal", "xdecor:ivy")

end
