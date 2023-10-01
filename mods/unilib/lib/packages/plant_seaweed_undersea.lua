---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_seaweed_undersea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_seaweed_undersea.init()

    return {
        description = "Undersea seaweed",
        notes = "Grows on undersea sand, and is edible",
        optional = "dye_basic",
    }

end

function unilib.pkg.plant_seaweed_undersea.exec()

    unilib.register_node("unilib:plant_seaweed_undersea", "ethereal:seaweed", mode, {
        -- From ethereal:seaweed
        description = S("Undersea Seaweed"),
        tiles = {"unilib_plant_seaweed_undersea.png"},
        groups = {flammable = 3, food_seaweed = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        climbable = true,
        drawtype = "plantlike",
        drowning = 1,
        inventory_image = "unilib_plant_seaweed_undersea.png",
        paramtype = "light",
        post_effect_color = {r = 100, g = 100, b = 200, a = 64},
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,
        wield_image = "unilib_plant_seaweed_undersea.png",

        after_dig_node = function(pos, node, metadata, digger)
            unilib.dig_up(pos, node, digger)
        end,

        on_use = unilib.cuisine_eat_on_use("unilib:plant_seaweed_undersea", 1),
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From ethereal:seaweed
            type = "shapeless",
            output = "unilib:dye_green_dark 3",
            recipe = {"unilib:plant_seaweed_undersea"}
        })

    end
    -- (not compatible with flowerpots)

end
