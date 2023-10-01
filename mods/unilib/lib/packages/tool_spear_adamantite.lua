---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_spear_adamantite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_spear_adamantite.init()

    return {
        description = "Adamantite sword",
        depends = "metal_adamantite",
    }

end

function unilib.pkg.tool_spear_adamantite.exec()

    unilib.register_tool("unilib:tool_spear_adamantite", "xtraores:spear_adamantite", mode, {
        -- From xtraores:spear_adamantite
        description = S("Adamantite Spear"),
        inventory_image = "unilib_tool_spear_adamantite.png",
        -- N.B. no groups in original code
        groups = {spear = 1},
        sound = {breaks = "unilib_tool_breaks"},

        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 20},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 23, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_spear({
        -- From xtraores:spear_adamantite
        part_name = "adamantite",
        ingredient = "unilib:metal_adamantite_ingot",
    })

end
