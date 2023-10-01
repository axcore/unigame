---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    anvil
-- Code:    GPL-3.0-only
-- Media:   GPL-3.0-only
--
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_hammer_blacksmith = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_hammer_blacksmith.init()

    return {
        description = "Blacksmith's hammer",
        notes = "Used with a simple anvil",
        depends = "metal_steel",
        at_least_one = {"machine_anvil_simple", "machine_anvil_fancy"},
    }

end

function unilib.pkg.tool_hammer_blacksmith.exec()

    unilib.register_tool(
        -- From cottages:hammer, code/textures are very similar to the equivalent tool in the
        --      "anvil" mod
        "unilib:tool_hammer_blacksmith",
        {"cottages:hammer", "anvil:hammer"},
        mode,
        {
            description = unilib.hint(S("Blacksmith's Hammer"), S("repairs tools on anvils")),
            inventory_image = "unilib_tool_hammer_blacksmith.png",
            -- (no groups)
            -- (no sound)

            tool_capabilities = {
                damage_groups = {fleshy = 6},
                full_punch_interval = 0.8,
                groupcaps = {
                    -- About equal to a stone pick (it's not intended as an actual tool)
                    cracky = {times = {[2] = 2.00, [3] = 1.20}, uses = 30, maxlevel = 1},
                },
                max_drop_level = 1,
            },
        }
    )
    if unilib.pkg_executed_table["machine_anvil_simple"] ~= nil then

        unilib.register_craft({
            -- From cottages:hammer
            output = "unilib:tool_hammer_blacksmith",
            recipe = {
                {"unilib:metal_steel_ingot"},
                {"unilib:machine_anvil_simple"},
                {"group:stick"},
            },
        })

    end
    if unilib.pkg_executed_table["machine_anvil_fancy"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:tool_hammer_blacksmith",
            recipe = {
                {"unilib:metal_steel_ingot"},
                {"unilib:machine_anvil_fancy"},
                {"group:stick"},
            },
        })

    end

end
