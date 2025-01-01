---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_earthbuild_degrade = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_earthbuild_degrade.init()

    return {
        description = "ABMs to degrade dirt-based building materials (from earthbuild)",
        notes = "Dirt-based building materials must be kept away from moisture/soil, therefore" ..
                " keep them off the ground, or keep them dry, or whitewash them",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.abm_earthbuild_degrade.post()

    -- N.B. Assume that only basic stairs have been created (all packages from earthbuild use
    --      .basic_flag = true, so that will be the case unless the code has been modified)
    -- The original code only accounted for simple stairs and slabs; here we have added inner/outer
    --      steps

    -- Fast ABM. Things that are already dirt-like decompose easily
    local node_list = {
        "unilib:dirt_compacted",
        "unilib:misc_straw_plastered_bale",
        "unilib:roof_thatch",
        "unilib:roof_thatch_stair_simple",
        "unilib:roof_thatch_stair_inner",
        "unilib:roof_thatch_stair_outer",
        "unilib:roof_thatch_stair_slab",
    }

    for full_name, data_table in pairs(unilib.global.dirt_with_turf_table) do

        local construction_name = "unilib:dirt_construction_with_" .. data_table.turf_part_name

        table.insert(node_list, construction_name)
        table.insert(node_list, construction_name .. "_stair_simple")
        table.insert(node_list, construction_name .. "_stair_inner")
        table.insert(node_list, construction_name .. "_stair_outer")
        table.insert(node_list, construction_name .. "_stair_slab")

    end

    unilib.register_abm({
        label = "Fast degradation of dirt-based building materials [abm_earthbuild_degrade]",
        nodenames = node_list,
        neighbors = {
            "group:soil",
            "group:water",
        },

        catch_up = false,
        chance = 250,
        interval = 180,

        action = function(pos, node)
            core.set_node(pos, {name = "unilib:dirt_ordinary"})
        end,
    })

    -- Medium-speed ABM. Harder to degrade, but no special resistance
    unilib.register_abm({
        label = "Medium degradation of dirt-based building materials [abm_earthbuild_degrade]",
        nodenames = {
            "unilib:material_cob",
            "unilib:material_cob_stair_simple",
            "unilib:material_cob_stair_inner",
            "unilib:material_cob_stair_outer",
            "unilib:material_cob_stair_slab",
            "unilib:material_cob_brick",
            "unilib:material_cob_brick_stair_simple",
            "unilib:material_cob_brick_stair_inner",
            "unilib:material_cob_brick_stair_outer",
            "unilib:material_cob_brick_stair_slab",
        },
        neighbors = {
            "group:soil",
            "group:water",
        },

        catch_up = false,
        chance = 500,
        interval = 360,

        action = function(pos, node)
            core.set_node(pos, {name = "unilib:dirt_ordinary"})
        end
    })

    -- Slow ABM. Resistant to degradation, or partly protected
    unilib.register_abm({
        label = "Slow degradation of dirt-based building materials [abm_earthbuild_degrade]",
        nodenames = {
            "unilib:dirt_rammed",
            "unilib:dirt_rammed_stair_simple",
            "unilib:dirt_rammed_stair_inner",
            "unilib:dirt_rammed_stair_outer",
            "unilib:dirt_rammed_stair_slab",
            "unilib:material_wattle_and_daub",
            "unilib:roof_dirt_with_wood_apple",
            "unilib:roof_dirt_with_wood_jungle",
            "unilib:roof_dirt_with_wood_pine",
            "unilib:roof_dirt_with_wood_acacia",
            "unilib:roof_dirt_with_wood_aspen",
            "unilib:roof_cob_with_wood_apple",
            "unilib:roof_cob_with_wood_jungle",
            "unilib:roof_cob_with_wood_pine",
            "unilib:roof_cob_with_wood_acacia",
            "unilib:roof_cob_with_wood_aspen"
        },
        neighbors = {
            "group:soil",
            "group:water",
        },

        catch_up = false,
        chance = 1000,
        interval = 720,

        action = function(pos, node)

            if node.name == "unilib:material_wattle_and_daub" then

                -- Daub falls off
                core.set_node(pos, {name = "unilib:material_wattle"})

            else

                -- Turn back to dirt
                core.set_node(pos, {name = "unilib:dirt_ordinary"})

            end

        end,
    })

end
