---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_spear_palatinium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_spear_palatinium.init()

    return {
        description = "Palatinium sword",
        depends = "metal_palatinium",
    }

end

function unilib.pkg.tool_spear_palatinium.exec()

    unilib.register_tool("unilib:tool_spear_palatinium", "xtraores:spear_platinum", mode, {
        -- From xtraores:spear_platinum
        description = S("Palatinium Spear"),
        inventory_image = "unilib_tool_spear_palatinium.png",
        -- N.B. no groups in original code
        groups = {spear = 1},
        sound = {breaks = "unilib_tool_breaks"},

        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 7},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 23, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_spear({
        -- From xtraores:spear_platinum
        part_name = "palatinium",
        ingredient = "unilib:metal_palatinium_ingot",
    })

end
