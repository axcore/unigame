---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
--
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_mithril = {}

local S = unilib.intllib
local glemr11_add_mode = unilib.global.imported_mod_table.glemr11.add_mode
local moreores_add_mode = unilib.global.imported_mod_table.moreores.add_mode
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_mithril.init()

    return {
        description = "Mithril",
        optional = "machine_furnace_induction",
    }

end

function unilib.pkg.metal_mithril.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "mithril",
        description = S("Mithril"),

        fictional_flag = true,
        hardness = 2,
    })

    unilib.register_craftitem(
        -- From moreores:mithril_lump
        "unilib:metal_mithril_lump",
        "moreores:mithril_lump",
        moreores_add_mode,
        {
            description = S("Mithril Lump"),
            inventory_image = "unilib_metal_mithril_lump.png"
        }
    )

    unilib.register_metal_powder({
        -- From technic:mithril_dust. Creates unilib:metal_mithril_powder
        part_name = "mithril",
        orig_name = "technic:mithril_dust",

        replace_mode = technic_add_mode,
        description = S("Mithril Powder"),
    })

    unilib.register_craftitem(
        -- From moreores:mithril_ingot
        "unilib:metal_mithril_ingot",
        "moreores:mithril_ingot",
        moreores_add_mode,
        {
            description = S("Mithril Ingot"),
            inventory_image = "unilib_metal_mithril_ingot.png",
            -- N.B. no groups in original code
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From moreores:mithril_ingot
        type = "cooking",
        output = "unilib:metal_mithril_ingot",
        recipe = "unilib:metal_mithril_lump",
    })
    unilib.register_craft({
        -- From moreores:mithril_ingot
        output = "unilib:metal_mithril_ingot 9",
        recipe = {
            {"unilib:metal_mithril_block"},
        },
    })

    unilib.register_node(
        -- From moreores:mithril_block
        "unilib:metal_mithril_block",
        "moreores:mithril_block",
        moreores_add_mode,
        {
            description = S("Mithril Block"),
            tiles = {"unilib_metal_mithril_block.png"},
            groups = {bendy = 2, cracky = 1, level = 2, melty = 2, snappy = 1},
            sounds = unilib.global.sound_table.metal,

            -- N.B. Not in original code
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From moreores:mithril_block
        output = "unilib:metal_mithril_block",
        ingredient = "unilib:metal_mithril_ingot",
    })
    unilib.register_stairs("unilib:metal_mithril_block")
    unilib.register_carvings("unilib:metal_mithril_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_mithril_block_compressed", nil, moreores_add_mode, {
            -- Original to unilib
            description = S("Compressed Mithril Block"),
            tiles = {"unilib_metal_mithril_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("mithril")

    end

    if unilib.global.pkg_executed_table["machine_furnace_induction"] ~= nil then

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

            replace_mode = glemr11_add_mode,
            source_description = S("Molten Mithril Source"),
            flowing_description = S("Flowing Molten Mithril"),
        })

    end

end
