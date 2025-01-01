---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_tritonium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_tritonium.init()

    return {
        description = "Tritonium sword",
        depends = "metal_tritonium",
    }

end

function unilib.pkg.tool_sword_tritonium.exec()

    unilib.register_tool("unilib:tool_sword_tritonium", "xtraores:sword_titanium", mode, {
        -- From xtraores:sword_titanium
        description = S("Tritonium Sword"),
        inventory_image = "unilib_tool_sword_tritonium.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 40},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {
                    times = {[1] = 0.0125, [2] = 0.05, [3] = 0.006},
                    uses = 650,
                    maxlevel = 3,
                },
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From xtraores:sword_titanium
        part_name = "tritonium",
        ingredient = "unilib:metal_tritonium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_tritonium", "sword")

end
