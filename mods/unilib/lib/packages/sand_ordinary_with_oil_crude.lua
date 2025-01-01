---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_ordinary_with_oil_crude = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_ordinary_with_oil_crude.init()

    return {
        description = "Ordinary sand with crude oil",
        notes = "This sand can be used as a fuel. If steel buckets are available, they can be" ..
                " used to extract the crude oil",
        optional = {
            "bucket_steel",
            "liquid_oil_crude",
            "liquid_water_ordinary",
            "liquid_water_river",
        },
    }

end

function unilib.pkg.sand_ordinary_with_oil_crude.exec()

    unilib.register_node("unilib:sand_ordinary_with_oil_crude", nil, mode, {
        -- Texture from PFAA, crudeSand_oilSand.png. Original code
        description = S("Ordinary Sand with Crude Oil"),
        tiles = {"unilib_sand_ordinary_with_oil_crude.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,
    })
    unilib.register_craft({
        -- Texture from PFAA, crudeSand_oilSand.png. Original code
        type = "fuel",
        recipe = "unilib:unilib_sand_ordinary_with_oil_crude",
        -- N.B. This is 75% of the burntime for unilib:dirt_peat_with_oil_crude
        burntime = 15,
    })

end

function unilib.pkg.sand_ordinary_with_oil_crude.post()

    local c_sand = "unilib:sand_ordinary_with_oil_crude"

    if unilib.global.pkg_executed_table["bucket_steel"] ~= nil and
            unilib.global.pkg_executed_table["liquid_oil_crude"] ~= nil then

        if unilib.global.pkg_executed_table["liquid_water_ordinary"] ~= nil then

            unilib.register_craft({
                -- Original to unilib
                output = "unilib:bucket_steel_with_oil_crude",
                recipe = {
                    {c_sand, c_sand, c_sand},
                    {c_sand, "unilib:bucket_steel_with_water_ordinary", c_sand},
                    {c_sand, c_sand, c_sand},
                },
            })

        end

        if unilib.global.pkg_executed_table["liquid_water_river"] ~= nil then

            unilib.register_craft({
                -- Original to unilib
                output = "unilib:bucket_steel_with_oil_crude",
                recipe = {
                    {c_sand, c_sand, c_sand},
                    {c_sand, "unilib:bucket_steel_with_water_river", c_sand},
                    {c_sand, c_sand, c_sand},
                },
            })

        end

    end

end
