---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kelp_giant = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_kelp_giant.init()

    return {
        description = "Giant kelp",
        notes = "Giant kelp is edible",
        depends = "stone_ordinary_with_kelp",
        at_least_one = "liquid_water_ordinary",
    }

end

function unilib.pkg.plant_kelp_giant.exec()

    unilib.register_node("unilib:plant_kelp_giant", "australia:kelp_giant_brown", mode, {
        -- From australia:kelp_giant_brown
        description = unilib.annotate(S("Giant Kelp"), "Macrocystis pyrifera"),
        tiles = {"unilib_plant_kelp_giant.png"},
        -- N.B. no food_kelp in original code
        groups = {food_kelp = 1, sea = 1, seaplants = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        climbable = true,
        drawtype = "plantlike",
        drowning = 1,
        inventory_image = "unilib_plant_kelp_giant.png",
        paramtype = "light",
        post_effect_color = {r = 100, g = 100, b = 200, a = 64},
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3},
        },
        walkable = false,
        wield_image = "unilib_plant_kelp_giant.png",

        on_use = unilib.cuisine_eat_on_use("unilib:plant_kelp_giant", 1),
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From australia:kelp_giant_brown_middle
        "unilib:plant_kelp_giant_middle",
        "australia:kelp_giant_brown_middle",
        mode,
        {
            description = unilib.annotate(S("Giant Kelp"), "Macrocystis pyrifera"),
            tiles = {"unilib_plant_kelp_giant_middle.png"},
            -- N.B. "not_in_creative_inventory" not used in original code
            groups = {not_in_creative_inventory = 1, sea = 1, seaplants = 1, snappy = 3},
            sounds = unilib.sound_table.leaves,

            climbable = true,
            drawtype = "plantlike",
            drop = "unilib:plant_kelp_giant",
            drowning = 1,
            inventory_image = "unilib_plant_kelp_giant_middle.png",
            paramtype = "light",
            post_effect_color = {r = 100, g = 100, b = 200, a = 64},
            selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
            },
            walkable = false,
            wield_image = "unilib_plant_kelp_giant_middle.png",
        }
    )
    -- (not compatible with flowerpots)

    -- (Spawn on suitable stone)
    unilib.register_abm({
        -- From australia:kelp_giant_brown
        label = "Spawn kelp [plant_kelp_giant]",
        nodenames = {"unilib:stone_ordinary_with_kelp_giant"},

        chance = 10,
        interval = 12,

        action = function(pos)

            local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
            if minetest.get_node(yp).name == "unilib:liquid_water_ordinary_source" then

                pos.y = pos.y + 1
                minetest.add_node(pos, {name = "unilib:plant_kelp_giant"}) else
                return

            end

        end
    })

    -- (Once spawned, grow vertically)
    unilib.register_abm({
        -- From australia:kelp_giant_brown
        label = "Kelp growth [plant_kelp_giant]",
        nodenames = {"unilib:plant_kelp_giant"},

        chance = 3,
        interval = 6,

        action = function(pos)

            local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
            local yyp = {x = pos.x, y = pos.y + 2, z = pos.z}
            local yyyp = {x = pos.x, y = pos.y + 3, z = pos.z}

            if minetest.get_node(pos).name == "unilib:plant_kelp_giant" and
                    minetest.get_node(yp).name == "unilib:liquid_water_ordinary_source" and
                    minetest.get_node(yyp).name == "unilib:liquid_water_ordinary_source" then

                if minetest.get_node(yyyp).name == "unilib:liquid_water_ordinary_source" then

                    minetest.add_node(pos, {name = "unilib:plant_kelp_giant_middle"})
                    pos.y = pos.y + 1
                    minetest.add_node(pos, {name = "unilib:plant_kelp_giant"})

                else

                    return

                end

            end

        end,
    })

end
