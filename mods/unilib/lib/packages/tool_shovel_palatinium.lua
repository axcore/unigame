---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_palatinium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_palatinium.init()

    return {
        description = "Palatinium shovel",
        depends = "metal_palatinium",
    }

end

function unilib.pkg.tool_shovel_palatinium.exec()

    unilib.register_tool("unilib:tool_shovel_palatinium", "xtraores:shovel_platinum", mode, {
        -- From xtraores:shovel_platinum
        description = S("Palatinium Shovel"),
        inventory_image = "unilib_tool_shovel_palatinium.png",
        -- N.B. no groups in original code
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1,
            groupcaps = {
                crumbly = {times = {[1] = 1.2, [2] = 0.6, [3] = 0.3}, uses = 15, maxlevel = 3},
            },
            max_drop_level = 3,
        },
        wield_image = "unilib_tool_shovel_palatinium.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_shovel({
        -- From xtraores:shovel_platinum
        part_name = "palatinium",
        ingredient = "unilib:metal_palatinium_ingot",
    })
    unilib.apply_toolranks("unilib:tool_shovel_palatinium", "shovel")

end
