---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_crystallinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_crystallinum.init()

    return {
        description = "Crystallinum axe",
        -- N.B. Mese is required to craft the ingot, that crafts this tool
        depends = {"metal_steel", "mineral_crystallinum", "mineral_mese"},
    }

end

function unilib.pkg.tool_axe_crystallinum.exec()

    unilib.register_tool("unilib:tool_axe_crystallinum", "ethereal:axe_crystal", mode, {
        -- From ethereal:axe_crystal
        description = S("Crystallinum Axe"),
        inventory_image = "unilib_tool_axe_crystallinum.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 7},
            full_punch_interval = 0.8,
            groupcaps = {
                choppy = {
                    times = {[1] = 2.00, [2] = 0.80, [3] = 0.40},
                    uses = 40,
                    maxlevel = 3,
                },
            },
            max_drop_level = 1,
        },
        wield_image = "unilib_tool_axe_crystallinum.png",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft({
        -- From ethereal:axe_crystal
        output = "unilib:tool_axe_crystallinum",
        recipe = {
            {"unilib:mineral_crystallinum_ingot", "unilib:mineral_crystallinum_ingot"},
            {"unilib:mineral_crystallinum_ingot", "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_ingot"},
        }
    })
    unilib.register_craft({
        -- From ethereal:axe_crystal
        output = "unilib:tool_axe_crystallinum",
        recipe = {
            {"unilib:mineral_crystallinum_ingot", "unilib:mineral_crystallinum_ingot"},
            {"unilib:metal_steel_ingot", "unilib:mineral_crystallinum_ingot"},
            {"unilib:metal_steel_ingot", ""},
        },
    })
    unilib.apply_toolranks("unilib:tool_axe_crystallinum", "axe")

end
