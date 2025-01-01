---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_feldspar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_feldspar.init()

    return {
        description = "Feldspar sand",
    }

end

function unilib.pkg.sand_feldspar.exec()

    unilib.register_node("unilib:sand_feldspar", nil, mode, {
        -- Original to unilib
        description = S("Feldspar Sand"),
        tiles = {"unilib_sand_feldspar.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_feldspar_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Feldspar Sand"),
            tiles = {"unilib_sand_feldspar_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:sand_feldspar", "unilib:sand_feldspar_compressed")

    end

end
