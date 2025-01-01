---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_excalibur = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_excalibur.init()

    return {
        description = "Excalibur sword",
        depends = {
            "mineral_diamond",
            "mineral_mese",
            "tool_sword_adamantite",
            "tool_sword_diamond",
            "tool_sword_ozymandium",
            "tool_sword_rarium",
            "tool_sword_sybilline",
            "tool_sword_unobtainium",
        },
    }

end

function unilib.pkg.tool_sword_excalibur.exec()

    unilib.register_tool("unilib:tool_sword_excalibur", "xtraores:sword_excalibur", mode, {
        -- From xtraores:sword_excalibur
        description = S("Excalibur"),
        inventory_image = "unilib_tool_sword_excalibur.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 75},
            full_punch_interval = 0.1,
            groupcaps = {
                snappy = {
                    times = {[1] = 0.0125, [2] = 0.05, [3] = 0.006},
                    uses = 500,
                    maxlevel = 3,
                },
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft({
        -- From xtraores:sword_excalibur
        output = "unilib:tool_sword_excalibur",
        recipe = {
            {
                "unilib:tool_sword_ozymandium",
                "unilib:tool_sword_adamantite",
                "unilib:tool_sword_rarium",
            },
            {
                "unilib:tool_sword_sybilline",
                "unilib:tool_sword_diamond",
                "unilib:tool_sword_unobtainium",
            },
            {
                "unilib:mineral_diamond_block",
                "unilib:mineral_mese_block",
                "unilib:mineral_diamond_block",
            },
        },
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_excalibur", "sword")

end
