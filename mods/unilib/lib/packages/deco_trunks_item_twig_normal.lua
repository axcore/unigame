---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/trunks
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_trunks_item_twig_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.trunks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_trunks_item_twig_normal.init()

    return {
        description = "Normal twigs as decoration",
        depends = "item_twig_normal",
        at_least_one = {"dirt_ordinary", "liquid_water_ordinary"},
        optional = "fern_ordinary",
    }

end

function unilib.pkg.deco_trunks_item_twig_normal.post()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_decoration_now("convert_item_twig_normal_on_ground", nil, {
            -- From trunks/generating.lua
            -- Completes decoration in package "item_twig_normal"
            place_on = "unilib:dirt_ordinary_with_turf",
            spawn_by = {
                "group:tree",
                "unilib:fern_ordinary_1",
                "unilib:fern_ordinary_2",
                "unilib:fern_ordinary_3",
            },
            y_max = 40,
            y_min = 1,
        })

    end
    if unilib.pkg_executed_table["liquid_water_ordinary"] ~= nil then

        unilib.register_decoration_now("convert_item_twig_normal_on_water", nil, {
            -- From trunks/generating.lua
            -- Completes decoration in package "item_twig_normal"
            place_on = "unilib:liquid_water_ordinary_source",
            spawn_by = {"group:tree"},
            y_max = 40,
            y_min = 1,
        })

    end

end
