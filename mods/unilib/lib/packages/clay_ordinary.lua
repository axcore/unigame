---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_ordinary.init()

    return {
        description = "Ordinary clay",
    }

end

function unilib.pkg.clay_ordinary.exec()

    unilib.register_node("unilib:clay_ordinary", "default:clay", mode, {
        -- From default:clay
        description = S("Ordinary Clay"),
        tiles = {"unilib_clay_ordinary.png"},
        -- N.B. clay = 1 not in original code
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,

        drop = "unilib:clay_ordinary_lump 4",
    })
    unilib.register_craft_2x2({
        -- From default:clay
        output = "unilib:clay_ordinary",
        ingredient = "unilib:clay_ordinary_lump",
    })
    unilib.register_carvings("unilib:clay_ordinary", {
        facade_flag = true,
        millwork_flag = true,
    })

    unilib.register_craftitem("unilib:clay_ordinary_lump", "default:clay_lump", mode, {
        -- From default:clay_lump
        description = S("Ordinary Clay Lump"),
        inventory_image = "unilib_clay_ordinary_lump.png",
    })
    unilib.register_craft({
        -- From default:clay_lump
        output = "unilib:clay_ordinary_lump 4",
        recipe = {
            {"unilib:clay_ordinary"},
        },
    })

end
