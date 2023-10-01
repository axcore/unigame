---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_iron_pig = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pigiron.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_iron_pig.init()

    return {
        description = "Pig iron pickaxe",
        notes = "Pig iron tools are designed to be less-powerful alternatives to steel tools",
        depends = "metal_iron_pig",
    }

end

function unilib.pkg.tool_pick_iron_pig.exec()

    unilib.register_tool("unilib:tool_pick_iron_pig", "pigiron:pick_iron", mode, {
        -- From pigiron:pick_iron
        description = S("Pig Iron Pickaxe"),
        inventory_image = "unilib_tool_pick_iron_pig.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 1.2,
            groupcaps = {
                cracky = {
                    times = {[1] = 2.5, [2] = 1.40, [3] = 0.95},
                    uses = 20, maxlevel = 2
                },
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_pick({
        -- From pigiron:pick_iron
        part_name = "iron_pig",
        ingredient = "unilib:metal_iron_pig_ingot",
    })
    unilib.apply_toolranks("unilib:tool_pick_iron_pig", "pickaxe")

end
