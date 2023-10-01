---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_bronze = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local technic_add_mode = unilib.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_bronze.init()

    return {
        description = "Bronze",
        notes = "A product of copper and tin",
        depends = {"metal_copper", "metal_tin"},
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
        }
    })
    unilib.register_craft({
        -- From default:bronze_ingot
        output = "unilib:metal_bronze_ingot 9",
        recipe = {
            {"unilib:metal_bronze_block"},
        }
    })

    unilib.register_node("unilib:metal_bronze_block", "default:bronzeblock", default_add_mode, {
        -- From default:bronzeblock
        description = S("Bronze Block"),
        tiles = {"unilib_metal_bronze_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

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

end
