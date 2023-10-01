---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- hotbar.lua
--      Set up hotbar size. Code adapted from "dreambuilder_hotbar" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Set the hotbar size
---------------------------------------------------------------------------------------------------

-- Valid values are 1-32, or 0 for "don't interfere"
if unilib.hotbar_size > 0 then

    local base_img = "unilib_gui_hotbar_slot.png"
    -- The value 8 accounts for the stuff added in string.format() below
    local imgref_len = string.len(base_img) + 8

    local img_list = {}
    for i = 0, 31 do

        -- e.g. ":0000,0=unilib_hotbar_slot.png"
        img_list[i + 1] = string.format(":%04i,0=%s", i * 64, base_img)

    end

    local img_str = table.concat(img_list)

    minetest.register_on_joinplayer(function(player)

        minetest.after(0.5, function()

            player:hud_set_hotbar_itemcount(unilib.hotbar_size)
            player:hud_set_hotbar_image(
                "[combine:" .. (unilib.hotbar_size * 64) .. "x64" ..
                        string.sub(img_str, 1, unilib.hotbar_size * imgref_len)
            )

        end)

    end)

end
