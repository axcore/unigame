---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.egg_gecko_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.egg_gecko_normal.init()

    return {
        description = "Normal gecko egg",
    }

end

function unilib.pkg.egg_gecko_normal.exec()

    unimobs.petz_api.register_egg_node({
        -- From petz:gecko_egg. Creates unilib:egg_gecko_normal
        mob_type = "gecko_normal",
        orig_name = "petz:gecko_egg",
        drawtype = "nodebox",

        replace_mode = mode,
        baby_max = 3,
        baby_name = nil,
        description = S("Normal Gecko Egg"),
        mesh = nil,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.0625, -0.5, -0.0625, 0.0625, -0.375, 0.0625},
            },
        },
    })

end
