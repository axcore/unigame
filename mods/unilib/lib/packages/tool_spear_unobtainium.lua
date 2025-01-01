---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_spear_unobtainium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_spear_unobtainium.init()

    return {
        description = "Unobtainium sword",
        depends = "metal_unobtainium",
    }

end

function unilib.pkg.tool_spear_unobtainium.exec()

    unilib.register_tool("unilib:tool_spear_unobtainium", "xtraores:spear_unobtainium", mode, {
        -- From xtraores:spear_unobtainium
        description = S("Unobtainium Spear"),
        inventory_image = "unilib_tool_spear_unobtainium.png",
        -- N.B. no groups in original code
        groups = {spear = 1},
        sound = {breaks = "unilib_tool_breaks"},

        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 35},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 23, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_spear({
        -- From xtraores:spear_unobtainium
        part_name = "unobtainium",
        ingredient = "unilib:metal_unobtainium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_spear_unobtainium", "spear")

end
