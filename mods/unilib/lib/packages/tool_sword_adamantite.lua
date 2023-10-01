---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_adamantite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_adamantite.init()

    return {
        description = "Adamantite sword",
        depends = "metal_adamantite",
    }

end

function unilib.pkg.tool_sword_adamantite.exec()

    unilib.register_tool("unilib:tool_sword_adamantite", "xtraores:sword_adamantite", mode, {
        -- From xtraores:sword_adamantite
        description = S("Adamantite Sword"),
        inventory_image = "unilib_tool_sword_adamantite.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 20},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 0.5, [2] = 0.2, [3] = 0.05}, uses = 200, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_sword({
        -- From xtraores:sword_adamantite
        part_name = "adamantite",
        ingredient = "unilib:metal_adamantite_ingot",
    })
    unilib.apply_toolranks("unilib:tool_sword_adamantite", "sword")

end
