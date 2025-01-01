---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_seaweed_undersea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_seaweed_undersea.init()

    return {
        description = "Undersea seaweed",
        notes = "Grows to a height of several blocks on undersea sand (because of code in the" ..
                " \"sand_undersea\" mod), and is edible. Can be placed on other types of sand," ..
                " but will not grow on them",
        optional = "dye_basic",
    }

end

function unilib.pkg.plant_seaweed_undersea.exec()

    unilib.register_node("unilib:plant_seaweed_undersea", "ethereal:seaweed", mode, {
        -- From ethereal:seaweed
        description = S("Undersea Seaweed"),
        tiles = {"unilib_plant_seaweed_undersea.png"},
        groups = {flammable = 2, food_seaweed = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        climbable = true,
        drawtype = "plantlike",
        drowning = 1,
        inventory_image = "unilib_plant_seaweed_undersea.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,
        wield_image = "unilib_plant_seaweed_undersea.png",

        -- N.B. Continue to use our standard unilib.misc.place_in_medium(), rather than using code
        --      from ethereal-ng's 2024 update
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "group:sand"}
            )

        end,

        after_dig_node = function(pos, node, metadata, digger)
            unilib.misc.dig_up(pos, node, digger)
        end,

        on_use = unilib.cuisine.eat_on_use("unilib:plant_seaweed_undersea", 1),
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From ethereal:seaweed
            type = "shapeless",
            output = "unilib:dye_green_dark 3",
            recipe = {"unilib:plant_seaweed_undersea"},
        })

    end
    -- (not compatible with flowerpots)

end
