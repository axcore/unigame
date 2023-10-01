---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_adamantite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_adamantite.init()

    return {
        description = "Adamantite shovel",
        depends = "metal_adamantite",
    }

end

function unilib.pkg.tool_shovel_adamantite.exec()

    unilib.register_tool("unilib:tool_shovel_adamantite", "xtraores:shovel_adamantite", mode, {
        -- From xtraores:shovel_adamantite
        description = S("Adamantite Shovel"),
        inventory_image = "unilib_tool_shovel_adamantite.png",
        -- N.B. no groups in original code
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 17},
            full_punch_interval = 1,
            groupcaps = {
                crumbly = {times = {[1] = 0.3, [2] = 0.125, [3] = 0.075}, uses = 200, maxlevel = 3},
            },
            max_drop_level = 3,
        },
        wield_image = "unilib_tool_shovel_adamantite.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_shovel({
        -- From xtraores:shovel_adamantite
        part_name = "adamantite",
        ingredient = "unilib:metal_adamantite_ingot",
    })
    unilib.apply_toolranks("unilib:tool_shovel_adamantite", "shovel")

end
