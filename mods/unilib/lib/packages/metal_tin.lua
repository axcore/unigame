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

unilib.pkg.metal_tin = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local glemr11_add_mode = unilib.global.imported_mod_table.glemr11.add_mode
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_tin.init()

    return {
        description = "Tin",
        optional = "machine_furnace_induction",
    }

end

function unilib.pkg.metal_tin.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "tin",
        description = S("Tin"),

        hardness = 2,
    })

    unilib.register_craftitem(
        -- From default:tin_lump
        "unilib:metal_tin_lump",
        {"default:tin_lump", "moreores:tin_lump"},
        default_add_mode,
        {
            description = S("Tin Lump"),
            inventory_image = "unilib_metal_tin_lump.png"
        }
    )

    unilib.register_metal_powder({
        -- From technic:tin_dust. Creates unilib:metal_tin_powder
        part_name = "tin",
        orig_name = "technic:tin_dust",

        replace_mode = technic_add_mode,
        description = S("Tin Powder"),
    })

    unilib.register_craftitem(
        -- From default:tin_ingot
        "unilib:metal_tin_ingot",
        {"default:tin_ingot", "moreores:tin_ingot"},
        default_add_mode,
        {
            description = S("Tin Ingot"),
            inventory_image = "unilib_metal_tin_ingot.png",
            -- N.B. no groups in original code
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From default:tin_ingot
        type = "cooking",
        output = "unilib:metal_tin_ingot",
        recipe = "unilib:metal_tin_lump",
    })
    unilib.register_craft({
        -- From default:tin_ingot
        output = "unilib:metal_tin_ingot 9",
        recipe = {
            {"unilib:metal_tin_block"},
        },
    })

    unilib.register_node(
        -- From default:tinblock
        "unilib:metal_tin_block",
        {"default:tinblock", "moreores:tin_block"},
        default_add_mode,
        {
            description = S("Tin Block"),
            tiles = {"unilib_metal_tin_block.png"},
            groups = {cracky = 1, level = 2},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From default:tinblock
        output = "unilib:metal_tin_block",
        ingredient = "unilib:metal_tin_ingot",
    })
    unilib.register_stairs("unilib:metal_tin_block")
    unilib.register_carvings("unilib:metal_tin_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_tin_block_compressed", nil, default_add_mode, {
            -- Original to unilib
            description = S("Compressed Tin Block"),
            tiles = {"unilib_metal_tin_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("tin")

    end

    if unilib.global.pkg_executed_table["machine_furnace_induction"] ~= nil then

        -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
        unilib.register_liquid({
            part_name = "molten_tin",
            source_name = "unilib:liquid_molten_tin_source",
            flowing_name = "unilib:liquid_molten_tin_flowing",

            burntime = 15,
            description = S("Molten Tin"),
            force_renew_flag = false,
            group_table = {molten_liquid = 1},
        })

        unilib.register_metal_molten({
            -- From GLEMr11, lib_materials:liquid_molten_tin_source, etc. Creates
            --      unilib:liquid_molten_tin_source, etc
            part_name = "tin",
            source_orig_name = "lib_materials:liquid_molten_tin_source",
            flowing_orig_name = "lib_materials:liquid_molten_tin_flowing",

            replace_mode = glemr11_add_mode,
            source_description = S("Molten Tin Source"),
            flowing_description = S("Flowing Molten Tin"),
        })

    end

end
