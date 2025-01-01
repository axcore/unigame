---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_mosaic_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_mosaic_yellow.init()

    return {
        description = "Yellow mosaic stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_mosaic_yellow.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_9_single, etc. Creates
        --      unilib:glass_stained_mosaic_yellow_single, etc
        part_name = "mosaic_yellow",
        description = S("Yellow Mosaic Stained Glass"),

        replace_mode = mode,
        craft_list = {"blue", "red", "yellow"},
        orig_num = 9,
    })

end
