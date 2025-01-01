---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_crystallite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_crystallite.init()

    return {
        description = "Crystallite sword",
        -- N.B. Mese is required to craft the ingot, that crafts this tool
        depends = {"metal_steel", "mineral_crystallite", "mineral_mese"},
    }

end

function unilib.pkg.tool_sword_crystallite.exec()

    unilib.register_tool("unilib:tool_sword_crystallite", "ethereal:sword_crystal", mode, {
        -- From ethereal:sword_crystal
        description = S("Crystallite Sword"),
        inventory_image = "unilib_tool_sword_crystallite.png",
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 10},
            full_punch_interval = 0.6,
            groupcaps = {
                snappy = {
                    times = {[1] = 1.70, [2] = 0.70, [3] = 0.25},
                    uses = 50,
                    maxlevel = 3,
                },
            },
            max_drop_level = 1,
        },
        wield_image = "unilib_tool_sword_crystallite.png",

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft({
        -- From ethereal:sword_crystal
        output = "unilib:tool_sword_crystallite",
        recipe = {
            {"unilib:mineral_crystallite_ingot"},
            {"unilib:mineral_crystallite_ingot"},
            {"unilib:metal_steel_ingot"},
        },
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_crystallite", "sword")

end
