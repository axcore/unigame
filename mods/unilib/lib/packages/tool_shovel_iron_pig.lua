---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_iron_pig = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pigiron.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_iron_pig.init()

    return {
        description = "Pig iron shovel",
        notes = "Pig iron tools are designed to be less-powerful alternatives to steel tools",
        depends = "metal_iron_pig",
    }

end

function unilib.pkg.tool_shovel_iron_pig.exec()

    unilib.register_tool("unilib:tool_shovel_iron_pig", "pigiron:shovel_iron", mode, {
        -- From pigiron:shovel_iron
        description = S("Pig Iron Shovel"),
        inventory_image = "unilib_tool_shovel_iron_pig.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 2},
            full_punch_interval = 1.3,
            groupcaps = {
                crumbly = {
                    times = {[1] = 1.70, [2] = 1.0, [3] = 0.45},
                    uses = 25, maxlevel = 1
                },
            },
            max_drop_level = 1,
        },
        wield_image = "unilib_tool_shovel_iron_pig.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_shovel({
        -- From pigiron:shovel_iron
        part_name = "iron_pig",
        ingredient = "unilib:metal_iron_pig_ingot",
    })
    unilib.apply_toolranks("unilib:tool_shovel_iron_pig", "shovel")

end
