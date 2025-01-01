---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_sandstone_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_sandstone_silver.init()

    return {
        description = "Silver sandstone gravel",
    }

end

function unilib.pkg.gravel_sandstone_silver.exec()

    unilib.register_node("unilib:gravel_sandstone_silver", nil, mode, {
        -- Original to unilib
        description = S("Silver Sandstone Gravel"),
        tiles = {"unilib_gravel_sandstone_silver.png"},
        groups = {crumbly = 2, falling_node = 1, gravel = 1},
        sounds = unilib.global.sound_table.gravel,
    })

    if unilib.setting.squeezed_gravel_flag then

        unilib.register_node("unilib:gravel_sandstone_silver_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Silver Sandstone Gravel"),
            tiles = {"unilib_gravel_sandstone_silver_compressed.png"},
            groups = {compressedgravel = 1, crumbly = 1},
            sounds = unilib.global.sound_table.gravel,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:gravel_sandstone_silver", "unilib:gravel_sandstone_silver_compressed"
        )

    end

end
