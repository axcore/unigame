---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_image.lua
--      Image utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._concat_img(base_img, overlay_img)

    -- Original to unilib
    -- Handle concatenating to images which might be a simple string, or a table with a .name field

    if type(base_img) == "string" then

        return base_img .. "^" .. overlay_img

    elseif base_img.name ~= nil then

        local return_table = unilib.utils.clone_simple_table(base_img)
        return_table.name = base_img.name .. "^" .. overlay_img
        return return_table

    else

        -- Failsafe
        return base_img

    end

end
