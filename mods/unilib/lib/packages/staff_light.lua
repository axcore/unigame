---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.staff_light = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.staff_light.init()

    return {
        description = "Staff of light",
        notes = "Converts stone nodes into glowstone lamps",
        depends = {
            "light_block_glowstone",
            "metal_steel",
            "mineral_mese",
            "mushroom_illumishroom_cyan",
            "mushroom_illumishroom_green",
            "mushroom_illumishroom_red",
        },
    }

end

function unilib.pkg.staff_light.exec()

    unilib.register_tool("unilib:staff_light", "ethereal:light_staff", mode, {
        -- From ethereal:light_staff
        description = S("Staff of Light"),
        inventory_image = "unilib_staff_light.png",
        sound = {breaks = "unilib_tool_breaks"},

        light_source = 13,
        stack_max = 1,
        wield_image = "unilib_staff_light.png",

        on_use = function(itemstack, user, pointed_thing)

            if pointed_thing.type ~= "node" then
                return
            end

            local pos = pointed_thing.under
            local pname = user:get_player_name()

            if minetest.is_protected(pos, pname) then

                minetest.record_protection_violation(pos, pname)
                return

            end

            local node = minetest.get_node(pos).name
            local def = minetest.registered_nodes[node]
            local stone = def and def.groups and def.groups.stone and def.groups.stone == 1

            if stone then

                minetest.set_node(pos, {name = "unilib:light_block_glowstone"})
                -- 150 uses
                itemstack:add_wear(65535 / 149)

                return itemstack

            end

        end
    })
    unilib.register_craft({
        -- From ethereal:light_staff
        output = "unilib:staff_light",
        recipe = {
            {
                "unilib:mushroom_illumishroom_red",
                "unilib:mineral_mese_crystal",
                "unilib:mushroom_illumishroom_red",
            },
            {
                "unilib:mushroom_illumishroom_green",
                "unilib:metal_steel_ingot",
                "unilib:mushroom_illumishroom_green",
            },
            {
                "unilib:mushroom_illumishroom_cyan",
                "unilib:metal_steel_ingot",
                "unilib:mushroom_illumishroom_cyan",
            },
        }
    })
    unilib.register_tool_no_repair(
        "unilib:staff_light", S("This staff is too exotic to be repaired")
    )

end
