---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_crystallinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_crystallinum.init()

    return {
        description = "Crystallinum pickaxe",
        -- N.B. Mese is required to craft the ingot, that crafts this tool
        depends = {"metal_steel", "mineral_crystallinum", "mineral_mese"},
    }

end

function unilib.pkg.tool_pick_crystallinum.exec()

    local c_crystal_ingot = "unilib:mineral_crystallinum_ingot"

    unilib.register_tool("unilib:tool_pick_crystallinum", "ethereal:pick_crystal", mode, {
        -- From ethereal:pick_crystal
        description = S("Crystallinum Pickaxe"),
        inventory_image = "unilib_tool_pick_crystallinum.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 6},
            full_punch_interval = 0.7,
            groupcaps={
                cracky = {
                    times = {[1] = 1.8, [2] = 0.8, [3] = 0.40},
                    uses = 40,
                    maxlevel = 3,
                },
            },
            max_drop_level = 3,
        },
        wield_image = "unilib_tool_pick_crystallinum.png",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft({
        -- From ethereal:pick_crystal
        output = "unilib:tool_pick_crystallinum",
        recipe = {
            {c_crystal_ingot, c_crystal_ingot, c_crystal_ingot},
            {"", "unilib:metal_steel_ingot", ""},
            {"", "unilib:metal_steel_ingot", ""},
        }
    })
    unilib.apply_toolranks("unilib:tool_pick_crystallinum", "pickaxe")

end
