---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_palatinium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_palatinium.init()

    return {
        description = "Palatinium axe",
        depends = "metal_palatinium",
    }

end

function unilib.pkg.tool_axe_palatinium.exec()

    unilib.register_tool("unilib:tool_axe_palatinium", "xtraores:axe_platinum", mode, {
        -- From xtraores:axe_platinum
        description = S("Palatinium Axe"),
        inventory_image = "unilib_tool_axe_palatinium.png",
        -- N.B. no groups in original code
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 6},
            full_punch_interval = 0.9,
            groupcaps = {
                choppy = {times = {[1] = 2.2, [2] = 1, [3] = 0.6}, uses = 15, maxlevel = 3},
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 15, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_axe({
        -- From xtraores:axe_platinum
        part_name = "palatinium",
        ingredient = "unilib:metal_palatinium_ingot",
    })
    unilib.apply_toolranks("unilib:tool_axe_palatinium", "axe")

end
