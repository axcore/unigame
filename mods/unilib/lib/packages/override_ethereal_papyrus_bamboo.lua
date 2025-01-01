---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_ethereal_papyrus_bamboo = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function grow_papyrus(pos, node)

    -- Adapted from ethereal-ng/dirt.lua
    -- ABM to grow papyrus up to 4 nodes high, and bamboo trees up to 8 nodes high

    local oripos = pos.y
    local high = 4

    pos.y = pos.y - 1

    local nod = core.get_node_or_nil(pos)

    if not nod or
            core.get_item_group(nod.name, "soil") < 1 or
            core.find_node_near(pos, 3, {"group:water"}) == nil then
        return
    end

    if node.name == "unilib:tree_bamboo_trunk" then
        high = 8
    end

    pos.y = pos.y + 1

    local height = 0
    while height < high and core.get_node(pos).name == node.name do

        height = height + 1
        pos.y = pos.y + 1

    end

    nod = core.get_node_or_nil(pos)

    if nod and nod.name == "air" and height < high then

        if node.name == "unilib:tree_bamboo_trunk" and height == (high - 1) then
            ethereal.grow_bamboo_tree({x = pos.x, y = oripos, z = pos.z})
        else
            core.swap_node(pos, {name = node.name})
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_ethereal_papyrus_bamboo.init()

    return {
        description = "Override ABMs that handle spread of ordinary papyrus with a new action",
        at_least_one = {"plant_papyrus_ordinary", "tree_bamboo"},
    }

end

function unilib.pkg.override_ethereal_papyrus_bamboo.post()

    -- Loop through active ABMs, looking for the one created by the "plant_papyrus_ordinary" package
    -- Modify it to handle bamboo trees as well
    for _, abm_def in pairs(core.registered_abms) do

        local label = abm_def.label or ""
        local node = abm_def.nodenames and abm_def.nodenames[1] or ""

        -- unilib ABM .label field
        if label == "Ordinary papyrus growth [plant_papyrus_ordinary]" or
                -- Original minetest_game/default label
                label == "Grow papyrus" or
                -- Failsafe
                node == "unilib:plant_papyrus_ordinary" then

            abm_def.nodenames = {"unilib:plant_papyrus_ordinary", "unilib:tree_bamboo_trunk"}
            abm_def.neighbors = {"group:soil"}

            abm_def.action = grow_papyrus

        end

    end

end
