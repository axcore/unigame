---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_glassy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_glassy.init()

    return {
        description = "Glassy sand",
    }

end

function unilib.pkg.sand_glassy.exec()

    unilib.register_node("unilib:sand_glassy", nil, mode, {
        -- Original to unilib
        description = S("Glassy Sand"),
        tiles = {"unilib_sand_glassy.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_glassy_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Glassy Sand"),
            tiles = {"unilib_sand_glassy_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:sand_glassy", "unilib:sand_glassy_compressed")

    end

end
