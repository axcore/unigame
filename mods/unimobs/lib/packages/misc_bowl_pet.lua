---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_bowl_pet = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_bowl_pet.init()

    return {
        description = "Pet bowl",
        notes = "Pets will stay near a pet bowl, so put one in any house you build for your" ..
                " tamed creatures. In Tamagotchi Mode, it also feeds tamed creatures",
        depends = "dye_basic",
    }

end

function unilib.pkg.misc_bowl_pet.exec()

    unilib.register_node("unilib:misc_bowl_pet", "petz:pet_bowl", mode, {
        -- From petz:pet_bowl
        description = S("Pet Bowl"),
        tiles = {"unilib_misc_bowl_pet.png"},
        groups = {bendy = 2, cracky = 1, feeder = 1, snappy = 1},
        sounds = unilib.global.sound_table.stone,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_bowl_pet_inv.png",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
                {-0.1875, -0.4375, -0.1875, 0.1875, -0.375, -0.125},
                {-0.1875, -0.4375, 0.125, 0.1875, -0.375, 0.1875},
                {-0.1875, -0.4375, -0.125, -0.125, -0.375, 0.125},
                {0.125, -0.4375, -0.125, 0.1875, -0.375, 0.125},
            },
        },
        paramtype = "light",
        wield_image = "unilib_misc_bowl_pet_inv.png",
    })
    unilib.register_craft({
        -- From petz:pet_bowl
        type = "shaped",
        output = "unilib:misc_bowl_pet",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
            {"", "unilib:dye_red", ""},
        },
    })

end
