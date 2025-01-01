---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_slimestone_green_extra = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slimestone_green_extra.init()

    return {
        description = "Extra green slime items",
        depends = {"shared_underch_slime", "stone_slimestone_green"},
    }

end

function unilib.pkg.stone_slimestone_green_extra.exec()

    unilib.pkg.shared_underch_slime.register_slime_eye({
        -- Creates unilib:stone_slimestone_green_eye (from underch:greeneye_item),
        --      unilib:stone_slimestone_green_eye_block (from underch:greeneye_block)
        --      unilib:stone_slimestone_green_with_eye (from underch:green_eye_ore)
        part_name = "green",
        eye_desc = "Green Slimestone Eye",
        block_desc = "Green Slimestone Eye Block",
        ore_desc = "Eye Ore in Green Slimestone",

        replace_mode = mode,
    })

    unilib.pkg.shared_underch_slime.register_block_slimy({
        -- From underch:green_slimy_block, creates unilib:stone_slimestone_green_block_slimy
        part_name = "green",
        block_desc = "Green Slimy Block",
        ingredient = "unilib:stone_slimestone_green",

        replace_mode = mode,
    })

    if unilib.setting.underch_tweak_flag then

        unilib.pkg.shared_underch_slime.register_brick_slimy({
            -- Original to unilib (textures from underch), creates
            --      unilib:stone_slimestone_green_brick_slimy
            part_name = "green",
            brick_desc = "Green Slimy Bricks",
            ingredient = "unilib:stone_slimestone_green_block_slimy",

            replace_mode = mode,
        })

    end

    unilib.pkg.shared_underch_slime.register_liquid_slime({
        -- Creates unilib:liquid_slime_green_source (from underch:green_slime_source),
        --      unilib:liquid_slime_green_flowing (from underch:green_slime_flowing) and
        --      associated buckets (unilib:bucket_steel_with_slime_green, etc)
        part_name = "green",
        bucket_desc = "Green Slime",
        source_desc = "Green Slime Source",
        flowing_desc = "Flowing Green Slime",
        colour_table = {r = 20, g = 160, b = 0, a = 210},
        wherein = "unilib:stone_slimestone_green",

        replace_mode = mode,
    })

end
