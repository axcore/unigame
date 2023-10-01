---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_rarium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_rarium.init()

    return {
        description = "Rarium sword",
        depends = "metal_rarium",
    }

end

function unilib.pkg.tool_sword_rarium.exec()

    unilib.register_tool("unilib:tool_sword_rarium", "xtraores:sword_rarium", mode, {
        -- From xtraores:sword_rarium
        description = S("Rarium Sword"),
        inventory_image = "unilib_tool_sword_rarium.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 30},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 0.25, [2] = 0.1, [3] = 0.025}, uses = 350, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_sword({
        -- From xtraores:sword_rarium
        part_name = "rarium",
        ingredient = "unilib:metal_rarium_ingot",
    })
    unilib.apply_toolranks("unilib:tool_sword_rarium", "sword")

end
