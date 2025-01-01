---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_pale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_pale.init()

    return {
        description = "Pale sand",
    }

end

function unilib.pkg.sand_pale.exec()

    -- N.B. orig_name omitted to prevent Minetest alias warning
    unilib.register_node("unilib:sand_pale", nil, mode, {
        -- From decoblocks, default:sand
        description = S("Pale Sand"),
        tiles = {"unilib_sand_pale.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_pale_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Pale Sand"),
            tiles = {"unilib_sand_pale_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:sand_pale", "unilib:sand_pale_compressed")

    end

end
