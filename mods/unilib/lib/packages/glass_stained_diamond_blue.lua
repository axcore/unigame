---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_diamond_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_diamond_blue.init()

    return {
        description = "Blue diamond stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_diamond_blue.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_12_single, etc. Creates
        --      unilib:glass_stained_diamond_blue_single, etc
        part_name = "diamond_blue",
        description = S("Blue Diamond Stained Glass"),

        replace_mode = mode,
        craft_list = {"yellow", "cyan", "cyan"},
        orig_num = 12,
    })

end
