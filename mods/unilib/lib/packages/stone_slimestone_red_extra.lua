---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_slimestone_red_extra = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slimestone_red_extra.init()

    return {
        description = "Extra red slime items",
        depends = {"shared_underch_slime", "stone_slimestone_red"},
    }

end

function unilib.pkg.stone_slimestone_red_extra.exec()

    unilib.pkg.shared_underch_slime.register_slime_eye({
        -- Creates unilib:stone_slimestone_red_eye (from underch:redeye_item),
        --      unilib:stone_slimestone_red_eye_block (from underch:redeye_block)
        --      unilib:stone_slimestone_red_with_eye (from underch:red_eye_ore)
        part_name = "red",
        eye_desc = "Red Slimestone Eye",
        block_desc = "Red Slimestone Eye Block",
        ore_desc = "Eye Ore in Red Slimestone",

        replace_mode = mode,
    })

    unilib.pkg.shared_underch_slime.register_block_slimy({
        -- From underch:red_slimy_block, creates unilib:stone_slimestone_red_block_slimy
        part_name = "red",
        block_desc = "Red Slimy Block",
        ingredient = "unilib:stone_slimestone_red",

        replace_mode = mode,
    })

    if unilib.underch_tweak_flag then

        unilib.pkg.shared_underch_slime.register_brick_slimy({
            -- Original to unilib (textures from underch), creates
            --      unilib:stone_slimestone_red_brick_slimy
            part_name = "red",
            brick_desc = "Red Slimy Bricks",
            ingredient = "unilib:stone_slimestone_red_block_slimy",

            replace_mode = mode,
        })

    end

    unilib.pkg.shared_underch_slime.register_liquid_slime({
        -- Creates unilib:liquid_slime_red_source (from underch:red_slime_source),
        --      unilib:liquid_slime_red_flowing (from underch:red_slime_flowing) and
        --      associated buckets (unilib:bucket_steel_with_slime_red, etc)
        part_name = "red",
        bucket_desc = "Red Slime",
        source_desc = "Red Slime Source",
        flowing_desc = "Flowing Red Slime",
        colour_table = {r = 160, g = 0, b = 30, a = 210},
        wherein = "unilib:stone_slimestone_red",

        replace_mode = mode,
    })

end
