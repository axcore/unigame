---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.staff_gilly = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.staff_gilly.init()

    return {
        description = "Gilly staff",
        notes = "Replenishes air supply when used",
        depends = {
            "dirt_mossy_crystal",
            "dirt_mossy_fiery",
            "dirt_mossy_grey",
            "dirt_mossy_green",
            "dirt_mossy_mushroom",
            -- N.B. Mese is required to craft the ingot, that crafts this staff
            "mineral_mese",
            "mineral_crystallinum",
        },
    }

end

function unilib.pkg.staff_gilly.exec()

    unilib.register_tool("unilib:staff_gilly", "ethereal:crystal_gilly_staff", mode, {
        -- ethereal:crystal_gilly_staff
        description = S("Gilly Staff"),
        inventory_image = "unilib_staff_gilly.png",

        wield_image = "unilib_staff_gilly.png",

        on_use = function(itemstack, user, pointed_thing)

            if user:get_breath() < 10 then
                user:set_breath(10)
            end

        end
    })
    unilib.register_craft({
        -- ethereal:crystal_gilly_staff
        type = "shapeless",
        output = "unilib:staff_gilly",
        recipe = {
            "unilib:dirt_mossy_green",
            "unilib:dirt_mossy_grey",
            "unilib:dirt_mossy_fiery",
            "unilib:dirt_mossy_crystal",
            "unilib:mineral_crystallinum_ingot",
            "unilib:dirt_mossy_mushroom",
            "unilib:mineral_crystallinum_ingot"
        },
    })

end
