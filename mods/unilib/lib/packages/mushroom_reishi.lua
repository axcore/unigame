---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_reishi = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_reishi.init()

    return {
        description = "Reishi mushroom",
        depends = {"shared_nsspf", "tree_jungle"},
    }

end

function unilib.pkg.mushroom_reishi.exec()

    unilib.register_node("unilib:mushroom_reishi", "nsspf:ganoderma_lucidum", mode, {
        -- From nsspf:ganoderma_lucidum
        description = unilib.utils.annotate(S("Reishi Mushroom"), "Ganoderma lucidum"),
        tiles = {"unilib_mushroom_reishi.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, flammable = 1, mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.global.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5},
        },
        drawtype = "mesh",
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_mushroom_reishi.png",
        -- N.B. This is not an error
        mesh = "unilib_plant_fungus_beefsteak.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine.eat_on_use("unilib:mushroom_reishi", 14),
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:mushroom_reishi_cooked", "nsspf:cooked_ganoderma_lucidum", mode, {
        -- From nsspf:cooked_ganoderma_lucidum
        description = S("Cooked Reishi Mushroom"),
        tiles = {"unilib_mushroom_reishi_cooked.png"},
        -- N.B. In original code, only snappy = 3
        groups = {attached_node = 1, food_mushroom = 1, snappy = 3},
        -- N.B. In original code, no sounds
        sounds = unilib.global.sound_table.leaves,

        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5},
        },
        drawtype = "mesh",
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_mushroom_reishi_cooked.png",
        mesh = "unilib_plant_fungus_beefsteak.b3d",
        paramtype = "light",
        -- N.B. In original code, "facedir"
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.1, -0.5, 0.5, 0.1, 0.5},
        },

        on_place = function(itemstack, placer, pointed_thing)
            return
        end,

        on_use = unilib.cuisine.eat_on_use("unilib:mushroom_reishi_cooked", 4),
    })
    unilib.register_craft({
        -- From nsspf:cooked_ganoderma_lucidum
        type = "cooking",
        output = "unilib:mushroom_reishi_cooked",
        recipe = "unilib:mushroom_reishi",
        cooktime = 10,
    })

    unilib.pkg.shared_nsspf.register_mushroom({
        -- Code original to unilib, replacing an ABM in the original code
        wall_name = "unilib:tree_jungle_trunk",
        plant_name = "unilib:mushroom_reishi",

        surface_list = {"unilib:dirt_ordinary_with_litter_rainforest"},
    })

end
