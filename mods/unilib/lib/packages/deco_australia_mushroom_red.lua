---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_australia_mushroom_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_australia_mushroom_red.init()

    return {
        description = "Red mushroom as decoration",
        depends = {"dirt_ordinary", "mushroom_red"},
        at_least_one = {"biome_australia_tasmania", "biome_australia_victorian_forests"},
    }

end

function unilib.pkg.deco_australia_mushroom_red.exec()

    unilib.register_decoration("flowers_mushroom_red_in_australia", {
        -- From australia/biome_tasmania.lua, etc
        deco_type = "simple",
        decoration = "unilib:mushroom_red",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.66,
            scale = 0.006,
            seed = 56,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end

function unilib.pkg.deco_australia_mushroom_red.post()

    if unilib.pkg_executed_table["biome_australia_tasmania"] ~= nil then

        unilib.register_decoration_now(
            -- From australia/biome_tasmania.lua
            "flowers_mushroom_red_in_australia",
            "flowers_mushroom_red_in_australia_1",
            {
                biomes = "australia_tasmania",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = unilib.y_max,
                y_min = 7,
            }
        )

    end

    if unilib.pkg_executed_table["biome_australia_victorian_forests"] ~= nil then

        unilib.register_decoration_now(
            -- From australia/biome_victorian_forests.lua
            "flowers_mushroom_red_in_australia",
            "flowers_mushroom_red_in_australia_2",
            {
                biomes = "australia_victorian_forests",
                place_on = "unilib:dirt_ordinary_with_turf",
                y_max = 180,
                y_min = 36,
            }
        )

    end

end
