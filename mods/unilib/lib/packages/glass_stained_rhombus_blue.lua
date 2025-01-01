---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_rhombus_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_rhombus_blue.init()

    return {
        description = "Blue rhombus stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_rhombus_blue.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_1_single, etc. Creates
        --      unilib:glass_stained_rhombus_blue_single, etc
        part_name = "rhombus_blue",
        description = S("Blue Rhombus Stained Glass"),

        replace_mode = mode,
        craft_list = {"blue", "blue", "blue"},
        orig_num = 1,
    })

end
