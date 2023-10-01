---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_iron_pig = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pigiron.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_iron_pig.init()

    return {
        description = "Pig iron sword",
        notes = "Pig iron tools are designed to be less-powerful alternatives to steel tools",
        depends = "metal_iron_pig",
    }

end

function unilib.pkg.tool_sword_iron_pig.exec()

    unilib.register_tool("unilib:tool_sword_iron_pig", "pigiron:sword_iron", mode, {
        -- From pigiron:sword_iron
        description = S("Pig Iron Sword"),
        inventory_image = "unilib_tool_sword_iron_pig.png",
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 1.0,
            groupcaps = {
                snappy = {
                    times = {[1] = 2.0, [2] = 1.30, [3] = 0.38},
                    uses = 25, maxlevel = 1
                },
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_sword({
        -- From pigiron:sword_iron
        part_name = "iron_pig",
        ingredient = "unilib:metal_iron_pig_ingot",
    })
    unilib.apply_toolranks("unilib:tool_sword_iron_pig", "sword")

end
