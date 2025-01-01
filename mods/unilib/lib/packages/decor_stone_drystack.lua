---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_drystack = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_drystack.init()

    return {
        description = "Drystack block",
        notes = "A block made from stacked stones, used in walls",
        at_least_one = {"gravel_ordinary", "mineral_flint"},
    }

end

function unilib.pkg.decor_stone_drystack.exec()

    local c_flint = "unilib:mineral_flint_lump"

    unilib.register_node("unilib:decor_stone_drystack", "earthbuild:drystack", mode, {
        -- From earthbuild:drystack
        description = S("Drystack Block"),
        tiles = {"unilib_decor_stone_drystack.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 1, stone = 2},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
    })
    unilib.register_stairs("unilib:decor_stone_drystack", {
        basic_flag = true,
    })
    unilib.register_wall({
        -- From earthbuild:drystack
        orig_name = "earthbuild:drystack_wall",
        ingredient = "unilib:decor_stone_drystack",

        replace_mode = mode,
        description = S("Drystack Wall"),
        sound_name = "stone",
        img_list = {"unilib_decor_stone_drystack.png"},
    })
    if unilib.global.pkg_executed_table["gravel_ordinary"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:drystack
            output = "unilib:decor_stone_drystack",
            recipe = {
                {"unilib:gravel_ordinary", "", "unilib:gravel_ordinary"},
            },
        })

    end
    if unilib.global.pkg_executed_table["mineral_flint"] ~= nil then

        -- N.B. Original craft recipe conflicts with recipe in "mineral_flint" package
        --[[
        unilib.register_craft_3x3({
            -- From earthbuild:drystack
            output = "unilib:decor_stone_drystack",
            ingredient = c_flint,
        })
        ]]--
        unilib.register_craft({
            -- From earthbuild:drystack
            output = "unilib:decor_stone_drystack",
            recipe = {
                {c_flint, c_flint, c_flint},
                {c_flint, "", c_flint},
                {c_flint, c_flint, c_flint},
            },
        })

    end

    -- Recycle the wall (since it's just a pile of stones)
    unilib.register_craft({
        -- From earthbuild:drystack
        output = "unilib:decor_stone_drystack",
        recipe = {
            {"unilib:decor_stone_drystack_wall"},
        },
    })

end
