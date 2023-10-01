---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_ryegrass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_ryegrass.init()

    return {
        description = "Ten varieties of dark green grass, which do not grow or spread",
        optional = "dye_basic",
    }

end

function unilib.pkg.grass_ryegrass.exec()

    for i = 1, 10 do

        local full_name = "unilib:grass_ryegrass_" .. tostring(i)
        local img = "unilib_grass_ryegrass_" .. tostring(i) .. ".png"
        local select_box = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}
        if i == 4 or i == 5 then
            select_box = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375}
        end

        unilib.register_node(full_name, "beautiflowers:pasto_" .. tostring(i), mode, {
            -- From beautiflowers:pasto_1, etc
            description = S("Ryegrass"),
            tiles = {img},
            -- N.B. In original code, beautiflowers = 1 replaces the color-XXX group
            -- N.B. grass = 1, ryegrass = 1 not in original code
            groups = {
                attached_node = 1, color_dark_green = 1, flammable = 1, flora = 1, flower = 1,
                grass = 1, ryegrass = 1, snappy = 3,
            },
            sounds = unilib.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            inventory_image = img,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = select_box,
            },
            sunlight_propagates = true,
            visual_scale = 1.0,
            walkable = false,
            waving = 1,
            wield_image = img,
        })
        if unilib.pkg_executed_table["dye_basic"] ~= nil then

            unilib.register_craft({
                -- From beautiflowers:pasto_1, etc
                output = "unilib:dye_green_dark 4",
                recipe = {
                    {full_name},
                },
            })

        end
        unilib.register_plant_in_pot(full_name, "beautiflowers:pasto_" .. tostring(i))

        unilib.register_decoration("beautiflowers_grass_ryegrass_" .. tostring(i), {
            -- From beautiflowers:pasto_1, etc
            deco_type = "simple",
            decoration = full_name,

            noise_params = {
                octaves = 3,
                offset = -0.03,
                persist = 1,
                scale = 0.07,
                seed = 1602,
                spread = {x = 100, y = 100, z = 100},
            },
            sidelen = 16,
        })

    end

end
