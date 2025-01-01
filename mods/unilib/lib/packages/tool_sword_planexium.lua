---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_planexium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_planexium.init()

    return {
        description = "Planexium sword",
        depends = "metal_planexium",
    }

end

function unilib.pkg.tool_sword_planexium.exec()

    unilib.register_tool("unilib:tool_sword_planexium", "xtraores:sword_platinum", mode, {
        -- From xtraores:sword_platinum
        description = S("Planexium Sword"),
        inventory_image = "unilib_tool_sword_planexium.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 7},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 23, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From xtraores:sword_platinum
        part_name = "planexium",
        ingredient = "unilib:metal_planexium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_planexium", "sword")

end
