---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_hoe_iron_pig = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pigiron.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_hoe_iron_pig.init()

    return {
        description = "Pig iron hoe",
        notes = "Pig iron tools are designed to be less-powerful alternatives to steel tools",
        depends = "metal_iron_pig",
    }

end

function unilib.pkg.tool_hoe_iron_pig.exec()

    unilib.register_hoe({
        -- From pigiron, farming:hoe_iron
        part_name = "iron_pig",
        full_name = "unilib:tool_hoe_iron_pig",
        orig_name = "farming:hoe_iron",
        def_table = {
            description = S("Pig Iron Hoe"),
            inventory_image = "unilib_tool_hoe_iron_pig.png",
            groups = {hoe = 1},

            ingredient = "unilib:metal_iron_pig_ingot",
            max_uses = 150,
        },

        replace_mode = mode,
        damage_group_table = {fleshy = 2},
    })
    unilib.tools.apply_toolranks("unilib:tool_hoe_iron_pig", "hoe")

end
