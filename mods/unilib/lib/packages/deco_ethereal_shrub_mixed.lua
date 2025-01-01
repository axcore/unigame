---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_shrub_mixed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_shrub_mixed.init()

    return {
        description = "Two shrubs combined as a single decoration",
        depends = {"biome_ethereal_desert_cold", "sand_silver"},
        at_least_one = {"plant_shrub_dry_fiery", "plant_shrub_snowy"},
    }

end

function unilib.pkg.deco_ethereal_shrub_mixed.exec()

    if unilib.global.pkg_executed_table["plant_shrub_dry_fiery"] ~= nil then

        if unilib.global.pkg_executed_table["plant_shrub_snowy"] ~= nil then

            unilib.register_decoration_generic("ethereal_shrubs_desert", {
                -- From ethereal-ng/decor.lua
                deco_type = "simple",
                decoration = {"unilib:plant_shrub_dry_fiery", "unilib:plant_shrub_snowy"},

                fill_ratio = 0.025,
                sidelen = 80,
            })

        else

            unilib.register_decoration_generic("ethereal_plant_shrub_dry_fiery_desert", {
                -- From ethereal-ng/decor.lua
                deco_type = "simple",
                decoration = "unilib:plant_shrub_dry_fiery",

                fill_ratio = 0.025 / 2,
                sidelen = 80,
            })

        end

    else

        unilib.register_decoration_generic("ethereal_plant_shrub_snowy_desert", {
            -- From ethereal-ng/decor.lua
            deco_type = "simple",
            decoration = "unilib:plant_shrub_snowy",

            fill_ratio = 0.025 / 2,
            sidelen = 80,
        })

    end

end

function unilib.pkg.deco_ethereal_shrub_mixed.post()

    local def_table = {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_desert_cold",
        place_on = "unilib:sand_silver",
        y_max = 100,
        y_min = 100,
    }

    if unilib.global.pkg_executed_table["plant_shrub_dry_fiery"] ~= nil then

        if unilib.global.pkg_executed_table["plant_shrub_snowy"] ~= nil then

            unilib.register_decoration_complete("ethereal_shrubs_desert", nil, def_table)

        else

            unilib.register_decoration_complete(
                "ethereal_plant_shrub_dry_fiery_desert", nil, def_table
            )

        end

    else

        unilib.register_decoration_complete(
            "ethereal_plant_shrub_snowy_desert", nil, def_table
        )

    end

end
