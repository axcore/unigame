---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_unobtainium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_unobtainium.init()

    return {
        description = "Unobtainium sword",
        depends = "metal_unobtainium",
    }

end

function unilib.pkg.tool_sword_unobtainium.exec()

    unilib.register_tool("unilib:tool_sword_unobtainium", "xtraores:sword_unobtainium", mode, {
        -- From xtraores:sword_unobtainium
        description = S("Unobtainium Sword"),
        inventory_image = "unilib_tool_sword_unobtainium.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 35},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {
                    times = {[1] = 0.0125, [2] = 0.05, [3] = 0.006},
                    uses = 500,
                    maxlevel = 3,
                },
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From xtraores:sword_unobtainium
        part_name = "unobtainium",
        ingredient = "unilib:metal_unobtainium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_unobtainium", "sword")

end
