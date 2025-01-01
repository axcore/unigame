---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_crystallite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_crystallite.init()

    return {
        description = "Crystallite shovel",
        notes = "For any node in the \"crumbly\" or \"coral\" groups, digs the original node;" ..
                " for example, digs the original dirt with grass node rather than a pure dirt" ..
                " node, and digs the original coral rather than its corresponding coral skeleton",
        -- N.B. Mese is required to craft the ingot, that crafts this tool
        depends = {"metal_steel", "mineral_crystallite", "mineral_mese"},
    }

end

function unilib.pkg.tool_shovel_crystallite.exec()

    unilib.register_tool("unilib:tool_shovel_crystallite", "ethereal:shovel_crystal", mode, {
        -- From ethereal:shovel_crystal
        description = S("Crystallite Shovel"),
        inventory_image = "unilib_tool_shovel_crystallite.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.0,
            groupcaps = {
                crumbly = {
                    times = {[1] = 1.10, [2] = 0.50, [3] = 0.30},
                    uses = 30,
                    maxlevel = 3,
                },
                -- Not in original code: treat corals like things in the "crumbly" group
                coral = {
                    times = {[1] = 1.10, [2] = 0.50, [3] = 0.30},
                    uses = 30,
                    maxlevel = 3,
                },
            },
            max_drop_level = 1,
        },

        wield_image = "unilib_tool_shovel_crystallite.png^[transformR90",

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft({
        -- From ethereal:shovel_crystal
        output = "unilib:tool_shovel_crystallite",
        recipe = {
            {"unilib:mineral_crystallite_ingot"},
            {"unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot"},
        },
    })
    unilib.tools.apply_toolranks("unilib:tool_shovel_crystallite", "shovel")

    -- (Dig the original node, e.g. dirt with grass instead of dirt)
    unilib.register_special_shovel("unilib:tool_shovel_crystallite")

end
