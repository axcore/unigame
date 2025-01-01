---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.bucket_clay = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bucket_clay.init()

    return {
        description = "Clay pot (as a bucket)",
        depends = "clay_ordinary",
    }

end

function unilib.pkg.bucket_clay.exec()

    unilib.register_bucket({
        -- From earthbuild:clay_pot (etc), creates unilib:bucket_clay_empty (etc)
        orig_name = {
            "earthbuild:clay_pot",
            "earthbuild:clay_pot_water",
            "earthbuild:clay_pot_river_water",
            "earthbuild:clay_pot_lava",
        },
        bucket_type = "bucket_clay",

        replace_mode = mode,
        burntime = 0,
        description = S("Clay Pot"),
        group_table = {tool = 1},
        ingredient = nil,
    })
    unilib.register_craft({
        -- From earthbuild:clay_pot
        type = "cooking",
        output = "unilib:bucket_clay_empty",
        recipe = "unilib:bucket_clay_unfired",
        cooktime = 3,
    })

    unilib.register_craftitem("unilib:bucket_clay_unfired", "earthbuild:unfired_clay_pot", mode, {
        -- From earthbuild:unfired_clay_pot
        description = S("Unfired Clay Pot"),
        inventory_image = "unilib_bucket_pot_unfired.png",
    })
    unilib.register_craft({
        -- From earthbuild:unfired_clay_pot
        output = "unilib:bucket_clay_unfired",
        recipe = {
            {"unilib:clay_ordinary_lump", "", "unilib:clay_ordinary_lump"},
            {"", "unilib:clay_ordinary_lump", ""},
        },
    })
    unilib.register_craft({
        -- From earthbuild:unfired_clay_pot
        output = "unilib:clay_ordinary_lump 3",
        recipe = {
            {"unilib:bucket_clay_unfired"},
        },
    })

end
