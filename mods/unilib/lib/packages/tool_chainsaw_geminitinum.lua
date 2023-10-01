---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_chainsaw_geminitinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_chainsaw_geminitinum.init()

    return {
        description = "Geminitinum chainsaw",
        depends = "metal_geminitinum",
    }

end

function unilib.pkg.tool_chainsaw_geminitinum.exec()

    unilib.register_tool("unilib:tool_chainsaw_geminitinum", "xtraores:axe_geminitinum", mode, {
        -- From xtraores:axe_geminitinum
        description = S("Geminitinum Chainsaw"),
        inventory_image = "unilib_tool_chainsaw_geminitinum.png",
        -- N.B. no groups in original code
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 20},
            full_punch_interval = 0.001,
            groupcaps = {
                choppy = {
                    times = {[1] = 0.001, [2] = 0.001, [3] = 0.001},
                    uses = 1000,
                    maxlevel = 3,
                },
                snappy = {times = {[1] = 0.01, [2] = 0.03, [3] = 0.002}, uses = 750, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_chainsaw({
        -- From xtraores:axe_geminitinum
        part_name = "geminitinum",
        ingredient = "unilib:metal_geminitinum_ingot",
        minor_ingredient = "unilib:metal_steel_ingot",
    })

end
