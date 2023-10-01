---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemtools
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_emerald = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.gemtools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_emerald.init()

    return {
        description = "Emerald shovel",
        depends = "mineral_emerald",
    }

end

function unilib.pkg.tool_shovel_emerald.exec()

    unilib.register_tool("unilib:tool_shovel_emerald", "gemtools:shovel_emerald", mode, {
        -- From gemtools:shovel_emerald
        description = S("Emerald Shovel"),
        inventory_image = "unilib_tool_shovel_emerald.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 1.0,
            groupcaps = {
                crumbly = {times = {[1] = 1.50, [2] = 0.90, [3] = 0.40}, uses = 35, maxlevel = 2},
            },
            max_drop_level = 1,
        },
        -- N.B. no transform in original code
        wield_image = "unilib_tool_shovel_emerald.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_shovel({
        -- From gemtools:shovel_emerald
        part_name = "emerald",
        ingredient = "unilib:mineral_emerald_gem",
    })
    unilib.apply_toolranks("unilib:tool_shovel_emerald", "shovel")

end
