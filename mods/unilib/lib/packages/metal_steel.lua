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

unilib.pkg.metal_steel = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local glemr11_add_mode = unilib.global.imported_mod_table.glemr11.add_mode
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel.init()

    return {
        description = "Steel (produced from iron)",
        depends = "metal_iron",
        optional = "machine_furnace_induction",
    }

end

function unilib.pkg.metal_steel.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "steel",
        description = S("Steel"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- From technic:wrought_iron_dust. Creates unilib:metal_steel_powder
        part_name = "steel",
        orig_name = "technic:wrought_iron_dust",

        replace_mode = technic_add_mode,
        description = S("Steel Powder"),
        -- (no steel lump, so the code below uses the iron lump)
        no_lump_flag = true,
    })
    if unilib.setting.technic_update_flag then

        technic.register_grinder_recipe({
            output = "unilib:metal_steel_powder " ..
                    tostring(unilib.setting.technic_grind_metal_ratio),
            input = {"unilib:metal_iron_lump"},
        })

    end

    unilib.register_craftitem("unilib:metal_steel_ingot", "default:steel_ingot", default_add_mode, {
        -- From default:steel_ingot
        description = S("Steel Ingot"),
        inventory_image = "unilib_metal_steel_ingot.png",
        -- N.B. no groups in original code
        groups = {alloy = 1, metal_ingot = 1},
    })
    unilib.register_craft({
        -- From default:steel_ingot
        type = "cooking",
        output = "unilib:metal_steel_ingot",
        recipe = "unilib:metal_iron_lump",
    })
    unilib.register_craft({
        -- From default:steel_ingot
        output = "unilib:metal_steel_ingot 9",
        recipe = {
            {"unilib:metal_steel_block"},
        },
    })

    unilib.register_node("unilib:metal_steel_block", "default:steelblock", default_add_mode, {
        -- From default:steelblock
        description = S("Steel Block"),
        tiles = {"unilib_metal_steel_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From default:steelblock
        output = "unilib:metal_steel_block",
        ingredient = "unilib:metal_steel_ingot",
    })
    unilib.register_stairs("unilib:metal_steel_block")
    unilib.register_carvings("unilib:metal_steel_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_steel_block_compressed", nil, default_add_mode, {
            -- Original to unilib
            description = S("Compressed Steel Block"),
            tiles = {"unilib_metal_steel_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("steel")

    end

    if unilib.global.pkg_executed_table["machine_furnace_induction"] ~= nil then

        -- (Creates unilib:bucket_steel_with_lava_cooling, etc)
        unilib.register_liquid({
            part_name = "molten_steel",
            source_name = "unilib:liquid_molten_steel_source",
            flowing_name = "unilib:liquid_molten_steel_flowing",

            burntime = 15,
            description = S("Molten Steel"),
            force_renew_flag = false,
            group_table = {molten_liquid = 1},
        })

        unilib.register_metal_molten({
            -- From GLEMr11, lib_materials:liquid_molten_steel_source, etc. Creates
            --      unilib:liquid_molten_steel_source, etc
            part_name = "steel",
            source_orig_name = "lib_materials:liquid_molten_steel_source",
            flowing_orig_name = "lib_materials:liquid_molten_steel_flowing",

            replace_mode = glemr11_add_mode,
            source_description = S("Molten Steel Source"),
            flowing_description = S("Flowing Molten Steel"),
        })

    end

end
