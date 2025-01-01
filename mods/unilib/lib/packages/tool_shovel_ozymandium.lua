---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_ozymandium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_ozymandium.init()

    return {
        description = "Ozymandium shovel",
        depends = "metal_ozymandium",
    }

end

function unilib.pkg.tool_shovel_ozymandium.exec()

    unilib.register_tool("unilib:tool_shovel_ozymandium", "xtraores:shovel_osmium", mode, {
        -- From xtraores:shovel_osmium
        description = S("Ozymandium Shovel"),
        inventory_image = "unilib_tool_shovel_ozymandium.png",
        -- N.B. no groups in original code
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 12},
            full_punch_interval = 1,
            groupcaps = {
                crumbly = {times = {[1] = 0.6, [2] = 0.25, [3] = 0.15}, uses = 100, maxlevel = 3},
            },
            max_drop_level = 3,
        },
        wield_image = "unilib_tool_shovel_ozymandium.png^[transformR90",

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_shovel({
        -- From xtraores:shovel_osmium
        part_name = "ozymandium",
        ingredient = "unilib:metal_ozymandium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_shovel_ozymandium", "shovel")

end
