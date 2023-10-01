---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_pigiron_crafting = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pigiron.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_pigiron_crafting.init()

    return {
        description = "Makes crafting steel harder by introducing intermediate pig-iron stage",
        notes = "Uses existing pig iron/charcoal items from the real_minerals/ethereal mods. " ..
                " Cook iron lumps to produce pig iron, craft pig iron and charcoal to produce " ..
                " a mix, then cook the mix to produce steel ingots",
        depends = {"metal_iron", "metal_iron_pig", "metal_steel"},
        at_least_one = {"material_charcoal_artificial_lump", "mineral_charcoal_natural"},
    }

end

function unilib.pkg.override_pigiron_crafting.exec()

    local c_material = "unilib:material_charcoal_artificial_lump"
    local c_mineral = "unilib:mineral_charcoal_natural_lump"
    local c_ingot = "unilib:metal_iron_pig_ingot"

    -- Remove the "iron lump > steel ingot" recipe originating in minetest_game
    minetest.clear_craft({
        type = "cooking",
        recipe = "unilib:metal_iron_lump"
    })

    -- Replace it with a "iron lump + charcoal > mix > steel ingot" recipe
    unilib.register_craft({
        -- From pigiron:iron_ingot
        type = "cooking",
        output = c_ingot,
        recipe = "unilib:metal_iron_lump"
    })

    unilib.register_craftitem("unilib:metal_iron_charcoal_mix", "pigiron:iron_charcoal_mix", mode, {
        -- From pigiron:iron_charcoal_mix
        description = S("Iron and Charcoal Mix"),
        inventory_image = "unilib_metal_iron_pig_ingot.png" ..
                "^unilib_material_charcoal_artificial_lump.png"
    })
    if unilib.pkg_executed_table["material_charcoal_artificial_lump"] ~= nil then

        unilib.register_craft({
            -- From pigiron:iron_charcoal_mix
            output = "unilib:metal_iron_charcoal_mix",
            recipe = {
                {"", c_material, ""},
                {c_material, c_ingot, c_material},
                {"", c_material, ""}
            }
        })

    end
    if unilib.pkg_executed_table["mineral_charcoal_natural"] ~= nil then

        unilib.register_craft({
            -- From pigiron:iron_charcoal_mix
            output = "unilib:metal_iron_charcoal_mix",
            recipe = {
                {"", c_mineral, ""},
                {c_mineral, c_ingot, c_mineral},
                {"", c_mineral, ""}
            }
        })

    end

    unilib.register_craft({
        -- From pigiron:iron_charcoal_mix
        type = "cooking",
        output = "unilib:metal_steel_ingot",
        recipe = "unilib:metal_iron_charcoal_mix",
        cooktime = 10
    })

end
