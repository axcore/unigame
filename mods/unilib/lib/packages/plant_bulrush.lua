---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_bulrush = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.dryplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_bulrush.init()

    return {
        description = "Bulrush",
        notes = "The plantlife modpack provided these nodes, which appear to have been intended" ..
                " to be used together as a single plant; but that functionality was never" ..
                " implemented. This package provides the nodes only, with no decorations. Note" ..
                " that GLEM provides two of its own schematics that can be used if you don't" ..
                " want to create your own. \"unilib_glem_plant_bulrush_1\") uses nodes from this" ..
                " package only; (e.g. \"unilib_glem_plant_bulrush_2\") includes nodes from the" ..
                " \"plant_reedmace\" package. Note also that the \"plant_reedmace\" package" ..
                " provides a way to grow new plants from saplings, but nothing like that is" ..
                " provided by this package",
    }

end

function unilib.pkg.plant_bulrush.exec()

    unilib.register_node("unilib:plant_bulrush_top", "dryplants:reedmace_spikes", mode, {
        -- From dryplants:reedmace_spikes
        description = S("Bulrush"),
        tiles = {"unilib_plant_bulrush_top.png"},
        -- N.B. attached_node = 1 not in original code
        groups = {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        -- N.B. Removed to make this plant independent of reedmace
--      drop = "unilib:plant_reedmace_sapling",
        drop = "unilib:plant_bulrush_top",
        inventory_image = "unilib_plant_bulrush_top.png",
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
        -- N.B. attached_node = 1 not in original code
        groups = {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        -- N.B. Removed to make this plant independent of reedmace
--      drop = "unilib:plant_reedmace_sapling",
        drop = "",
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

            local node = core.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
            if node.name == "unilib:plant_reedmace_small" or
                    node.name == "unilib:plant_reedmace_spikes" then

                core.dig_node({x = pos.x, y = pos.y + 1, z = pos.z})
                core.add_item(pos, "unilib:plant_reedmace_sapling")

            end

        end,
        ]]--
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:plant_bulrush_bottom", "dryplants:reedmace_bottom", mode, {
        -- From dryplants:reedmace_bottom
        description = S("Bulrush"),
        tiles = {"unilib_plant_bulrush_bottom.png"},
        -- N.B. attached_node = 1 not in original code
        groups = {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        -- N.B. Removed to make this plant independent of reedmace
--      drop = "unilib:plant_reedmace_sapling",
        drop = "",
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

            local node = core.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
            if node.name == "unilib:plant_reedmace_stem" or
                    node.name == "unilib:plant_reedmace_small" or
                    node.name == "unilib:plant_reedmace_spikes" then

                core.dig_node({x = pos.x, y = pos.y + 1, z = pos.z})
                core.add_item(pos, "unilib:plant_reedmace_sapling")

            end
        end,
        ]]--
    })
    -- (not compatible with flowerpots)

    -- N.B. This node is an alternative to "unilib:plant_bulrush_bottom" with a greener texture,
    --      perhaps suitable for use in watery biomes
    unilib.register_node("unilib:plant_bulrush_bottom_water", "dryplants:reedmace_water", mode, {
        -- From dryplants:reedmace_water
        description = unilib.utils.annotate(S("Bulrush"), "Typha"),
        tiles = {"unilib_plant_bulrush_bottom_water.png"},
        -- N.B. Only not_in_creative_inventory = 1 in original code. Added same groups as other
        --      similar items from the mod
        groups = {attached_node = 1, flammable = 2, not_in_creative_inventory = 1, snappy = 3},
        -- (no sounds)

        drawtype = "plantlike",
        -- N.B. Removed to make this plant independent of reedmace
        drop = "",
        inventory_image = "unilib_plant_bulrush_bottom_water.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
    })
    -- (not compatible with flowerpots)

end
