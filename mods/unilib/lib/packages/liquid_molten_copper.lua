---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_molten_copper = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_molten_copper.init()

    return {
        description = "Molten copper",
        depends = "metal_copper",
    }

end

function unilib.pkg.liquid_molten_copper.exec()

    -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
    unilib.register_liquid({
        part_name = "molten_copper",
        source_name = "unilib:liquid_molten_copper_source",
        flowing_name = "unilib:liquid_molten_copper_flowing",

        burntime = 15,
        description = S("Molten Copper"),
        force_renew_flag = false,
        group_table = {molten_liquid = 1},
    })

    unilib.register_metal_molten({
        -- From GLEMr11, lib_materials:liquid_molten_copper_source, etc. Creates
        --      unilib:liquid_molten_copper_source, etc
        part_name = "copper",
        source_orig_name = "lib_materials:liquid_molten_copper_source",
        flowing_orig_name = "lib_materials:liquid_molten_copper_flowing",

        replace_mode = mode,
        source_description = S("Molten Copper Source"),
        flowing_description = S("Flowing Molten Copper"),
    })

end
