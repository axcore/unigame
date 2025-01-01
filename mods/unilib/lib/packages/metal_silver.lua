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

unilib.pkg.metal_silver = {}

local S = unilib.intllib
local glemr11_add_mode = unilib.global.imported_mod_table.glemr11.add_mode
local moreores_add_mode = unilib.global.imported_mod_table.moreores.add_mode
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_silver.init()

    return {
        description = "Silver",
        notes = "An alternative material for making lockable chests",
        optional = {"container_chest_ordinary", "machine_furnace_induction"},
    }

end

function unilib.pkg.metal_silver.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "silver",
        description = S("Silver"),

        hardness = 2,
    })

    unilib.register_craftitem(
        -- From moreores:silver_lump
        "unilib:metal_silver_lump",
        "moreores:silver_lump",
        moreores_add_mode,
        {
            description = S("Silver Lump"),
            inventory_image = "unilib_metal_silver_lump.png"
        }
    )

    unilib.register_metal_powder({
        -- From technic:silver_dust. Creates unilib:metal_silver_powder
        part_name = "silver",
        orig_name = "technic:silver_dust",

        replace_mode = technic_add_mode,
        description = S("Silver Powder"),
    })

    unilib.register_craftitem(
        -- From moreores:silver_ingot
        "unilib:metal_silver_ingot",
        "moreores:silver_ingot",
        moreores_add_mode,
        {
            description = S("Silver Ingot"),
            inventory_image = "unilib_metal_silver_ingot.png",
            -- N.B. no groups in original code
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From moreores:silver_ingot
        type = "cooking",
        output = "unilib:metal_silver_ingot",
        recipe = "unilib:metal_silver_lump",
    })
    unilib.register_craft({
        -- From moreores:silver_ingot
        output = "unilib:metal_silver_ingot 9",
        recipe = {
            {"unilib:metal_silver_block"},
        },
    })

    unilib.register_node("unilib:metal_silver_block", "moreores:silver_block", moreores_add_mode, {
        -- From moreores:silver_block
        description = S("Silver Block"),
        tiles = {"unilib_metal_silver_block.png"},
        groups = {bendy = 2, cracky = 1, level = 2, melty = 2, snappy = 1},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From moreores:silver_block
        output = "unilib:metal_silver_block",
        ingredient = "unilib:metal_silver_ingot",
    })
    unilib.register_stairs("unilib:metal_silver_block")
    unilib.register_carvings("unilib:metal_silver_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_silver_block_compressed", nil, moreores_add_mode, {
            -- Original to unilib
            description = S("Compressed Silver Block"),
            tiles = {"unilib_metal_silver_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("silver")

    end

    if unilib.global.pkg_executed_table["machine_furnace_induction"] ~= nil then

        -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
        unilib.register_liquid({
            part_name = "molten_silver",
            source_name = "unilib:liquid_molten_silver_source",
            flowing_name = "unilib:liquid_molten_silver_flowing",

            burntime = 15,
            description = S("Molten Silver"),
            force_renew_flag = false,
            group_table = {molten_liquid = 1},
        })

        unilib.register_metal_molten({
            -- From GLEMr11, lib_materials:liquid_molten_silver_source, etc. Creates
            --      unilib:liquid_molten_silver_source, etc
            part_name = "silver",
            source_orig_name = "lib_materials:liquid_molten_silver_source",
            flowing_orig_name = "lib_materials:liquid_molten_silver_flowing",

            replace_mode = glemr11_add_mode,
            source_description = S("Molten Silver Source"),
            flowing_description = S("Flowing Molten Silver"),
        })

    end

    if unilib.global.pkg_executed_table["container_chest_ordinary"] ~= nil then

        unilib.register_craft({
            -- From moreores:silver_ingot
            output = "unilib:container_chest_ordinary_locked",
            recipe = {
                {"unilib:metal_silver_ingot"},
                {"unilib:container_chest_ordinary"},
            }
        })
        unilib.register_craft({
            -- From moreores:silver_ingot
            output = "unilib:container_chest_ordinary_locked",
            recipe = {
                {"group:wood", "group:wood", "group:wood"},
                {"group:wood", "unilib:metal_silver_ingot", "group:wood"},
                {"group:wood", "group:wood", "group:wood"},
            }
        })

    end

end
