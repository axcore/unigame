---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_spear_ozymandium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_spear_ozymandium.init()

    return {
        description = "Ozymandium sword",
        depends = "metal_ozymandium",
    }

end

function unilib.pkg.tool_spear_ozymandium.exec()

    unilib.register_tool("unilib:tool_spear_ozymandium", "xtraores:spear_osmium", mode, {
        -- From xtraores:spear_osmium
        description = S("Ozymandium Spear"),
        inventory_image = "unilib_tool_spear_ozymandium.png",
        -- N.B. no groups in original code
        groups = {spear = 1},
        sound = {breaks = "unilib_tool_breaks"},

        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 15},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 23, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_spear({
        -- From xtraores:spear_osmium
        part_name = "ozymandium",
        ingredient = "unilib:metal_ozymandium_ingot",
    })

end
