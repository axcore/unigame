---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_quartz = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_quartz.init()

    return {
        description = "High-purity quartz sand",
    }

end

function unilib.pkg.sand_quartz.exec()

    unilib.register_node("unilib:sand_quartz", nil, mode, {
        -- Texture from PFAA, weakOreSand_quartzSand.png. Original code
        description = S("High-Purity Quartz Sand"),
        tiles = {"unilib_sand_quartz.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })

    if unilib.setting.squeezed_sand_flag then

        unilib.register_node("unilib:sand_quartz_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed High-Purity Quartz Sand"),
            tiles = {"unilib_sand_quartz_compressed.png"},
            groups = {compressedsand = 1, crumbly = 2},
            sounds = unilib.global.sound_table.sand,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:sand_quartz", "unilib:sand_quartz_compressed")

    end

end
