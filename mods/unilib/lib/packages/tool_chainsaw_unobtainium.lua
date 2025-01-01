---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_chainsaw_unobtainium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_chainsaw_unobtainium.init()

    return {
        description = "Unobtainium chainsaw",
        depends = {"metal_steel", "metal_unobtainium"},
    }

end

function unilib.pkg.tool_chainsaw_unobtainium.exec()

    unilib.register_tool("unilib:tool_chainsaw_unobtainium", "xtraores:axe_unobtainium", mode, {
        -- From xtraores:axe_unobtainium
        description = S("Unobtainium Chainsaw"),
        inventory_image = "unilib_tool_chainsaw_unobtainium.png",
        -- N.B. no groups in original code
        groups = {axe = 1, chainsaw = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 12},
            full_punch_interval = 0.001,
            groupcaps = {
                choppy = {times = {[1] = 0.1, [2] = 0.025, [3] = 0.0075}, uses = 500, maxlevel = 3},
                snappy = {
                    times = {[1] = 0.0125, [2] = 0.05, [3] = 0.006},
                    uses = 320,
                    maxlevel = 3,
                },
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_chainsaw({
        -- From xtraores:axe_unobtainium
        part_name = "unobtainium",
        ingredient = "unilib:metal_unobtainium_ingot",
        minor_ingredient = "unilib:metal_steel_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_chainsaw_unobtainium", "chainsaw")

end
