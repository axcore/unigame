---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_normal_thick = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_normal_thick.init()

    return {
        description = "Thick normal moss",
    }

end

function unilib.pkg.moss_normal_thick.exec()

    unilib.register_node("unilib:moss_normal_thick", "mapgen:moss", mode, {
        -- From farlands, mapgen:moss
        description = S("Thick Normal Moss"),
        tiles = {"unilib_moss_normal_thick.png"},
        -- N.B. moss = 1 not in original code
        groups = {dig_immediate = 3, moss = 1, oddly_breakable_by_hand = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
            },
        },
        paramtype = "light",
    })

    unilib.register_decoration_generic("farlands_moss_normal_thick", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:moss_normal_thick",

        fill_ratio = 0.05,
        height = 1,
        sidelen = 16,
    })

end
