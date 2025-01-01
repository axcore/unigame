---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
--
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_zinc = {}

local S = unilib.intllib
local glemr11_add_mode = unilib.global.imported_mod_table.glemr11.add_mode
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode
local worldgen_add_mode = unilib.global.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_zinc.init()

    return {
        description = "Zinc",
        optional = "machine_furnace_induction",
    }

end

function unilib.pkg.metal_zinc.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "zinc",
        description = S("Zinc"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_zinc_lump", "technic:zinc_lump", worldgen_add_mode, {
        -- From technic:zinc_lump
        description = S("Zinc Lump"),
        inventory_image = "unilib_metal_zinc_lump.png",
    })

    unilib.register_metal_powder({
        -- From technic:zinc_dust. Creates unilib:metal_zinc_powder
        part_name = "zinc",
        orig_name = "technic:zinc_dust",

        replace_mode = technic_add_mode,
        description = S("Zinc Powder"),
    })

    unilib.register_craftitem("unilib:metal_zinc_ingot", "technic:zinc_ingot", worldgen_add_mode, {
        -- From unilib:metal_zinc_ingot
        description = S("Zinc Ingot"),
        inventory_image = "unilib_metal_zinc_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From unilib:metal_zinc_ingot
        type = "cooking",
        output = "unilib:metal_zinc_ingot",
        recipe = "unilib:metal_zinc_lump",
    })
    unilib.register_craft({
        -- From unilib:metal_zinc_ingot
        output = "unilib:metal_zinc_ingot 9",
        recipe = {
            {"unilib:metal_zinc_block"},
        },
    })

    unilib.register_node("unilib:metal_zinc_block", "technic:zinc_block", worldgen_add_mode, {
        -- From technic:zinc_block
        description = S("Zinc Block"),
        tiles = {"unilib_metal_zinc_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content not in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From technic:zinc_block
        output = "unilib:metal_zinc_block",
        ingredient = "unilib:metal_zinc_ingot",
    })
    unilib.register_stairs("unilib:metal_zinc_block")
    unilib.register_carvings("unilib:metal_zinc_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_zinc_block_compressed", nil, worldgen_add_mode, {
            -- Original to unilib
            description = S("Compressed Zinc Block"),
            tiles = {"unilib_metal_zinc_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("zinc")

    end

    if unilib.global.pkg_executed_table["machine_furnace_induction"] ~= nil then

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

            replace_mode = glemr11_add_mode,
            source_description = S("Molten Zinc Source"),
            flowing_description = S("Flowing Molten Zinc"),
        })

    end

end
