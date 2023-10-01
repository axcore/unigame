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

unilib.pkg.vessel_bottle_glass_empty = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.vessels.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_bottle_glass_empty.init()

    return {
        description = "Empty glass bottle",
        depends = "glass_ordinary",
    }

end

function unilib.pkg.vessel_bottle_glass_empty.exec()

    unilib.register_node("unilib:vessel_bottle_glass_empty", "vessels:glass_bottle", mode, {
        -- From vessels:glass_bottle
        description = S("Empty Glass Bottle"),
        tiles = {"unilib_vessel_bottle_glass_empty.png"},
        groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_vessel_bottle_glass_empty.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
        },
        walkable = false,
        wield_image = "unilib_vessel_bottle_glass_empty.png",
    })
    unilib.register_craft( {
        -- From vessels:glass_bottle
        output = "unilib:vessel_bottle_glass_empty 10",
        recipe = {
            {"unilib:glass_ordinary", "", "unilib:glass_ordinary"},
            {"unilib:glass_ordinary", "", "unilib:glass_ordinary"},
            {"", "unilib:glass_ordinary", ""}
        }
    })
    unilib.register_craft( {
        -- From vessels:glass_bottle
        type = "shapeless",
        output = "unilib:glass_ordinary_fragments",
        recipe = {
            "unilib:vessel_bottle_glass_empty",
            "unilib:vessel_bottle_glass_empty",
        },
    })
    -- From "thirsty" mod
    unilib.hydration_enable_drinking_from_container("unilib:vessel_bottle_glass_empty", 24)

end
