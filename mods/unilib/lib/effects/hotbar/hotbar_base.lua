---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- hotbar_base.lua
--      Set the hotbar size for each player. Code adapted from "dreambuilder_hotbar" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Values, set below, used to change the hotbar size when required
local img_str, imgref_len
-- The default value of the hotbar size on startup; set when the first player joins
local default_size = nil

---------------------------------------------------------------------------------------------------
-- Set the hotbar size
---------------------------------------------------------------------------------------------------

function unilib.hotbar.set_size(player, size)

    -- If no size is specified, then use the default one, as described below
    if size == nil then
        size = default_size
    end

    player:hud_set_hotbar_itemcount(size)
    player:hud_set_hotbar_image(
        "[combine:" .. (size * 64) .. "x64" ..
                string.sub(img_str, 1, size * imgref_len)
    )

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

local base_img = "unilib_gui_hotbar_slot.png"
-- The value 8 accounts for the stuff added in string.format() below
imgref_len = string.len(base_img) + 8

local img_list = {}
for i = 0, 31 do

    -- e.g. ":0000,0=unilib_hotbar_slot.png"
    img_list[i + 1] = string.format(":%04i,0=%s", i * 64, base_img)

end

img_str = table.concat(img_list)

core.register_on_joinplayer(function(player)

    core.after(0.5, function()

        -- The "default" hotbar size is the one returned by Minetest when the first player joins
        if default_size == nil then
            default_size = player:hud_get_hotbar_itemcount()
        end

        -- Change the visible size if player attributes (set with the /set_hotbar and
        --      /reset_hotbar commands) require it, or if the global Minetest setting requires it
        local size = unilib.utils.get_player_attribute(player, "hotbar_size")
        if size ~= "" then
            unilib.hotbar.set_size(player, tonumber(size))
        elseif unilib.setting.hotbar_size > 0 then
            unilib.hotbar.set_size(player, unilib.setting.hotbar_size)
        end

    end)

end)
