---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_mese = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local glemr11_add_mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_mese.init()

    return {
        description = "Mese (as a mineral)",
        notes = "Produces mese crystals (instead of lumps), which in turn produce mese crystal" ..
                " fragments",
        optional = "machine_furnace_induction",
    }

end

function unilib.pkg.mineral_mese.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "mese",
        description = S("Mese"),

        fictional_flag = true,
        hardness = 3,
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From default:mese_crystal
        "unilib:mineral_mese_crystal",
        "default:mese_crystal",
        default_add_mode,
        {
            description = S("Mese Crystal"),
            inventory_image = "unilib_mineral_mese_crystal.png",
        }
    )
    unilib.register_craft({
        -- From default:mese_crystal
        output = "unilib:mineral_mese_crystal 9",
        recipe = {
            {"unilib:mineral_mese_block"},
        },
    })
    unilib.register_craft_3x3({
        -- From default:mese_crystal
        output = "unilib:mineral_mese_crystal",
        ingredient = "unilib:mineral_mese_crystal_fragment",
    })

    unilib.register_craftitem(
        -- From default:mese_crystal_fragment
        "unilib:mineral_mese_crystal_fragment",
        "default:mese_crystal_fragment",
        default_add_mode,
        {
            description = S("Mese Crystal Fragment"),
            inventory_image = "unilib_mineral_mese_crystal_fragment.png",
        }
    )
    unilib.register_craft({
        -- From default:mese_crystal_fragment
        output = "unilib:mineral_mese_crystal_fragment 9",
        recipe = {
            {"unilib:mineral_mese_crystal"},
        },
    })

    unilib.register_node("unilib:mineral_mese_block", "default:mese", default_add_mode, {
        -- From default:mese
        description = S("Mese Block"),
        tiles = {"unilib_mineral_mese_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.stone,

        light_source = 3,
        paramtype = "light",
    })
    unilib.register_craft_3x3({
        -- From default:mese
        output = "unilib:mineral_mese_block",
        ingredient = "unilib:mineral_mese_crystal",
    })
    unilib.register_stairs("unilib:mineral_mese_block")
    unilib.register_carvings("unilib:mineral_mese_block", {
        millwork_flag = true,
    })

    if unilib.global.pkg_executed_table["machine_furnace_induction"] ~= nil then

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

            replace_mode = glemr11_add_mode,
            cooled_name = "unilib:mineral_mese_block",
            source_description = S("Molten Mese Source"),
            flowing_description = S("Flowing Molten Mese"),
            non_metal_flag = true,
        })

    end

end
