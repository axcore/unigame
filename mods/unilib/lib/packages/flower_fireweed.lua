---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_fireweed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_fireweed.init()

    return {
        description = "Fireweed",
    }

end

function unilib.pkg.flower_fireweed.exec()

    local full_name = "unilib:flower_fireweed_1"
    local orig_name = "elysflowers:fireweed"
    local img = "unilib_flower_fireweed_1.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:fireweed
        description = unilib.utils.annotate(S("Fireweed"), "Chamaenerion angustifolium"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_magenta = 1, colour_magenta = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.35, -0.4, -0.35, 0.35, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,

        on_place = function(itemstack, placer, pointed_thing)

            if not pointed_thing or pointed_thing.type ~= "node" then
                return itemstack
            end

            local pos = pointed_thing.above
            core.set_node(pos, {name = "unilib:flower_fireweed_" .. math.random(1, 4)})

            itemstack:take_item()
            return itemstack

        end,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_node("unilib:flower_fireweed_2", orig_name .. "_2", mode, {
        -- From elysflowers:fireweed_2. Creates unilib:flower_fireweed_2
        description = unilib.utils.annotate(S("Fireweed"), "Chamaenerion angustifolium"),
        tiles = {"unilib_flower_fireweed_2.png"},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_magenta = 1, colour_magenta = 1, flammable = 1, flora = 1,
            flower = 1, not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drop = full_name,
        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.25, -0.5, -0.25, 0.30, 1.0, 0.30},
        sunlight_propagates = true,
        visual_scale = 1.5,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    -- N.B. Not compatible with flowerpots, even in original code

    unilib.register_node("unilib:flower_fireweed_3", orig_name .. "_3", mode, {
        -- From elysflowers:fireweed_3. Creates unilib:flower_fireweed_3
        description = unilib.utils.annotate(S("Fireweed"), "Chamaenerion angustifolium"),
        tiles = {"unilib_flower_fireweed_3.png"},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_magenta = 1, colour_magenta = 1, flammable = 1, flora = 1,
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
    })
    -- N.B. Not compatible with flowerpots, even in original code

    unilib.register_node("unilib:flower_fireweed_4", orig_name .. "_4", mode, {
        -- From elysflowers:fireweed_4. Creates unilib:flower_fireweed_4
        description = unilib.utils.annotate(S("Fireweed"), "Chamaenerion angustifolium"),
        tiles = {"unilib_flower_fireweed_4.png"},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_magenta = 1, colour_magenta = 1, flammable = 1, flora = 1,
            flower = 1, not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drop = full_name,
        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.35, -0.5, -0.35, 0.35, 0.10, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    -- N.B. Not compatible with flowerpots, even in original code

    unilib.register_decoration_generic("elysflowers_flower_fireweed_1", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 2,
            offset = -0.031,
            persist = 0.6,
            scale = 0.240,
            seed = 17822,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 16,
    })
    unilib.register_decoration_generic("elysflowers_flower_fireweed_2", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = "unilib:flower_fireweed_2",

        noise_params = {
            octaves = 2,
            offset = -0.04,
            persist = 0.6,
            scale = 0.940,
            seed = 374142,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 16,
    })
    unilib.register_decoration_generic("elysflowers_flower_fireweed_3", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = "unilib:flower_fireweed_3",

        noise_params = {
            octaves = 1,
            offset = -0.09109,
            persist = 0.6,
            scale = 0.940,
            seed = 28912,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 16,
    })
    unilib.register_decoration_generic("elysflowers_flower_fireweed_4", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = "unilib:flower_fireweed_4",

        noise_params = {
            octaves = 1,
            offset = -0.1211,
            persist = 0.6,
            scale = 0.940,
            seed = 97822,
            spread = {x = 64, y = 64, z = 64},
        },
        rotation = "random",
        sidelen = 16,
    })

end
