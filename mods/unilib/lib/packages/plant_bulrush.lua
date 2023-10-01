---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_bulrush = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.dryplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_bulrush.init()

    return {
        description = "Bulrush",
        notes = "These items existed in the plantlife modpack, but were not placed in the world." ..
                " Therefore, unlike code in the \"plant_reedmace\" package, there are no" ..
                " schematics and there is no growth from ABMs; that functionality must be" ..
                " provided by other packages, if required",
    }

end

function unilib.pkg.plant_bulrush.exec()

    unilib.register_node("unilib:plant_bulrush_water", "dryplants:reedmace_water", mode, {
        -- From dryplants:reedmace_water
        description = unilib.annotate(S("Bulrush"), "Typha"),
        tiles = {"unilib_plant_bulrush_water.png"},
        -- N.B. Only not_in_creative_inventory = 1 in original code. Added same groups as other
        --      similar items from the mod
        groups = {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_plant_bulrush_water.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:plant_bulrush_spiked", "dryplants:reedmace_spikes", mode, {
        -- From dryplants:reedmace_spikes
        description = S("Bulrush"),
        tiles = {"unilib_plant_bulrush_spiked.png"},
        groups = {flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        -- N.B. Removed to make this plant independent of reedmace
--      drop = "unilib:plant_reedmace_sapling",
        inventory_image = "unilib_plant_bulrush_spiked.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:plant_bulrush_stem", "dryplants:reedmace", mode, {
        -- From dryplants:reedmace
        description = S("Bulrush"),
        tiles = {"unilib_plant_bulrush_stem.png"},
        groups = {flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        -- N.B. Removed to make this plant independent of reedmace
--      drop = "unilib:plant_reedmace_sapling",
        inventory_image = "unilib_plant_bulrush_stem.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,

        -- N.B. Removed to make this plant independent of reedmace
        --[[
        after_destruct = function(pos, oldnode)

            local node = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
            if node.name == "unilib:plant_reedmace_small" or
                    node.name == "unilib:plant_reedmace_spikes" then

                minetest.dig_node({x = pos.x, y = pos.y + 1, z = pos.z})
                minetest.add_item(pos, "unilib:plant_reedmace_sapling")

            end

        end,
        ]]--
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:plant_bulrush_bottom", "dryplants:reedmace_bottom", mode, {
        -- From dryplants:reedmace_bottom
        description = S("Bulrush"),
        tiles = {"unilib_plant_bulrush_bottom.png"},
        groups = {flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        -- N.B. Removed to make this plant independent of reedmace
--      drop = "unilib:plant_reedmace_sapling",
        inventory_image = "unilib_plant_bulrush_bottom.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
        },
        walkable = false,

        -- N.B. Removed to make this plant independent of reedmace
        --[[
        after_destruct = function(pos, oldnode)

            local node = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
            if node.name == "unilib:plant_reedmace_stem" or
                    node.name == "unilib:plant_reedmace_small" or
                    node.name == "unilib:plant_reedmace_spikes" then

                minetest.dig_node({x = pos.x, y = pos.y + 1, z = pos.z})
                minetest.add_item(pos, "unilib:plant_reedmace_sapling")

            end
        end,
        ]]--
    })
    -- (not compatible with flowerpots)

end
