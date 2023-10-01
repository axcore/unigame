---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_molten_mercury = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_molten_mercury.init()

    return {
        description = "Molten mercury",
        depends = {"gravel_ordinary", "metal_mercury"},
    }

end

function unilib.pkg.liquid_molten_mercury.exec()

    -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
    unilib.register_liquid({
        part_name = "molten_mercury",
        source_name = "unilib:liquid_molten_mercury_source",
        flowing_name = "unilib:liquid_molten_mercury_flowing",

        burntime = 15,
        description = S("Molten Mercury"),
        force_renew_flag = false,
        group_table = {molten_liquid = 1},
    })

    unilib.register_metal_molten({
        -- From GLEMr11, lib_materials:liquid_molten_mercury_source, etc. Creates
        --      unilib:liquid_molten_mercury_source, etc
        part_name = "mercury",
        source_orig_name = "lib_materials:liquid_molten_mercury_source",
        flowing_orig_name = "lib_materials:liquid_molten_mercury_flowing",

        replace_mode = mode,
        -- (There is no mercury block)
        cooled_name = "unilib:gravel_ordinary",
        source_description = S("Molten Mercury Source"),
        flowing_description = S("Flowing Molten Mercury"),
        source_length = 2,
        flowing_length = 0.8,
    })

end
