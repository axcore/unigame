---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_slimestone_purple_extra = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slimestone_purple_extra.init()

    return {
        description = "Extra purple slime items",
        depends = {"shared_underch_slime", "stone_slimestone_purple"},
    }

end

function unilib.pkg.stone_slimestone_purple_extra.exec()

    unilib.pkg.shared_underch_slime.register_slime_eye({
        -- Creates unilib:stone_slimestone_purple_eye (from underch:purpleeye_item),
        --      unilib:stone_slimestone_purple_eye_block (from underch:purpleeye_block)
        --      unilib:stone_slimestone_purple_with_eye (from underch:purple_eye_ore)
        part_name = "purple",
        eye_desc = "Purple Slimestone Eye",
        block_desc = "Purple Slimestone Eye Block",
        ore_desc = "Eye Ore in Purple Slimestone",

        replace_mode = mode,
    })

    unilib.pkg.shared_underch_slime.register_block_slimy({
        -- From underch:purple_slimy_block, creates unilib:stone_slimestone_purple_block_slimy
        part_name = "purple",
        block_desc = "Purple Slimy Block",
        ingredient = "unilib:stone_slimestone_purple",

        replace_mode = mode,
    })

    if unilib.underch_tweak_flag then

        unilib.pkg.shared_underch_slime.register_brick_slimy({
            -- Original to unilib (textures from underch), creates
            --      unilib:stone_slimestone_purple_brick_slimy
            part_name = "purple",
            brick_desc = "Purple Slimy Bricks",
            ingredient = "unilib:stone_slimestone_purple_block_slimy",

            replace_mode = mode,
        })

    end

    unilib.pkg.shared_underch_slime.register_liquid_slime({
        -- Creates unilib:liquid_slime_purple_source (from underch:purple_slime_source),
        --      unilib:liquid_slime_purple_flowing (from underch:purple_slime_flowing) and
        --      associated buckets (unilib:bucket_steel_with_slime_purple, etc)
        part_name = "purple",
        bucket_desc = "Purple Slime",
        source_desc = "Purple Slime Source",
        flowing_desc = "Flowing Purple Slime",
        colour_table = {r = 160, g = 0, b = 200, a = 210},
        wherein = "unilib:stone_slimestone_purple",

        replace_mode = mode,
    })

end
