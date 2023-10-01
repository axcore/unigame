---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_stained_porthole_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_stained_porthole_blue.init()

    return {
        description = "Blue porthole stained glass",
        depends = "shared_glass_stained",
    }

end

function unilib.pkg.glass_stained_porthole_blue.exec()

    unilib.pkg.shared_glass_stained.register_stained_glass({
        -- From glass_stained:glass_7_single, etc. Creates
        --      unilib:glass_stained_porthole_blue_single, etc
        part_name = "porthole_blue",
        description = S("Blue porthole Stained Glass"),

        replace_mode = mode,
        craft_list = {"red", "violet", "blue"},
        orig_num = 7,
    })

end
