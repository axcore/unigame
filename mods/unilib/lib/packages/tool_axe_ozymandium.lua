---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_ozymandium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_ozymandium.init()

    return {
        description = "Ozymandium axe",
        depends = "metal_ozymandium",
    }

end

function unilib.pkg.tool_axe_ozymandium.exec()

    unilib.register_tool("unilib:tool_axe_ozymandium", "xtraores:axe_osmium", mode, {
        -- From xtraores:axe_osmium
        description = S("Ozymandium Axe"),
        inventory_image = "unilib_tool_axe_ozymandium.png",
        -- N.B. no groups in original code
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 14},
            full_punch_interval = 0.9,
            groupcaps = {
                choppy = {times = {[1] = 1.2, [2] = 0.4, [3] = 0.15}, uses = 100, maxlevel = 3},
                snappy = {times = {[1] = 1, [2] = 0.4, [3] = 0.1}, uses = 75, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_axe({
        -- From xtraores:axe_osmium
        part_name = "ozymandium",
        ingredient = "unilib:metal_ozymandium_ingot",
    })
    unilib.apply_toolranks("unilib:tool_axe_ozymandium", "axe")

end
