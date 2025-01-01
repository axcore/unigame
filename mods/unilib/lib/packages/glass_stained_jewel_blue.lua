---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_jewel_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_jewel_blue.init()

    return {
        description = "Blue jewel stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_jewel_blue.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_3_single, etc. Creates
        --      unilib:glass_stained_jewel_blue_single, etc
        part_name = "jewel_blue",
        description = S("Blue Jewel Stained Glass"),

        replace_mode = mode,
        craft_list = {"yellow", "blue", "blue"},
        orig_num = 3,
    })

end
