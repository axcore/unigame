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

unilib.pkg.vessel_glass_empty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.vessels.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_glass_empty.init()

    return {
        description = "Empty glass",
        depends = "glass_ordinary",
    }

end

function unilib.pkg.vessel_glass_empty.exec()

    unilib.register_node("unilib:vessel_glass_empty", "vessels:drinking_glass", mode, {
        -- From vessels:drinking_glass
        description = S("Empty Glass"),
        tiles = {"unilib_vessel_glass_empty.png"},
        groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_vessel_glass_empty_inv.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
        },
        walkable = false,
        wield_image = "unilib_vessel_glass_empty.png",
    })
    unilib.register_craft({
        -- From vessels:drinking_glass
        output = "unilib:vessel_glass_empty 14",
        recipe = {
            {"unilib:glass_ordinary", "", "unilib:glass_ordinary"},
            {"unilib:glass_ordinary", "", "unilib:glass_ordinary"},
            {"unilib:glass_ordinary", "unilib:glass_ordinary", "unilib:glass_ordinary"},
        },
    })
    unilib.register_craft({
        -- From vessels:drinking_glass
        type = "shapeless",
        output = "unilib:glass_ordinary_fragments",
        recipe = {
            "unilib:vessel_glass_empty",
            "unilib:vessel_glass_empty",
        },
    })
    -- From "thirsty" mod
    unilib.hydration.enable_drinking_from_container("unilib:vessel_glass_empty", 22)

end
