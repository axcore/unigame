---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_square_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_square_blue.init()

    return {
        description = "Blue square stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_square_blue.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_16_single, etc. Creates
        --      unilib:glass_stained_square_blue_single, etc
        part_name = "square_blue",
        description = S("Blue Square Stained Glass"),

        replace_mode = mode,
        craft_list = {"blue", "blue", "cyan"},
        orig_num = 16,
    })

end
