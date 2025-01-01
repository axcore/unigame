---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_iron_pig = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pigiron.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_iron_pig.init()

    return {
        description = "Pig iron axe",
        notes = "Pig iron tools are designed to be less-powerful alternatives to steel tools",
        depends = "metal_iron_pig",
    }

end

function unilib.pkg.tool_axe_iron_pig.exec()

    unilib.register_tool("unilib:tool_axe_iron_pig", "pigiron:axe_iron", mode, {
        -- From pigiron:axe_iron
        description = S("Pig Iron Axe"),
        inventory_image = "unilib_tool_axe_iron_pig.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 1.1,
            groupcaps = {
                choppy = {
                    times = {[1] = 2.70, [2] = 1.70, [3] = 1.15},
                    uses = 20, maxlevel = 1
                },
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_axe({
        -- From pigiron:axe_iron
        part_name = "iron_pig",
        ingredient = "unilib:metal_iron_pig_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_axe_iron_pig", "axe")

end
