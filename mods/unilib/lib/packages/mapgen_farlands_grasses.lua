---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.mapgen_farlands_grasses = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mapgen_farlands_grasses.init()

    return {
        description = "Mapgen operations for the farlands game. Removes farlands grasses from" ..
                " above dirty water. This package should be added to your remixes only if you" ..
                " *really* want to emulate the original farlands environment",
        depends = "liquid_water_dirty",
        at_least_one = {"flower_lavender", "grass_giant", "grass_swamp"},
    }

end

function unilib.pkg.mapgen_farlands_grasses.post()

    -- N.B. Due to lack of testing time, it's not at all clear that this code actually removes
    --      anything, given the improbability of grasses spawning above water
    core.register_on_generated(function(minp, maxp)

        if maxp.y < -20 or maxp.y > 1000 then
            return
        end

        local posn_list = core.find_nodes_in_area(minp, maxp, {"unilib:liquid_water_dirty_source"})
        for n = 1, #posn_list do

            local pos = {x = posn_list[n].x, y = posn_list[n].y, z = posn_list[n].z }
            local name = core.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name

            if name == "unilib:flower_lavender" or
                    name == "unilib:grass_swamp_1" or
                    name == "unilib:grass_giant" or
                    name == "unilib:grass_swamp_2" or
                    name == "unilib:grass_swamp_3" or
                    name == "unilib:grass_swamp_4" or
                    name == "unilib:grass_swamp_5" then
                core.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
            end

        end

    end)

end
