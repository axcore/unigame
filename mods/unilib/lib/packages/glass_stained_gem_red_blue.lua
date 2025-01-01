---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_gem_red_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_gem_red_blue.init()

    return {
        description = "Red and blue gem stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_gem_red_blue.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_5_single, etc. Creates
        --      unilib:glass_stained_gem_red_blue_single, etc
        part_name = "gem_red_blue",
        description = S("Red and Blue Gem Stained Glass"),

        replace_mode = mode,
        craft_list = {"violet", "red", "blue"},
        orig_num = 5,
    })

end
