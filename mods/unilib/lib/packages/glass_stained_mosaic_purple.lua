---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_mosaic_purple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_mosaic_purple.init()

    return {
        description = "Purple mosaic stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_mosaic_purple.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_18_single, etc. Creates
        --      unilib:glass_stained_mosaic_purple_single, etc
        part_name = "mosaic_purple",
        description = S("Purple Mosaic Stained Glass"),

        replace_mode = mode,
        craft_list = {"violet", "yellow", "green_dark"},
        orig_num = 18,
    })

end
