---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.staff_gilly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

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
            "mineral_crystallite",
        },
    }

end

function unilib.pkg.staff_gilly.exec()

    local c_ingot = "unilib:mineral_crystallite_ingot"

    unilib.register_tool("unilib:staff_gilly", "ethereal:crystal_gilly_staff", mode, {
        -- ethereal:crystal_gilly_staff
        description = S("Gilly Staff"),
        inventory_image = "unilib_staff_gilly.png",

        wield_image = "unilib_staff_gilly.png",

        on_use = function(itemstack, user, pointed_thing)

            if user and user:get_breath() < 10 then

                user:set_breath(10)

                -- N.B. No wear in original code
                local pname = user and user:get_player_name() or ""
                if not unilib.utils.is_creative(pname) then

                    -- 150 uses
                    itemstack:add_wear(unilib.constant.max_tool_wear / 149)

                end

            end

        end
    })
    unilib.register_craft({
        -- ethereal:crystal_gilly_staff
        output = "unilib:staff_gilly",
        recipe = {
            {"unilib:dirt_mossy_green", "unilib:dirt_mossy_grey", "unilib:dirt_mossy_fiery"},
            {"unilib:dirt_mossy_crystal", c_ingot, "unilib:dirt_mossy_mushroom"},
            {"", c_ingot, ""},
        },
    })

end
