---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_peat_with_oil_crude = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_peat_with_oil_crude.init()

    return {
        description = "Peat with crude oil",
        notes = "This dirt can be used as a fuel. If steel buckets are available, they can be" ..
                " used to extract the crude oil",
        optional = {
            "bucket_steel",
            "liquid_oil_crude",
            "liquid_water_ordinary",
            "liquid_water_river",
        },
    }

end

function unilib.pkg.dirt_peat_with_oil_crude.exec()

    unilib.register_node("unilib:dirt_peat_with_oil_crude", nil, mode, {
        -- Texture from PFAA, crudeGround_peat.png. Original code
        description = S("Peat with Crude Oil"),
        tiles = {"unilib_dirt_peat_with_oil_crude.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.global.sound_table.dirt,

        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    unilib.register_craft({
        -- Texture from PFAA, crudeGround_peat.png. Original code
        type = "fuel",
        recipe = "unilib:dirt_peat_with_oil_crude",
        burntime = 20,
    })

end

function unilib.pkg.dirt_peat_with_oil_crude.post()

    local c_dirt = "unilib:dirt_peat_with_oil_crude"

    if unilib.global.pkg_executed_table["bucket_steel"] ~= nil and
            unilib.global.pkg_executed_table["liquid_oil_crude"] ~= nil then

        if unilib.global.pkg_executed_table["liquid_water_ordinary"] ~= nil then

            unilib.register_craft({
                -- Original to unilib
                output = "unilib:bucket_steel_with_oil_crude",
                recipe = {
                    {c_dirt, c_dirt, c_dirt},
                    {c_dirt, "unilib:bucket_steel_with_water_ordinary", c_dirt},
                    {c_dirt, c_dirt, c_dirt},
                },
            })

        end

        if unilib.global.pkg_executed_table["liquid_water_river"] ~= nil then

            unilib.register_craft({
                -- Original to unilib
                output = "unilib:bucket_steel_with_oil_crude",
                recipe = {
                    {c_dirt, c_dirt, c_dirt},
                    {c_dirt, "unilib:bucket_steel_with_water_river", c_dirt},
                    {c_dirt, c_dirt, c_dirt},
                },
            })

        end

    end

end
