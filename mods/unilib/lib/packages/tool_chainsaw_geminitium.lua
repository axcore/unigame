---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_chainsaw_geminitium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_chainsaw_geminitium.init()

    return {
        description = "Geminitium chainsaw",
        depends = "metal_geminitium",
    }

end

function unilib.pkg.tool_chainsaw_geminitium.exec()

    unilib.register_tool("unilib:tool_chainsaw_geminitium", "xtraores:axe_geminitinum", mode, {
        -- From xtraores:axe_geminitinum
        description = S("Geminitium Chainsaw"),
        inventory_image = "unilib_tool_chainsaw_geminitium.png",
        -- N.B. no groups in original code
        groups = {axe = 1, chainsaw = 1},
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
        part_name = "geminitium",
        ingredient = "unilib:metal_geminitium_ingot",
        minor_ingredient = "unilib:metal_steel_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_chainsaw_geminitium", "chainsaw")

end
