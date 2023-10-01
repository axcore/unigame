---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_adamantite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_adamantite.init()

    return {
        description = "Adamantite pickaxe",
        depends = "metal_adamantite",
    }

end

function unilib.pkg.tool_pick_adamantite.exec()

    unilib.register_tool("unilib:tool_pick_adamantite", "xtraores:pick_adamantite", mode, {
        -- From xtraores:pick_adamantite
        description = S("Adamantite Pickaxe"),
        inventory_image = "unilib_tool_pick_adamantite.png",
        -- N.B. no groups in original code
        groups = {pickaxe = 1},
        -- N.B. no sounds in original code
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 18},
            full_punch_interval = 0.9,
            groupcaps = {
                cracky = {times = {[1] = 0.6, [2] = 0.35, [3] = 0.15}, uses = 200, maxlevel = 3},
                extrahard = {times = {[1] = 3, [2] = 2, [3] = 1}, uses = 200, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_pick({
        -- From xtraores:pick_adamantite
        part_name = "adamantite",
        ingredient = "unilib:metal_adamantite_ingot",
    })
    unilib.apply_toolranks("unilib:tool_pick_adamantite", "pickaxe")

end
