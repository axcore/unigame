---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_mosaic_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_mosaic_red.init()

    return {
        description = "Red mosaic stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_mosaic_red.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_17_single, etc. Creates
        --      unilib:glass_stained_mosaic_red_single, etc
        part_name = "mosaic_red",
        description = S("Red Mosaic Stained Glass"),

        replace_mode = mode,
        craft_list = {"red", "green_dark", "yellow"},
        orig_num = 17,
    })

end
