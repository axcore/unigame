---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_slate_red_extra = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slate_red_extra.init()

    return {
        description = "Creates black slime items, associated with slate",
        depends = {"shared_underch_slime", "stone_slate_red"},
    }

end

function unilib.pkg.stone_slate_red_extra.exec()

    unilib.pkg.shared_underch_slime.register_slime_eye({
        -- Creates unilib:stone_slimestone_black_eye (from underch:blackeye_item),
        --      unilib:stone_slimestone_black_eye_block (from underch:blackeye_block)
        --      unilib:stone_slimestone_black_with_eye (from underch:black_eye_ore)
        part_name = "black",
        eye_desc = "Black Slimestone Eye",
        block_desc = "Black Slimestone Eye Block",
        ore_desc = "Eye Ore in Black Slimestone",

        replace_mode = mode,
    })

    unilib.pkg.shared_underch_slime.register_block_slimy({
        -- From underch:black_slimy_block, creates unilib:stone_slimestone_black_block_slimy
        part_name = "black",
        block_desc = "Black Slimy Block",
        ingredient = "unilib:stone_slate_red",

        replace_mode = mode,
    })

    if unilib.underch_tweak_flag then

        unilib.pkg.shared_underch_slime.register_brick_slimy({
            -- Original to unilib (textures from underch), creates
            --      unilib:stone_slimestone_black_brick_slimy
            part_name = "black",
            brick_desc = "Black Slimy Bricks",
            ingredient = "unilib:stone_slimestone_black_block_slimy",

            replace_mode = mode,
        })

    end

    unilib.pkg.shared_underch_slime.register_liquid_slime({
        -- Creates unilib:liquid_slime_black_source (from underch:black_slime_source),
        --      unilib:liquid_slime_black_flowing (from underch:black_slime_flowing) and
        --      associated buckets (unilib:bucket_steel_with_slime_black, etc)
        part_name = "black",
        bucket_desc = "Black Slime",
        source_desc = "Black Slime Source",
        flowing_desc = "Flowing Black Slime",
        colour_table = {r = 0, g = 0, b = 0, a = 210},
        wherein = "unilib:stone_slate_red",

        replace_mode = mode,
    })

end
