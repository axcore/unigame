---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_sandstone_golden = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_sandstone_golden.init()

    return {
        description = "Golden sandstone gravel",
    }

end

function unilib.pkg.gravel_sandstone_golden.exec()

    unilib.register_node("unilib:gravel_sandstone_golden", nil, mode, {
        -- Texture adapted from darkage, darkage_cob.png. Original code, matching the code in the
        --      "gravel_sandstone_desert" package
        description = S("Golden Sandstone Gravel"),
        tiles = {"unilib_gravel_sandstone_golden.png"},
        groups = {crumbly = 2, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,
    })

    if unilib.setting.squeezed_gravel_flag then

        unilib.register_node("unilib:gravel_sandstone_golden_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Golden Sandstone Gravel"),
            tiles = {"unilib_gravel_sandstone_golden_compressed.png"},
            groups = {compressedgravel = 1, crumbly = 1},
            sounds = unilib.global.sound_table.gravel,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:gravel_sandstone_golden", "unilib:gravel_sandstone_golden_compressed"
        )

    end

end
