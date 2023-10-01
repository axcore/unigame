---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.meta_moreplants_underground = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.meta_moreplants_underground.init()

    return {
        description = "Places plants underground",
        depends = {"stone_desert", "stone_ordinary"},
        at_least_one = {"flower_cave_pink", "mushroom_cave_blue", "mushroom_fire"}
    }

end

function unilib.pkg.meta_moreplants_underground.post()

    local frequency = 200

    minetest.register_on_generated(function(minp, maxp)

        if maxp.y > 0 then
            return
        end

        local stone_list = minetest.find_nodes_in_area_under_air(
            minp,
            maxp,
            {"unilib:stone_desert", "unilib:stone_ordinary"}
        )

        for n = 1, #stone_list do

            if math.random(1, frequency) == 1 then

                local pos = {x = stone_list[n].x, y = stone_list[n].y + 1, z = stone_list[n].z}
                if minetest.find_node_near(pos, 3, {"group:lava"}) then

                    minetest.add_node(pos, {name = "unilib:mushroom_fire"})

                elseif minetest.get_node_light(pos, nil) < 8 then

                    if minetest.find_node_near(pos, 3, {"group:water"}) then
                        minetest.add_node(pos, {name = "unilib:mushroom_cave_blue"})
                    else
                        minetest.add_node(pos, {name = "unilib:flower_cave_pink"})
                    end

                end

            end

        end

    end)

end
