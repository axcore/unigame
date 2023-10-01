---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_crystallinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_crystallinum.init()

    return {
        description = "Crystallinum shovel",
        notes = "For any node in the \"crumbly\" group, digs the original node; for example," ..
                " digs the original dirt with grass node, rather than a pure dirt node",
        -- N.B. Mese is required to craft the ingot, that crafts this tool
        depends = {"metal_steel", "mineral_crystallinum", "mineral_mese"},
        optional = "override_ethereal_coral",
    }

end

function unilib.pkg.tool_shovel_crystallinum.exec()

    unilib.register_tool("unilib:tool_shovel_crystallinum", "ethereal:shovel_crystal", mode, {
        -- From ethereal:shovel_crystal
        description = S("Crystallinum Shovel"),
        inventory_image = "unilib_tool_shovel_crystallinum.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.0,
            max_drop_level = 1,
            groupcaps = {
                crumbly = {
                    times = {[1] = 1.10, [2] = 0.50, [3] = 0.30},
                    uses = 30,
                    maxlevel = 3,
                },
            },
        },

        wield_image = "unilib_tool_shovel_crystallinum.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft({
        -- From ethereal:shovel_crystal
        output = "unilib:tool_shovel_crystallinum",
        recipe = {
            {"unilib:mineral_crystallinum_ingot"},
            {"unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot"},
        }
    })
    unilib.apply_toolranks("unilib:tool_shovel_crystallinum", "shovel")

    -- (Dig the original node, e.g. dirt with grass instead of dirt)
    unilib.register_special_shovel("unilib:tool_shovel_crystallinum")

end
