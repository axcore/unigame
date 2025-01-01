---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_rhombus_green_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_rhombus_green_blue.init()

    return {
        description = "Green and blue rhombus stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_rhombus_green_blue.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_14_single, etc. Creates
        --      unilib:glass_stained_rhombus_green_blue_single, etc
        part_name = "rhombus_green_blue",
        description = S("Green and Blue Rhombus Stained Glass"),

        replace_mode = mode,
        craft_list = {"green_dark", "blue", "white"},
        orig_num = 14,
    })

end
