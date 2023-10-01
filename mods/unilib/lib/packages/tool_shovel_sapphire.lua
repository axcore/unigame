---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemtools
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_sapphire = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.gemtools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_sapphire.init()

    return {
        description = "Sapphire shovel",
        depends = "mineral_sapphire",
    }

end

function unilib.pkg.tool_shovel_sapphire.exec()

    unilib.register_tool("unilib:tool_shovel_sapphire", "gemtools:shovel_sapphire", mode, {
        -- From gemtools:shovel_sapphire
        description = S("Sapphire Shovel"),
        inventory_image = "unilib_tool_shovel_sapphire.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 1.0,
            groupcaps = {
                crumbly = {times = {[1] = 1.30, [2] = 0.70, [3] = 0.30}, uses = 30, maxlevel = 3},
            },
            max_drop_level = 1,
        },
        -- N.B. no transform in original code
        wield_image = "unilib_tool_shovel_sapphire.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_shovel({
        -- From gemtools:shovel_sapphire
        part_name = "sapphire",
        ingredient = "unilib:mineral_sapphire_gem",
    })
    unilib.apply_toolranks("unilib:tool_shovel_sapphire", "shovel")

end
