---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_ozymandium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_ozymandium.init()

    return {
        description = "Ozymandium sword",
        depends = "metal_ozymandium",
    }

end

function unilib.pkg.tool_sword_ozymandium.exec()

    unilib.register_tool("unilib:tool_sword_ozymandium", "xtraores:sword_osmium", mode, {
        -- From xtraores:sword_osmium
        description = S("Ozymandium Sword"),
        inventory_image = "unilib_tool_sword_ozymandium.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 15},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 1, [2] = 0.4, [3] = 0.1}, uses = 100, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_sword({
        -- From xtraores:sword_osmium
        part_name = "ozymandium",
        ingredient = "unilib:metal_ozymandium_ingot",
    })
    unilib.apply_toolranks("unilib:tool_sword_ozymandium", "sword")

end
