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
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC0 1.0 Universal
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_copper = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local glemr11_add_mode = unilib.global.imported_mod_table.glemr11.add_mode
local moreblocks_add_mode = unilib.global.imported_mod_table.moreblocks.add_mode
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_copper.init()

    return {
        description = "Copper",
        optional = "machine_furnace_induction",
    }

end

function unilib.pkg.metal_copper.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "copper",
        description = S("Copper"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_copper_lump", "default:copper_lump", default_add_mode, {
        -- From default:copper_lump
        description = S("Copper Lump"),
        inventory_image = "unilib_metal_copper_lump.png"
    })

    unilib.register_metal_powder({
        -- From technic:copper_dust. Creates unilib:metal_copper_powder
        part_name = "copper",
        orig_name = "technic:copper_dust",

        replace_mode = technic_add_mode,
        description = S("Copper Powder"),
    })

    unilib.register_craftitem(
        -- From default:copper_ingot
        "unilib:metal_copper_ingot",
        "default:copper_ingot",
        default_add_mode,
        {
            description = S("Copper Ingot"),
            inventory_image = "unilib_metal_copper_ingot.png",
            -- N.B. no groups in original code
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From default:copper_ingot
        type = "cooking",
        output = "unilib:metal_copper_ingot",
        recipe = "unilib:metal_copper_lump",
    })
    unilib.register_craft({
        -- From default:copper_ingot
        output = "unilib:metal_copper_ingot 9",
        recipe = {
            {"unilib:metal_copper_block"},
        },
    })

    unilib.register_node("unilib:metal_copper_block", "default:copperblock", default_add_mode, {
        -- From default:copperblock
        description = S("Copper Block"),
        tiles = {"unilib_metal_copper_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From default:copperblock
        output = "unilib:metal_copper_block",
        ingredient = "unilib:metal_copper_ingot",
    })
    unilib.register_stairs("unilib:metal_copper_block")
    unilib.register_carvings("unilib:metal_copper_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_copper_block_compressed", nil, default_add_mode, {
            -- Original to unilib
            description = S("Compressed Copper Block"),
            tiles = {"unilib_metal_copper_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("copper")

    end

    if unilib.setting.mtgame_tweak_flag and
            (moreblocks_add_mode ~= "defer" or not core.get_modpath("moreblocks")) and
            unilib.global.pkg_executed_table["liquid_water_ordinary"] ~= nil then

        unilib.register_node(
            -- From moreblocks:copperpatina
            "unilib:metal_copper_patina_block",
            "moreblocks:copperpatina",
            moreblocks_add_mode,
            {
                description = S("Copper Patina Block"),
                tiles = {"unilib_metal_copper_patina_block.png"},
                groups = {cracky = 1, level = 2},
                sounds = unilib.global.sound_table.metal,

                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From moreblocks:copperpatina
            output = "unilib:metal_copper_ingot 9",
            recipe = {
                {"unilib:metal_copper_patina_block"},
            },
        })
        unilib.register_stairs("unilib:metal_copper_patina_block")
        unilib.register_carvings("unilib:metal_copper_patina_block", {
            millwork_flag = true,
        })

        if unilib.setting.squeezed_metal_flag then

            unilib.register_node(
                -- Original to unilib
                "unilib:metal_copper_patina_block_compressed",
                nil,
                moreblocks_add_mode,
                {
                    description = S("Compressed Copper Patina Block"),
                    tiles = {"unilib_metal_copper_patina_block_compressed.png"},
                    groups = {cracky = 1, level = 3},
                    sounds = unilib.global.sound_table.metal,

                    is_ground_content = false,
                    stack_max = unilib.global.squeezed_stack_max,
                }
            )
            unilib.misc.set_compressed_metal_recipes("copper_patina")

        end

    end

    if unilib.global.pkg_executed_table["machine_furnace_induction"] ~= nil then

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

            replace_mode = glemr11_add_mode,
            source_description = S("Molten Copper Source"),
            flowing_description = S("Flowing Molten Copper"),
        })

    end

end

function unilib.pkg.metal_copper.post()

    if unilib.setting.mtgame_tweak_flag and (
            moreblocks_add_mode ~= "defer" or not core.get_modpath("moreblocks")
    ) then

        unilib.register_craft({
            -- From moreblocks:copperpatina
            type = "shapeless",
            output = "unilib:metal_copper_patina_block",
            recipe = {"group:craftable_bucket", "unilib:metal_copper_block"},
            replacements = unilib.global.craftable_bucket_list,
        })

    end

end
