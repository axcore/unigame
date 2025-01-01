---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_square_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_square_green.init()

    return {
        description = "Green square stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_square_green.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_15_single, etc. Creates
        --      unilib:glass_stained_square_green_single, etc
        part_name = "square_green",
        description = S("Green Square Stained Glass"),

        replace_mode = mode,
        craft_list = {"red", "red", "green_dark"},
        orig_num = 15,
    })

end
