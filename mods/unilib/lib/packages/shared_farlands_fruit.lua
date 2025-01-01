---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_farlands_fruit = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_farlands_fruit.create_fruit_nodes(part_name, group)

    -- Create fruit-as-node variants for the craftitems already created by the calling package, as
    --      described below

    local node_full_name = "unilib:fruit_" .. part_name .. "_exotic_node"
    local craftitem_full_name = "unilib:fruit_" .. part_name .. "_exotic"
    local craftitem_def_table = core.registered_craftitems[craftitem_full_name]
    if craftitem_full_name == nil then
        return
    end

    local img = craftitem_def_table.inventory_image

    local group_table = {
        dig_immediate = 3, leafdecay = 3, leafdecay_drop = 1, not_in_creative_inventory = 1,
        oddly_breakable_by_hand = 1, snappy = 1,
    }
    if group ~= nil then
        group_table[group] = 1
    end

    unilib.register_node(node_full_name, nil, mode, {
        -- Original to unilib, attempting to resemble the code for unilib:fruit_apple_exotic
        description = craftitem_def_table.description,
        tiles = {img},
        groups = group_table,
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = craftitem_full_name,
        inventory_image = img,
        is_ground_content = false,
        paramtype = "light",
        wield_image = img,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_farlands_fruit.init()

    return {
        description = "Shared functions for fruit node variants (from farlands)",
        notes = "The original farlands code uses ore distributions to place leaves-with-fruit" ..
                " nodes on certain trees. This use of ore distributions does not work well on" ..
                " modern Minetest, so the \"abm_farlands_bushes_trees\" package, when loaded," ..
                " replaces the ores with a simple ABM. Both methods use leaves-with-fruit nodes" ..
                " that drop fruit (as craftitems) when dug. This package offers a third method," ..
                " creating fruit in the form of nodes. The fruit-as-nodes can be placed" ..
                " directly into a schematic, but still drop the fruit-as-craftitems when dug." ..
                " If you use any such schematic, then your remix should not include the" ..
                " \"abm_farlands_bushes_trees\" package, otherwise your trees will contain" ..
                " both fruit-as-nodes and (eventually) leaves-with-fruit. Note that some" ..
                " GLEM schematics for exotic palm trees require fruit-as-nodes, so if you use" ..
                " those schematics, your remix should include this package",
    }

end

