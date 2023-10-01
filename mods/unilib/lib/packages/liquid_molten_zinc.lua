---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_molten_zinc = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_molten_zinc.init()

    return {
        description = "Molten zinc",
        depends = "metal_zinc",
    }

end

function unilib.pkg.liquid_molten_zinc.exec()

    -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
    unilib.register_liquid({
        part_name = "molten_zinc",
        source_name = "unilib:liquid_molten_zinc_source",
        flowing_name = "unilib:liquid_molten_zinc_flowing",

        burntime = 15,
        description = S("Molten Zinc"),
        force_renew_flag = false,
        group_table = {molten_liquid = 1},
    })

    unilib.register_metal_molten({
        -- From GLEMr11, lib_materials:liquid_molten_zinc_source, etc. Creates
        --      unilib:liquid_molten_zinc_source, etc
        part_name = "zinc",
        source_orig_name = "lib_materials:liquid_molten_zinc_source",
        flowing_orig_name = "lib_materials:liquid_molten_zinc_flowing",

        replace_mode = mode,
        source_description = S("Molten Zinc Source"),
        flowing_description = S("Flowing Molten Zinc"),
    })

end
