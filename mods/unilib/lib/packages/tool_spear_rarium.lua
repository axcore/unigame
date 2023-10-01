---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_spear_rarium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_spear_rarium.init()

    return {
        description = "Rarium sword",
        depends = "metal_rarium",
    }

end

function unilib.pkg.tool_spear_rarium.exec()

    unilib.register_tool("unilib:tool_spear_rarium", "xtraores:spear_rarium", mode, {
        -- From xtraores:spear_rarium
        description = S("Rarium Spear"),
        inventory_image = "unilib_tool_spear_rarium.png",
        -- N.B. no groups in original code
        groups = {spear = 1},
        sound = {breaks = "unilib_tool_breaks"},

        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 30},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 23, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_spear({
        -- From xtraores:spear_rarium
        part_name = "rarium",
        ingredient = "unilib:metal_rarium_ingot",
    })

end
