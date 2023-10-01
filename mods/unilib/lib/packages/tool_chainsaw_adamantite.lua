---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_chainsaw_adamantite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_chainsaw_adamantite.init()

    return {
        description = "Adamantite chainsaw",
        depends = {"metal_adamantite", "metal_steel"},
    }

end

function unilib.pkg.tool_chainsaw_adamantite.exec()

    unilib.register_tool("unilib:tool_chainsaw_adamantite", "xtraores:axe_adamantite", mode, {
        -- From xtraores:axe_adamantite
        description = S("Adamantite Chainsaw"),
        inventory_image = "unilib_tool_chainsaw_adamantite.png",
        -- N.B. no groups in original code
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 0.001,
            groupcaps = {
                choppy = {times = {[1] = 0.4, [2] = 0.1, [3] = 0.03}, uses = 200, maxlevel = 3},
                snappy = {times = {[1] = 0.5, [2] = 0.2, [3] = 0.05}, uses = 130, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_chainsaw({
        -- From xtraores:axe_adamantite
        part_name = "adamantite",
        ingredient = "unilib:metal_adamantite_ingot",
        minor_ingredient = "unilib:metal_steel_ingot",
    })

end
