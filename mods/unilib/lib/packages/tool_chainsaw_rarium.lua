---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_chainsaw_rarium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_chainsaw_rarium.init()

    return {
        description = "Rarium chainsaw",
        depends = {"metal_rarium", "metal_steel"},
    }

end

function unilib.pkg.tool_chainsaw_rarium.exec()

    unilib.register_tool("unilib:tool_chainsaw_rarium", "xtraores:axe_rarium", mode, {
        -- From xtraores:axe_rarium
        description = S("Rarium Chainsaw"),
        inventory_image = "unilib_tool_chainsaw_rarium.png",
        -- N.B. no groups in original code
        groups = {axe = 1, chainsaw = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 8},
            full_punch_interval = 0.001,
            groupcaps = {
                choppy = {times = {[1] = 0.2, [2] = 0.05, [3] = 0.015}, uses = 350, maxlevel = 3},
                snappy = {times = {[1] = 0.25, [2] = 1, [3] = 0.025}, uses = 260, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_chainsaw({
        -- From xtraores:axe_rarium
        part_name = "rarium",
        ingredient = "unilib:metal_rarium_ingot",
        minor_ingredient = "unilib:metal_steel_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_chainsaw_rarium", "chainsaw")

end
