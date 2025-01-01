---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
--
-- From:    vessels
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_bottle_steel_empty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.vessels.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_bottle_steel_empty.init()

    return {
        description = "Empty heavy steel bottle",
        depends = "metal_steel",
    }

end

function unilib.pkg.vessel_bottle_steel_empty.exec()

    unilib.register_node("unilib:vessel_bottle_steel_empty", "vessels:steel_bottle", mode, {
        -- From vessels:steel_bottle
        description = S("Empty Heavy Steel Bottle"),
        tiles = {"unilib_vessel_bottle_steel_empty.png"},
        groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
        sounds = unilib.global.sound_table.node,

        drawtype = "plantlike",
        inventory_image = "unilib_vessel_bottle_steel_empty.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
        },
        walkable = false,
        wield_image = "unilib_vessel_bottle_steel_empty.png",
    })
    unilib.register_craft( {
        -- From vessels:steel_bottle
        output = "unilib:vessel_bottle_steel_empty 5",
        recipe = {
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })
    unilib.register_craft( {
        -- From vessels:steel_bottle
        type = "cooking",
        output = "unilib:metal_steel_ingot",
        recipe = "unilib:vessel_bottle_steel_empty",
    })
    -- From "thirsty" mod
    unilib.hydration.enable_drinking_from_container("unilib:vessel_bottle_steel_empty", 26)

end
