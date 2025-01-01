---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.staff_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.staff_light.init()

    return {
        description = "Staff of light",
        notes = "Converts stone nodes into glowstone lamps. If the \"nether\" mod is available," ..
                " converts some other nodes into luminous equiavalents",
        mod_depends = "nether",
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

    -- List of alternative nodes that are also converted by the staff
    local alt_table = {
        ["nether:rack"] = "nether:glowstone",
        ["nether:rack_deep"] = "nether:glowstone_deep"
    }

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

            if core.is_protected(pos, pname) then

                core.record_protection_violation(pos, pname)
                return

            end

            local full_name = core.get_node(pos).name
            local def = core.registered_nodes[full_name]
            local stone = def and def.groups and def.groups.stone and def.groups.stone == 1

            if stone then

                core.set_node(pos, {name = "unilib:light_block_glowstone"})

                -- 150 uses
                itemstack:add_wear(unilib.constant.max_tool_wear / 149)
                return itemstack

            elseif alt_table[full_name] ~= nil then

                core.set_node(pos, {name = alt_table[full_name]})
                itemstack:add_wear(unilib.constant.max_tool_wear / 149)
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
        },
    })
    unilib.tools.register_no_repair(
        "unilib:staff_light", S("This staff is too exotic to be repaired")
    )

end
