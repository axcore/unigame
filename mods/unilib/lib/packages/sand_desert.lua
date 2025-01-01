---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    farming
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_desert.init()

    return {
        description = "Desert sand",
        notes = "Desert sand can be irrigated with a hoe. To disable farming, use the" ..
                " \"sand_desert_nosoil\" package instead",
        excludes = "sand_desert_nosoil",
        depends = "soil_sand_desert",
    }

end

function unilib.pkg.sand_desert.exec()

    unilib.register_node("unilib:sand_desert", "default:desert_sand", mode, {
        -- From default:desert_sand
        description = S("Desert Sand"),
        tiles = {"unilib_sand_desert.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1, soil = 1},
        sounds = unilib.global.sound_table.sand,

        soil = {
            base = "unilib:sand_desert",
            dry = "unilib:soil_sand_desert",
            wet = "unilib:soil_desert_sand_wet",
        },
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_desert_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Desert Sand"),
            tiles = {"unilib_sand_desert_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:sand_desert", "unilib:sand_desert_compressed")

    end

end
