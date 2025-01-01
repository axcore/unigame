---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_red_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_red_antipodean.init()

    return {
        description = "Antipodean red gravel",
    }

end

function unilib.pkg.gravel_red_antipodean.exec()

    unilib.register_node("unilib:gravel_red_antipodean", "australia:red_gravel", mode, {
        -- From australia:red_gravel
        description = S("Antipodean Red Gravel"),
        tiles = {"unilib_gravel_red_antipodean.png"},
        -- N.B. gravel = 1 not in original code
        groups = {crumbly = 2, falling_node = 1, gravel = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = {name = "unilib_gravel_footstep", gain = 0.5},
            dug = {name = "unilib_gravel_footstep", gain = 1.0},
        }),
    })

    if unilib.setting.squeezed_gravel_flag then

        unilib.register_node("unilib:gravel_red_antipodean_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Antipodean Red Gravel"),
            tiles = {"unilib_gravel_red_antipodean_compressed.png"},
            groups = {compressedgravel = 1, crumbly = 1},
            sounds = unilib.global.sound_table.gravel,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_squeezed_recipes(
            -- Original to unilib
            "unilib:gravel_red_antipodean", "unilib:gravel_red_antipodean_compressed"
        )

    end

end
