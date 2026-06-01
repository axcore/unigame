---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_coneflower_purple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_coneflower_purple.init()

    return {
        description = "Purple coneflowers",
    }

end

function unilib.pkg.flower_coneflower_purple.exec()

    local full_name = "unilib:flower_coneflower_purple_1"
    local orig_name = "elysflowers:purple_coneflower"
    local img = "unilib_flower_coneflower_purple_1.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:purple_coneflower
        description = unilib.utils.annotate(S("Purple Coneflower"), "Echinacea purpurea"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_violet = 1, colour_violet = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.35, -0.5, -0.35, 0.35, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,

        on_place = function(itemstack, placer, pointed_thing)

            if not pointed_thing or pointed_thing.type ~= "node" then
                return itemstack
            end

            local pos = pointed_thing.above
            if math.random(2) == 2 then
                core.set_node(pos, {name = full_name})
            else
                core.set_node(pos, {name = "unilib:flower_coneflower_purple_2"})
            end

            itemstack:take_item()
            return itemstack

        end,
    })
    -- N.B. Not compatible with flowerpots, even in original code

    unilib.register_node(
        "unilib:flower_coneflower_purple_2",
        "elysflowers:purple_coneflower_1",
        mode,
        {
            -- From elysflowers:purple_coneflower_1
            description = unilib.utils.annotate(S("Purple Coneflower"), "Echinacea purpurea"),
            tiles = {"unilib_flower_coneflower_purple_2.png"},
            -- N.B. Used standard unilib flower groups, rather than the extended set in original
            --      code
            groups = {
                attached_node = 1, color_violet = 1, colour_violet = 1, flammable = 1, flora = 1,
                flower = 1, not_in_creative_inventory = 1, snappy = 3,
            },
            sounds = unilib.global.sound_table.leaves,

            drop = full_name,
            drawtype = "plantlike",
            floodable = true,
            inventory_image = img,
            paramtype = "light",
            selection_box = {-0.35, -0.5, -0.35, 0.35, 0.40, 0.35},
            sunlight_propagates = true,
            walkable = false,
            waving = 1,
            wield_image = img,
        }
    )
    -- N.B. Not compatible with flowerpots, even in original code

    unilib.register_decoration_generic("elysflowers_flower_coneflower_purple_1", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 2,
            offset = 0.0009451,
            persist = 0.5,
            scale = 0.00212,
            seed = 58177,
            spread = {x = 64, y = 32, z = 64},
        },
        rotation = "random",
        sidelen = 16,
    })
    unilib.register_decoration_generic("elysflowers_flower_coneflower_purple_2", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = "unilib:flower_coneflower_purple_2",

        noise_params = {
            octaves = 1,
            offset = -0.0274,
            persist = 0.5,
            scale = 0.0212,
            seed = 92731,
            spread = {x = 32, y = 32, z = 32},
        },
        rotation = "random",
        sidelen = 16,
    })

end
