---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_iron_cast = {}

local S = unilib.intllib
local technic_add_mode = unilib.imported_mod_table.technic.add_mode
local worldgen_add_mode = unilib.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_iron_cast.init()

    return {
        description = "Cast iron",
        depends = "metal_steel",
    }

end

function unilib.pkg.metal_iron_cast.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "iron_cast",
        description = S("Cast Iron"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- From technic:cast_iron_dust. Creates unilib:metal_iron_cast_powder
        part_name = "iron_cast",
        orig_name = "technic:cast_iron_dust",

        replace_mode = technic_add_mode,
        description = S("Cast Iron Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From technic:cast_iron_ingot
        "unilib:metal_iron_cast_ingot",
        "technic:cast_iron_ingot",
        worldgen_add_mode,
        {
            description = S("Cast Iron Ingot"),
            inventory_image = "unilib_metal_iron_cast_ingot.png",
            -- N.B. no groups in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From technic:cast_iron_ingot
        output = "unilib:metal_iron_cast_ingot 9",
        recipe = {
            {"unilib:metal_iron_cast_block"},
        }
    })

    unilib.register_node(
        -- From technic:cast_iron_block
        "unilib:metal_iron_cast_block",
        "technic:cast_iron_block",
        worldgen_add_mode,
        {
            description = S("Cast Iron Block"),
            tiles = {"unilib_metal_iron_cast_block.png"},
            groups = {cracky = 1, level = 2},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_3x3({
        -- From technic:cast_iron_block
        output = "unilib:metal_iron_cast_block",
        ingredient = "unilib:metal_iron_cast_ingot",
    })

end
