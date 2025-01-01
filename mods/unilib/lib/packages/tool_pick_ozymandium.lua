---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_ozymandium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_ozymandium.init()

    return {
        description = "Ozymandium pickaxe",
        depends = "metal_ozymandium",
    }

end

function unilib.pkg.tool_pick_ozymandium.exec()

    unilib.register_tool("unilib:tool_pick_ozymandium", "xtraores:pick_osmium", mode, {
        -- From xtraores:pick_osmium
        description = S("Ozymandium Pickaxe"),
        inventory_image = "unilib_tool_pick_ozymandium.png",
        -- N.B. no groups in original code
        groups = {pickaxe = 1},
        -- N.B. no sounds in original code
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 13},
            full_punch_interval = 0.9,
            groupcaps = {
                cracky = {times = {[1] = 1.2, [2] = 0.7, [3] = 0.3}, uses = 100, maxlevel = 3},
                extrahard = {times = {[2] = 3, [3] = 2}, uses = 100, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From xtraores:pick_osmium
        part_name = "ozymandium",
        ingredient = "unilib:metal_ozymandium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_ozymandium", "pickaxe")

end
