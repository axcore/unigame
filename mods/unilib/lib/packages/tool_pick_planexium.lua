---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_planexium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_planexium.init()

    return {
        description = "Planexium pickaxe",
        depends = "metal_planexium",
    }

end

function unilib.pkg.tool_pick_planexium.exec()

    unilib.register_tool("unilib:tool_pick_planexium", "xtraores:pick_platinum", mode, {
        -- From xtraores:pick_platinum
        description = S("Planexium Pickaxe"),
        inventory_image = "unilib_tool_pick_planexium.png",
        -- N.B. no groups in original code
        groups = {pickaxe = 1},
        -- N.B. no sounds in original code
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 0.9,
            groupcaps = {
                cracky = {times = {[1] = 2.4, [2] = 1.2, [3] = 0.6}, uses = 15, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From xtraores:pick_platinum
        part_name = "planexium",
        ingredient = "unilib:metal_planexium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_planexium", "pickaxe")

end
