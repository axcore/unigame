---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    airtanks
-- Code:    MIT
-- Media:   MIT/CC0/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_tube_breathing = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.airtanks.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function can_use_any_airtank(player)

    -- Was use_any_airtank()

    local inv = player:get_inventory()
    local inv_list = "main"

    for i = 1, player:hud_get_hotbar_itemcount() do

        local itemstack = inv:get_stack(inv_list, i)
        if core.get_item_group(itemstack:get_name(), "airtank") > 1 then

            itemstack = unilib.pkg.shared_airtanks.use_tank(itemstack, player)
            inv:set_stack(inv_list, i, itemstack)
            return true

        end

    end

    return false

end

local function is_tool_active(player, item)

    -- Was tool_active()

    local inv = player:get_inventory()
    local inv_list = "main"

    for i = 1, player:hud_get_hotbar_itemcount() do

        if inv:get_stack(inv_list, i):get_name() == item then
            return true
        end

    end

    return false

end

local function player_event_handler(player, eventname)

    if player:is_player() and
            eventname == "breath_changed" and
            player:get_breath() < 5 and
            is_tool_active(player, "unilib:device_tube_breathing") and
            not can_use_any_airtank(player) then
        core.sound_play("unilib_device_tube_breathing", {pos = player:get_pos(), gain = 0.5})
    end

    return false

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_tube_breathing.init()

    return {
        description = "Breathing tube",
        notes = "Used with airtanks. When in the player's hotbar, the player automatically" ..
                " breathes when their breath bar is below 50%",
        optional = "material_plastic",
    }

end

function unilib.pkg.device_tube_breathing.exec()

    unilib.register_craftitem("unilib:device_tube_breathing", "airtanks:breathing_tube", mode, {
        -- From airtanks:breathing_tube
        description = unilib.utils.hint(S("Breathing Tube"), S("used with air tanks")),
        inventory_image = "unilib_device_tube_breathing.png",
        -- (no groups)

        wield_image = "unilib_device_tube_breathing.png",
    })
    if unilib.global.pkg_executed_table["material_plastic"] == nil then

        unilib.register_craft({
            -- From airtanks:breathing_tube
            output = "unilib:device_tube_breathing",
            recipe = {
                {"", "group:stick", ""},
                {"", "group:stick", ""},
                {"group:wood", "group:stick", ""},
            },
        })

    else

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:device_tube_breathing",
            recipe = {
                {"", "unilib:material_plastic_strip", ""},
                {"", "unilib:material_plastic_strip", ""},
                {"group:wood", "group:stick", ""},
            },
        })

    end

    -- N.B. Undocumented API function
    core.register_playerevent(player_event_handler)

end
