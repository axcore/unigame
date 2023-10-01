---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_spear_gungir = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_spear_gungir.init()

    return {
        description = "Gungir spear",
        depends = {"metal_geminitinum", "tool_spear_geminitinum", "tool_sword_excalibur"},
    }

end

function unilib.pkg.tool_spear_gungir.exec()

    unilib.register_tool("unilib:tool_spear_gungir", "xtraores:spear_gungir", mode, {
        -- From xtraores:spear_gungir
        description = S("The Gungir"),
        inventory_image = "unilib_tool_spear_gungir.png",
        -- N.B. no groups in original code
        groups = {spear = 1},
        sound = {breaks = "unilib_tool_breaks"},

        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 160},
            full_punch_interval = 0.3,
            groupcaps = {
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 200, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft({
        -- From xtraores:spear_gungir
        output = "unilib:tool_spear_gungir",
        recipe = {
            {
                "unilib:tool_sword_excalibur",
                "unilib:metal_geminitinum_ingot",
                "unilib:tool_sword_excalibur",
            },
            {
                "unilib:metal_geminitinum_ingot",
                "unilib:tool_spear_geminitinum",
                "unilib:metal_geminitinum_ingot",
            },
            {
                "unilib:tool_sword_excalibur",
                "unilib:metal_geminitinum_ingot",
                "unilib:tool_sword_excalibur",
            },
        },
    })

end
