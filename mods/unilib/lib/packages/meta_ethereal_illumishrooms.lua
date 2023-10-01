---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.meta_ethereal_illumishrooms = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_ethereal_illumishrooms.init()

    return {
        description = "Places illumishrooms in caves on top of coal",
        depends = "stone_ordinary_with_coal",
        at_least_one = {
            "mushroom_illumishroom_cyan",
            "mushroom_illumishroom_green",
            "mushroom_illumishroom_red",
        },
    }

end

function unilib.pkg.meta_ethereal_illumishrooms.post()

    minetest.register_on_generated(function(minp, maxp)

        if minp.y > -30 or maxp.y < -3000 then
            return
        end

        local bpos
        local coal = minetest.find_nodes_in_area_under_air(
            minp,
            maxp,
            "unilib:stone_ordinary_with_coal"
        )

        for n = 1, #coal do

            if math.random(2) == 1 then

                bpos = {x = coal[n].x, y = coal[n].y + 1, z = coal[n].z}

                if bpos.y > -1000 and bpos.y < -30 then
                    minetest.swap_node(bpos, {name = "unilib:mushroom_illumishroom_red"})
                elseif bpos.y > -2000 and bpos.y < -1000 then
                    minetest.swap_node(bpos, {name = "unilib:mushroom_illumishroom_green"})
                elseif bpos.y > -3000 and bpos.y < -2000 then
                    minetest.swap_node(bpos, {name = "unilib:mushroom_illumishroom_cyan"})
                end

            end

        end

    end)

end
