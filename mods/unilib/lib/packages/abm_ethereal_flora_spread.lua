---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_ethereal_flora_spread = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function flora_spread(pos, node)

    -- Adapted from ethereal-ng/dirt.lua
    -- ABM to handle flower spread, and also crystal/fire flower regeneration

    if (core.get_node_light(pos) or 0) < unilib.constant.light_min_grow_sapling then
        return
    end

    local pos0 = {x = pos.x - 4, y = pos.y - 2, z = pos.z - 4}
    local pos1 = {x = pos.x + 4, y = pos.y + 2, z = pos.z + 4}

    local num = #core.find_nodes_in_area(pos0, pos1, "group:flora")

    -- Stop flowers spreading too much just below top of map block
    if core.find_node_near(pos, 2, "ignore") then
        return
    end

    if num > 3 and node.name == "unilib:plant_shrub_crystal" then

        local grass = core.find_nodes_in_area_under_air(
            pos0,
            pos1,
            {"unilib:plant_shrub_crystal"}
        )

        if #grass > 4 and not core.find_node_near(pos, 4, {"unilib:mineral_crystallite_spike"}) then

            pos = grass[math.random(#grass)]
            pos.y = pos.y - 1

            if core.get_node(pos).name == "unilib:dirt_ordinary_with_turf_crystal" then

                pos.y = pos.y + 1
                core.swap_node(pos, {name = "unilib:mineral_crystallite_spike"})

            end

        end

        return

    elseif num > 3 and node.name == "unilib:plant_shrub_dry_fiery" then

        local grass = core.find_nodes_in_area_under_air(
            pos0,
            pos1,
            {"unilib:plant_shrub_dry_fiery"}
        )

        if #grass > 8 and not core.find_node_near(pos, 4, {"unilib:flower_fire"}) then

            pos = grass[math.random(#grass)]
            pos.y = pos.y - 1

            if core.get_node(pos).name == "ethereal:fiery_dirt" then

                pos.y = pos.y + 1
                core.swap_node(pos, {name = "unilib:dirt_ordinary_with_turf_fiery"})

            end

        end

        return

    elseif num > 3 then

        return

    end

    pos.y = pos.y - 1

    local under = core.get_node(pos)

    -- Make sure we have soil underneath
    if core.get_item_group(under.name, "soil") == 0 or under.name == "unilib:sand_desert" then
        return
    end

    local seedling = core.find_nodes_in_area_under_air(pos0, pos1, {under.name})
    if #seedling > 0 then

        pos = seedling[math.random(#seedling)]
        pos.y = pos.y + 1

        if (core.get_node_light(pos) or 0) < unilib.constant.light_min_grow_sapling then
            return
        end

        core.swap_node(pos, {name = node.name})

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_ethereal_flora_spread.init()

    return {
        description = "Replacement ABM from ethereal-ng, replacing the one specified by the" ..
                " \"abm_standard_flora_spread\" package",
        excludes = "abm_standard_flora_spread",
    }

end

function unilib.pkg.abm_ethereal_flora_spread.post()

    unilib.register_abm({
        -- From ethereal-ng/dirt.lua
        label = "Flora spread (for flowers and some grasses) [abm_ethereal_flora_spread]",
        nodenames = {"group:flora"},
        neighbors = {"group:soil"},

        chance = 96,
        interval = 13 / unilib.setting.abm_spread_factor,

        action = function(...)
            flora_spread(...)
        end,
    })

end
