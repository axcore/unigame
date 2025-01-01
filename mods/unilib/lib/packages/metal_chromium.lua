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

unilib.pkg.metal_chromium = {}

local S = unilib.intllib
local glemr11_add_mode = unilib.global.imported_mod_table.glemr11.add_mode
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode
local worldgen_add_mode = unilib.global.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_chromium.init()

    return {
        description = "Chromium",
        optional = "machine_furnace_induction",
    }

end

function unilib.pkg.metal_chromium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "chromium",
        description = S("Chromium"),

        hardness = 1,
    })

    unilib.register_craftitem(
        -- From technic:chromium_lump
        "unilib:metal_chromium_lump",
        "technic:chromium_lump",
        worldgen_add_mode,
        {
            description = S("Chromium Lump"),
            inventory_image = "unilib_metal_chromium_lump.png",
        }
    )

    unilib.register_metal_powder({
        -- From technic:chromium_dust. Creates unilib:metal_chromium_powder
        part_name = "chromium",
        orig_name = "technic:chromium_dust",

        replace_mode = technic_add_mode,
        description = S("Chromium Powder"),
    })

    unilib.register_craftitem(
        -- From unilib:metal_chromium_ingot
        "unilib:metal_chromium_ingot",
        "technic:chromium_ingot",
        worldgen_add_mode,
        {
            description = S("Chromium Ingot"),
            inventory_image = "unilib_metal_chromium_ingot.png",
            -- N.B. no groups in original code
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From unilib:metal_chromium_ingot
        type = "cooking",
        output = "unilib:metal_chromium_ingot",
        recipe = "unilib:metal_chromium_lump",
    })
    unilib.register_craft({
        -- From unilib:metal_chromium_ingot
        output = "unilib:metal_chromium_ingot 9",
        recipe = {
            {"unilib:metal_chromium_block"},
        },
    })

    unilib.register_node(
        -- From technic:chromium_block
        "unilib:metal_chromium_block",
        "technic:chromium_block",
        worldgen_add_mode,
        {
            description = S("Chromium Block"),
            tiles = {"unilib_metal_chromium_block.png"},
            groups = {cracky = 1, level = 2},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content not in original code
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From technic:chromium_block
        output = "unilib:metal_chromium_block",
        ingredient = "unilib:metal_chromium_ingot",
    })
    unilib.register_stairs("unilib:metal_chromium_block")
    unilib.register_carvings("unilib:metal_chromium_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_chromium_block_compressed", nil, worldgen_add_mode, {
            -- Original to unilib
            description = S("Compressed Chromium Block"),
            tiles = {"unilib_metal_chromium_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("chromium")

    end

    if unilib.global.pkg_executed_table["machine_furnace_induction"] ~= nil then

        -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
        unilib.register_liquid({
            part_name = "molten_chromium",
            source_name = "unilib:liquid_molten_chromium_source",
            flowing_name = "unilib:liquid_molten_chromium_flowing",

            burntime = 15,
            description = S("Molten Chromium"),
            force_renew_flag = false,
            group_table = {molten_liquid = 1},
        })

        unilib.register_metal_molten({
            -- From GLEMr11, lib_materials:liquid_molten_chromium_source, etc. Creates
            --      unilib:liquid_molten_chromium_source, etc
            part_name = "chromium",
            source_orig_name = "lib_materials:liquid_molten_chromium_source",
            flowing_orig_name = "lib_materials:liquid_molten_chromium_flowing",

            replace_mode = glemr11_add_mode,
            source_description = S("Molten Chromium Source"),
            flowing_description = S("Flowing Molten Chromium"),
        })

    end

end
