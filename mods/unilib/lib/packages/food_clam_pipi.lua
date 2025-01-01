---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.food_clam_pipi = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_clam_pipi.init()

    return {
        description = "Pipi",
        notes = "Can be dug from various sands, and also reburied with them",
    }

end

function unilib.pkg.food_clam_pipi.exec()

    unilib.register_node("unilib:food_clam_pipi", "aotearoa:pipi", mode, {
        -- From aotearoa:pipi
        description = unilib.utils.annotate(S("Pipi"), "Paphies australis"),
        tiles = {"unilib_food_clam_pipi.png"},
        -- N.B. no food_clam in original code
        groups = {dig_immediate = 3, fleshy = 3, food_clam = 1},
        sounds = unilib.global.sound_table.gravel,

        drawtype = "plantlike",
        inventory_image = "unilib_food_clam_pipi.png",
        -- N.B. is_ground_content = false not in original code; added to match other food items
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, -0.2, 0.1},
        },
        sunlight_propagates = true,
        visual_scale = 0.6,
        walkable = false,

        on_construct = function(pos)
            core.get_node_timer(pos):start(math.random(3, 5))
        end,

        on_timer = function(pos)

            -- Re-bury pipi
            local below = {x = pos.x, y = pos.y - 1, z = pos.z}

            if core.get_node(below).name == "unilib:sand_ordinary" then

                core.set_node(pos, {name = "air"})
                core.set_node(below, {name = "unilib:sand_ordinary_with_pipi"})

            elseif core.get_node(below).name == "unilib:sand_ironsand" then

                core.set_node(pos, {name = "air"})
                core.set_node(below, {name = "unilib:sand_ironsand_with_pipi"})

            end

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:food_clam_pipi", 1),
    })

end
