---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_propane = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_propane.init()

    return {
        description = "Propane",
        depends = {"metal_steel", "torch_ordinary"},
    }

end

function unilib.pkg.misc_propane.exec()

    unilib.register_node("unilib:misc_propane", "bbq:propane", mode, {
        -- From bbq:propane
        description = S("Propane"),
        tiles = {"unilib_misc_propane.png"},
        groups = {attached_node = 1, dig_immediate = 3, explody = 1},
        sounds = unilib.global.sound_table.metal,

        drawtype = "plantlike",
        inventory_image = "unilib_misc_propane.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        wield_image = "unilib_misc_propane.png",
    })
    unilib.register_craft({
        -- From bbq:propane
        output = "unilib:misc_propane",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:torch_ordinary", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })
    unilib.register_craft({
        -- From bbq:propane
        type = "fuel",
        recipe = "unilib:misc_propane",
        burntime = 500,
    })

end
