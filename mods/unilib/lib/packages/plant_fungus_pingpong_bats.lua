---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_fungus_pingpong_bats = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_fungus_pingpong_bats.init()

    return {
        description = "Little ping-pong bats fungus",
        depends = {"shared_nsspf", "tree_apple"},
    }

end

function unilib.pkg.plant_fungus_pingpong_bats.exec()

    unilib.register_node("unilib:plant_fungus_pingpong_bats", "nsspf:panellus_pusillus", mode, {
        -- From nsspf:panellus_pusillus
        description = unilib.utils.annotate(S("Little Ping-Pong Bats Fungus"), "Panellus pusillus"),
        tiles = {"unilib_plant_fungus_pingpong_bats.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.global.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
        },
        drawtype = "mesh",
        mesh = "unilib_plant_fungus_pingpong_bats.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_pingpong_bats", -2),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From nsspf:cooked_panellus_pusillus
        "unilib:plant_fungus_pingpong_bats_cooked",
        "nsspf:cooked_panellus_pusillus",
        mode,
        {
            description = S("Cooked Little Ping-Pong Bats Fungus"),
            tiles = {"unilib_plant_fungus_pingpong_bats_cooked.png"},
            -- N.B. In original code, only snappy = 3
            groups = {attached_node = 1, snappy = 3},
            -- N.B. In original code, no sounds
            sounds = unilib.global.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
            },
            drawtype = "mesh",
            mesh = "unilib_plant_fungus_pingpong_bats.b3d",
            paramtype = "light",
            -- N.B. In original code, "facedir"
            paramtype2 = "wallmounted",
            selection_box = {
                type = "fixed",
                fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
            },

            on_place = function(itemstack, placer, pointed_thing)
                return
            end,

            on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_pingpong_bats_cooked", -4),
        }
    )
    unilib.register_craft({
        -- From nsspf:cooked_panellus_pusillus
        type = "cooking",
        output = "unilib:plant_fungus_pingpong_bats_cooked",
        recipe = "unilib:plant_fungus_pingpong_bats",
        cooktime = 10,
    })

    unilib.register_node(
        -- From nsspf:panellus_pusillus_light
        "unilib:plant_fungus_pingpong_bats_glowing",
        "nsspf:panellus_pusillus_light",
        mode,
        {
            description = unilib.utils.annotate(
                S("Glowing Little Ping-Pong Bats Fungus"), "Panellus pusillus"
            ),
            tiles = {"unilib_plant_fungus_pingpong_bats_glowing.png"},
            -- N.B. In original code, only not_in_creative_inventory = 1, snappy = 3
            groups = {
                attached_node = 1, flammable = 1, flora = 1, not_in_creative_inventory = 1,
                snappy = 3,
            },
            -- N.B. In original code, no sounds
            sounds = unilib.global.sound_table.leaves,

            collision_box = {
                type = "fixed",
                fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
            },
            drawtype = "mesh",
            drop = "unilib:plant_fungus_pingpong_bats",
            light_source = 8,
            mesh = "unilib_plant_fungus_pingpong_bats.b3d",
            paramtype = "light",
            -- N.B. In original code, "facedir"
            paramtype2 = "wallmounted",
            selection_box = {
                type = "fixed",
                fixed = {-0.2, -0.4, 0.2, 0.2, 0.4, 0.5},
            },

            on_place = function(itemstack, placer, pointed_thing)
                return
            end,

            on_use = unilib.cuisine.eat_on_use("unilib:plant_fungus_pingpong_bats_glowing", -2),
        }
    )

    unilib.pkg.shared_nsspf.register_fungus({
        -- Code original to unilib, replacing an ABM in the original code
        wall_name = "unilib:tree_apple_trunk",
        plant_name = "unilib:plant_fungus_pingpong_bats",

        surface_list = {"unilib:dirt_ordinary_with_turf"},
    })

    -- (This fungus glows at night)
    unilib.pkg.shared_nsspf.register_glowing("unilib:plant_fungus_pingpong_bats")

end
