---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
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
local default_add_mode = unilib.imported_mod_table.default.add_mode
local moreblocks_add_mode = unilib.imported_mod_table.moreblocks.add_mode
local technic_add_mode = unilib.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_copper.init()

    return {
        description = "Copper",
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
        }
    })

    unilib.register_node("unilib:metal_copper_block", "default:copperblock", default_add_mode, {
        -- From default:copperblock
        description = S("Copper Block"),
        tiles = {"unilib_metal_copper_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

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

    if unilib.mtgame_tweak_flag and
            moreblocks_add_mode ~= "defer" and
            unilib.pkg_executed_table["liquid_water_ordinary"] ~= nil then

        unilib.register_node(
            -- From moreblocks:copperpatina
            "unilib:metal_copper_patina_block",
            "moreblocks:copperpatina",
            moreblocks_add_mode,
            {
                description = S("Copper Patina Block"),
                tiles = {"unilib_metal_copper_patina_block.png"},
                groups = {cracky = 1, level = 2},
                sounds = unilib.sound_table.metal,

                is_ground_content = false,
            }
        )
        minetest.register_craft({
            -- From moreblocks:copperpatina
            output = "unilib:metal_copper_ingot 9",
            recipe = {
                {"unilib:metal_copper_patina_block"},
            }
        })
        unilib.register_stairs("unilib:metal_copper_patina_block")

    end

end

function unilib.pkg.metal_copper.post()

    if unilib.mtgame_tweak_flag and moreblocks_add_mode ~= "defer" then

        unilib.register_craft({
            -- From moreblocks:copperpatina
            type = "shapeless",
            output = "unilib:metal_copper_patina_block",
            recipe = {"group:craftable_bucket", "unilib:metal_copper_block"},
            replacements = unilib.craftable_bucket_list,
        })

    end

end
