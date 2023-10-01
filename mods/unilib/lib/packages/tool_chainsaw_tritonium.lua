---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_chainsaw_tritonium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_chainsaw_tritonium.init()

    return {
        description = "Tritonium chainsaw",
        depends = {"metal_steel", "metal_tritonium"},
    }

end

function unilib.pkg.tool_chainsaw_tritonium.exec()

    unilib.register_tool("unilib:tool_chainsaw_tritonium", "xtraores:axe_titanium", mode, {
        -- From xtraores:axe_titanium
        description = S("Tritonium Chainsaw"),
        inventory_image = "unilib_tool_chainsaw_tritonium.png",
        -- N.B. no groups in original code
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 15},
            full_punch_interval = 0.001,
            groupcaps = {
                choppy = {times = {[1] = 0.075, [2] = 0.02, [3] = 0.005}, uses = 650, maxlevel = 3},
                snappy = {
                    times = {[1] = 0.0125, [2] = 0.05, [3] = 0.006},
                    uses = 500,
                    maxlevel = 3,
                },
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_chainsaw({
        -- From xtraores:axe_titanium
        part_name = "tritonium",
        ingredient = "unilib:metal_tritonium_ingot",
        minor_ingredient = "unilib:metal_steel_ingot",
    })

end
