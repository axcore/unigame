---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
--
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_mercury = {}

local S = unilib.intllib
local glemr11_add_mode = unilib.global.imported_mod_table.glemr11.add_mode
local unilib_add_mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_mercury.init()

    return {
        description = "Mercury",
        optional = {"gravel_ordinary", "machine_furnace_induction"},
    }

end

function unilib.pkg.metal_mercury.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "mercury",
        description = S("Mercury"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_mercury_sample", nil, unilib_add_mode, {
        -- Original to unilib
        description = S("Mercury Sample"),
        inventory_image = "unilib_metal_mercury_sample.png",
        groups = {metal_sample = 1},
    })

    if unilib.global.pkg_executed_table["gravel_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["machine_furnace_induction"] ~= nil then

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

            replace_mode = glemr11_add_mode,
            -- (There is no mercury block)
            cooled_name = "unilib:gravel_ordinary",
            source_description = S("Molten Mercury Source"),
            flowing_description = S("Flowing Molten Mercury"),
            source_length = 2,
            flowing_length = 0.8,
        })

    end

end
