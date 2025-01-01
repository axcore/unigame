---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_iron_wrought = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- This package upgrades unilib:metal_steel_ingot into a wrought iron ingot, as in technic
-- Technic provides craft recipes that depend on an alloy furnace. If that is not available, unilib
--      provides alternatives:
--
--      iron lump > COOK > wrought iron ingot
--
--      wrought iron ingot > COOK > cast iron ingot
--      cast iron ingot > COOK > wrought iron ingot
--
--      wrought iron ingot + coal lump > CRAFT > carbon steel ingot
--      carbon steel ingot > COOK > wrought iron ingot
--
--      carbon steel ingot + chromium ingot > CRAFT > stainless steel ingot

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_iron_wrought.init()

    return {
        description = "Wrought iron",
        notes = "If this package is executed, the steel ingot/block created by the" ..
                " \"metal_steel\" package is upgraded to wrought iron (as in technic)",
        depends = "metal_steel",
        optional = {"metal_iron_cast", "metal_steel_carbon", "mineral_coal"},
    }

end

function unilib.pkg.metal_iron_wrought.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "iron_wrought",
        description = S("Wrought Iron"),

        alloy_flag = true,
        hardness = 2,
    })

    if core.registered_craftitems["unilib:metal_steel_powder"] ~= nil then

        unilib.register.upgrade_craftitem(
            -- From technic:wrought_iron_dust
            "unilib:metal_steel_powder",
            "technic:wrought_iron_dust",
            {
                description = S("Wrought Iron Powder"),
                inventory_image = "unilib_metal_iron_wrought_powder.png",
            }
        )

    end

    unilib.register.upgrade_craftitem("unilib:metal_steel_ingot", "technic:wrought_iron_ingot", {
        -- From technic:wrought_iron_ingot
        description = S("Wrought Iron Ingot"),
        inventory_image = "unilib_metal_iron_wrought_ingot.png",
        -- N.B. no groups in original code
        groups = {alloy = 1, metal_ingot = 1},
    })
    if unilib.global.pkg_executed_table["metal_iron_cast"] ~= nil then

        unilib.register_craft({
            -- From technic:wrought_iron_ingot
            type = "cooking",
            output = "unilib:metal_steel_ingot",
            recipe = "unilib:metal_iron_cast_ingot",
            cooktime = 2,
        })

        unilib.register_craft({
            -- From technic:cast_iron_ingot
            type = "cooking",
            output = "unilib:metal_iron_cast_ingot",
            recipe = "unilib:metal_steel_ingot",
        })

    end
    if unilib.global.pkg_executed_table["metal_steel_carbon"] ~= nil and
            unilib.global.pkg_executed_table["mineral_coal"] ~= nil then

        unilib.register_craft({
            -- From technic:wrought_iron_ingot
            type = "cooking",
            output = "unilib:metal_steel_ingot",
            recipe = "unilib:metal_steel_carbon_ingot",
            cooktime = 2,
        })

        -- In the technic mod, an alloy furnace is required to craft carbon steel ingots. In case
        --      technic is not available, provide an alternative recipe
        if core.get_modpath("technic") == nil then

            unilib.register_craft({
                -- Original to unilib
                output = "unilib:metal_steel_carbon_ingot 2",
                recipe = {
                    {"unilib:metal_steel_ingot", "unilib:mineral_coal_lump"},
                    {"unilib:mineral_coal_lump", "unilib:metal_steel_ingot"},
                },
            })

        end

    end

    unilib.register.upgrade_node("unilib:metal_steel_block", "technic:wrought_iron_block", {
        -- From technic:wrought_iron_block
        description = S("Wrought Iron Block"),
        tiles = {"unilib_metal_iron_wrought_block.png"},
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register.upgrade_node("unilib:metal_steel_block_compressed", nil, {
            -- Original to unilib
            description = S("Compressed Wrought Iron Block"),
            tiles = {"unilib_metal_iron_wrought_block_compressed.png"},
        })

    end

end
