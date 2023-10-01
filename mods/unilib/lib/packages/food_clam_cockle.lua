---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.food_clam_cockle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_clam_cockle.init()

    return {
        description = "Cockle",
        notes = "Can be dug from antipodean mud with cockles, and also reburied with it",
    }

end

function unilib.pkg.food_clam_cockle.exec()

    unilib.register_node("unilib:food_clam_cockle", "aotearoa:cockle", mode, {
        -- From aotearoa:cockle
        description = unilib.annotate(S("Cockle"), "Austrovenus stutchburyi"),
        tiles = {"unilib_food_clam_cockle.png"},
        -- N.B. no food_clam in original code
        groups = {dig_immediate = 3, fleshy = 3, food_clam = 1},
        sounds = unilib.sound_table.gravel,

        drawtype = "plantlike",
        inventory_image = "unilib_food_clam_cockle.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.2, 0.1},
        },
        sunlight_propagates = true,
        visual_scale = 0.6,
        walkable = false,

        on_construct = function(pos)
            minetest.get_node_timer(pos):start(math.random(3, 5))
        end,

        on_timer = function(pos)

            -- Re-bury cockles
            local below = {x = pos.x, y = pos.y - 1, z = pos.z}
            if minetest.get_node(below).name == "unilib:dirt_mud_antipodean_dry" then

                minetest.set_node(pos, {name = "air"})
                minetest.set_node(below, {name = "unilib:dirt_mud_antipodean_with_cockles"})

            end

        end,

        on_use = unilib.cuisine_eat_on_use("unilib:food_clam_cockle", 1),
    })

end
