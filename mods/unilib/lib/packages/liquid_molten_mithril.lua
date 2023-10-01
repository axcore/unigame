---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.liquid_molten_mithril = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.liquid_molten_mithril.init()

    return {
        description = "Molten mithril",
        depends = "metal_mithril",
    }

end

function unilib.pkg.liquid_molten_mithril.exec()

    -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
    unilib.register_liquid({
        part_name = "molten_mithril",
        source_name = "unilib:liquid_molten_mithril_source",
        flowing_name = "unilib:liquid_molten_mithril_flowing",

        burntime = 15,
        description = S("Molten Mithril"),
        force_renew_flag = false,
        group_table = {molten_liquid = 1},
    })

    unilib.register_metal_molten({
        -- From GLEMr11, lib_materials:liquid_molten_mithril_source, etc. Creates
        --      unilib:liquid_molten_mithril_source, etc
        part_name = "mithril",
        source_orig_name = "lib_materials:liquid_molten_mithril_source",
        flowing_orig_name = "lib_materials:liquid_molten_mithril_flowing",

        replace_mode = mode,
        source_description = S("Molten Mithril Source"),
        flowing_description = S("Flowing Molten Mithril"),
    })

end
