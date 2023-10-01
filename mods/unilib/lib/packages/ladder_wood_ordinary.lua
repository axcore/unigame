---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_wood_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_wood_ordinary.init()

    return {
        description = "Ordinary wooden ladder",
        optional = "tree_apple",
    }

end

function unilib.pkg.ladder_wood_ordinary.exec()

    if not unilib.mtgame_tweak_flag or unilib.pkg_executed_table["tree_apple"] == nil then

        unilib.register_ladder({
            -- From default:ladder_wood. Creates unilib:ladder_wood_ordinary
            part_name = "wood_ordinary",
            orig_name = "default:ladder_wood",
            ingredient = "group:stick",

            replace_mode = mode,
            description = S("Ordinary Wooden Ladder"),
            group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 3},
            multiple = 5,
            sound_name = "wood",
        })
        unilib.register_craft({
            -- From default:ladder_wood
            type = "fuel",
            recipe = "unilib:ladder_wood_ordinary",
            burntime = 7,
        })

    else

        -- Apply tweak from the mtg_plus mod, in which wood ladders have two ingredients
        -- The original craft recipe, using only sticks, is not retained (unlike in mtg_plus)
        unilib.register_ladder({
            -- From default:ladder_wood. Creates unilib:ladder_wood_apple
            part_name = "wood_apple",
            orig_name = "default:ladder_wood",
            ingredient = "group:stick",

            replace_mode = mode,
            centre_ingredient = "unilib:tree_apple_wood",
            description = S("Apple Tree Wood Ladder"),
            group_table = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 3},
            multiple = 9,
            sound_name = "wood",
        })
        unilib.register_craft({
            -- From default:ladder_wood
            type = "fuel",
            recipe = "unilib:ladder_wood_apple",
            burntime = 7,
        })

        minetest.register_alias("unilib:ladder_wood_ordinary", "unilib:ladder_wood_apple")

    end

end
