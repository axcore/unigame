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
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_bronze = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local glemr11_add_mode = unilib.global.imported_mod_table.glemr11.add_mode
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_bronze.init()

    return {
        description = "Bronze",
        notes = "A product of copper and tin",
        depends = {"metal_copper", "metal_tin"},
        optional = "machine_furnace_induction",
    }

end

function unilib.pkg.metal_bronze.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "bronze",
        description = S("Bronze"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- From technic:bronze_dust. Creates unilib:metal_bronze_powder
        part_name = "bronze",
        orig_name = "technic:bronze_dust",

        replace_mode = technic_add_mode,
        description = S("Bronze Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From default:bronze_ingot
        "unilib:metal_bronze_ingot",
        "default:bronze_ingot",
        default_add_mode,
        {
            description = S("Bronze Ingot"),
            inventory_image = "unilib_metal_bronze_ingot.png",
            -- N.B. no groups in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From default:bronze_ingot
        output = "unilib:metal_bronze_ingot 9",
        recipe = {
            {"unilib:metal_copper_ingot", "unilib:metal_copper_ingot", "unilib:metal_copper_ingot"},
            {"unilib:metal_copper_ingot", "unilib:metal_tin_ingot", "unilib:metal_copper_ingot"},
            {"unilib:metal_copper_ingot", "unilib:metal_copper_ingot", "unilib:metal_copper_ingot"},
        },
    })
    unilib.register_craft({
        -- From default:bronze_ingot
        output = "unilib:metal_bronze_ingot 9",
        recipe = {
            {"unilib:metal_bronze_block"},
        },
    })

    unilib.register_node("unilib:metal_bronze_block", "default:bronzeblock", default_add_mode, {
        -- From default:bronzeblock
        description = S("Bronze Block"),
        tiles = {"unilib_metal_bronze_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From default:bronzeblock
        output = "unilib:metal_bronze_block",
        ingredient = "unilib:metal_bronze_ingot",
    })
    unilib.register_stairs("unilib:metal_bronze_block")
    unilib.register_carvings("unilib:metal_bronze_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_bronze_block_compressed", nil, default_add_mode, {
            -- Original to unilib
            description = S("Compressed Bronze Block"),
            tiles = {"unilib_metal_bronze_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("bronze")

    end

    if unilib.global.pkg_executed_table["machine_furnace_induction"] ~= nil then

        -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
        unilib.register_liquid({
            part_name = "molten_bronze",
            source_name = "unilib:liquid_molten_bronze_source",
            flowing_name = "unilib:liquid_molten_bronze_flowing",

            burntime = 15,
            description = S("Molten Bronze"),
            force_renew_flag = false,
            group_table = {molten_liquid = 1},
        })

        unilib.register_metal_molten({
            -- From GLEMr11, lib_materials:liquid_molten_bronze_source, etc. Creates
            --      unilib:liquid_molten_bronze_source, etc
            part_name = "bronze",
            source_orig_name = "lib_materials:liquid_molten_bronze_source",
            flowing_orig_name = "lib_materials:liquid_molten_bronze_flowing",

            replace_mode = glemr11_add_mode,
            source_description = S("Molten Bronze Source"),
            flowing_description = S("Flowing Molten Bronze"),
        })

    end

end
