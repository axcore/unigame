---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_molten_mese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_molten_mese.init()

    return {
        description = "Molten mese",
        depends = "mineral_mese",
    }

end

function unilib.pkg.liquid_molten_mese.exec()

    -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
    unilib.register_liquid({
        part_name = "molten_mese",
        source_name = "unilib:liquid_molten_mese_source",
        flowing_name = "unilib:liquid_molten_mese_flowing",

        burntime = 15,
        description = S("Molten Mese"),
        force_renew_flag = false,
        group_table = {molten_liquid = 1},
    })

    unilib.register_metal_molten({
        -- From GLEMr11, lib_materials:liquid_molten_mese_source, etc. Creates
        --      unilib:liquid_molten_mese_source, etc
        part_name = "mese",
        source_orig_name = "lib_materials:liquid_molten_mese_source",
        flowing_orig_name = "lib_materials:liquid_molten_mese_flowing",

        replace_mode = mode,
        cooled_name = "unilib:mineral_mese_block",
        source_description = S("Molten Mese Source"),
        flowing_description = S("Flowing Molten Mese"),
    })

end
