---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_mossy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_mossy.init()

    return {
        description = "Mossy gravel",
        depends = {"dirt_ordinary", "gravel_ordinary"},
        optional = "moss_green"
    }

end

function unilib.pkg.gravel_mossy.exec()

    unilib.register_node("unilib:gravel_mossy", "underch:mossy_gravel", mode, {
        -- From underch:mossy_gravel
        description = S("Mossy Gravel"),
        tiles = {"unilib_gravel_mossy.png"},
        -- N.B. gravel = 1 not in original code
        groups = {crumbly = 2, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,
    })
    if unilib.global.pkg_executed_table["moss_green"] ~= nil then

        unilib.tools.make_cuttable(
            "unilib:gravel_mossy", "unilib:gravel_ordinary", "unilib:moss_green"
        )

    end
    unilib.register_craft({
        -- From underch:mossy_gravel
        type = "shapeless",
        output = "unilib:gravel_mossy 2",
        recipe = {"group:leaves", "group:leaves", "unilib:dirt_ordinary", "unilib:gravel_ordinary"},
    })

    if unilib.setting.squeezed_gravel_flag then

        unilib.register_node("unilib:gravel_mossy_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Mossy Gravel"),
            tiles = {"unilib_gravel_mossy_compressed.png"},
            groups = {compressedgravel = 1, crumbly = 1},
            sounds = unilib.global.sound_table.gravel,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        -- Original to unilib
        unilib.misc.set_squeezed_recipes("unilib:gravel_mossy", "unilib:gravel_mossy_compressed")

    end

end
