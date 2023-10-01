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

unilib.pkg.metal_steel_stainless = {}

local S = unilib.intllib
local technic_add_mode = unilib.imported_mod_table.technic.add_mode
local worldgen_add_mode = unilib.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_stainless.init()

    return {
        description = "Stainless steel",
        optional = {"metal_chromium", "metal_steel_carbon"},
    }

end

function unilib.pkg.metal_steel_stainless.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "steel_stainless",
        description = S("Stainless Steel"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- From technic:stainless_steel_dust. Creates unilib:metal_steel_stainless_powder
        part_name = "steel_stainless",
        orig_name = "technic:stainless_steel_dust",

        replace_mode = technic_add_mode,
        description = S("Stainless Steel Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From technic:stainless_steel_ingot
        "unilib:metal_steel_stainless_ingot",
        "technic:stainless_steel_ingot",
        worldgen_add_mode,
        {
            description = S("Stainless Steel Ingot"),
            inventory_image = "unilib_metal_steel_stainless_ingot.png",
            -- N.B. no groups in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From technic:stainless_steel_ingot
        output = "unilib:metal_steel_stainless_ingot 9",
        recipe = {
            {"unilib:metal_steel_stainless_block"},
        }
    })
    -- In the technic mod, an alloy furnace is required to craft stainless steel ingots. In case
    --      technic is not available, provide an alternative recipe
    if minetest.get_modpath("technic") == nil and
            unilib.pkg_executed_table["metal_chromium"] ~= nil and
            unilib.pkg_executed_table["metal_steel_carbon"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:metal_steel_stainless_ingot 4",
            recipe = {
                {"unilib:metal_steel_carbon_ingot", "unilib:metal_steel_carbon_ingot"},
                {"unilib:metal_steel_carbon_ingot", "unilib:metal_chromium_ingot"},
            },
        })

    end

    unilib.register_node(
        -- From technic:stainless_steel_block
        "unilib:metal_steel_stainless_block",
        "technic:stainless_steel_block",
        worldgen_add_mode,
        {
            description = S("Stainless Steel Block"),
            tiles = {"unilib_metal_steel_stainless_block.png"},
            groups = {cracky = 1, level = 2},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_3x3({
        -- From technic:cast_iron_block
        output = "unilib:metal_steel_stainless_block",
        ingredient = "unilib:metal_steel_stainless_ingot",
    })

end
