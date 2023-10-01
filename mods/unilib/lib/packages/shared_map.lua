---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    map
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_map = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function cyclic_update()

    -- Adapted from map/init.lua
    -- Cyclic update of HUD flags

    for _, player in ipairs(minetest.get_connected_players()) do
        unilib.pkg.shared_map.update_hud_flags(player)
    end

    minetest.after(5.3, cyclic_update)

end

local function do_update(player)

    -- Adapted from map/init.lua
    -- Update HUD flags

    local have_map_flag =
            player:get_inventory():contains_item("main", "unilib:item_kit_mapping") or
            player:get_inventory():contains_item("main", "unilib:item_satnav_analogue") or
            player:get_inventory():contains_item("main", "map:mapping_kit")
    local have_radar_flag =
            player:get_inventory():contains_item("main", "unilib:item_kit_radar") or
            player:get_inventory():contains_item("main", "unilib:item_satnav_digital") or
            player:get_inventory():contains_item("main", "unilib:item_quadcorder_digital") or
            player:get_inventory():contains_item("main", "minimap_radar:radar")

    local map_enabled_flag = unilib.is_creative(player) or have_map_flag or have_radar_flag
    local radar_enabled_flag = unilib.is_creative(player) or have_radar_flag

    player:hud_set_flags({
        minimap = map_enabled_flag,
        minimap_radar = radar_enabled_flag,
    })

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_map.update_hud_flags(player)
    do_update(player)
end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_map.init()

    return {
        description = "Shared functions for minimap and radar kits (from minetest_game/map)",
    }

end

function unilib.pkg.shared_map.exec()

    if minetest.get_modpath("map") then

        -- Override the minetest_game/map handling functions, so the function above can take over
        function map.update_hud_flags(player)
            do_update(player)
        end

    else

        -- No minetest_game/map functions available, so set up our own HUD update code
        minetest.register_on_joinplayer(function(player)
            do_update(player)
        end)

        minetest.after(5, cyclic_update)

    end

end
