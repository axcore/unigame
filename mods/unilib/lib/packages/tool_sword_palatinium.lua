---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_palatinium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_palatinium.init()

    return {
        description = "Palatinium sword",
        depends = "metal_palatinium",
    }

end

function unilib.pkg.tool_sword_palatinium.exec()

    unilib.register_tool("unilib:tool_sword_palatinium", "xtraores:sword_platinum", mode, {
        -- From xtraores:sword_platinum
        description = S("Palatinium Sword"),
        inventory_image = "unilib_tool_sword_palatinium.png",
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

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_sword({
        -- From xtraores:sword_platinum
        part_name = "palatinium",
        ingredient = "unilib:metal_palatinium_ingot",
    })
    unilib.apply_toolranks("unilib:tool_sword_palatinium", "sword")

end
