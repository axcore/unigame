---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_collisionbox.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_collisionbox.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.get_standard_collisionbox(p1, p2, scale_factor, baby_scale_factor)

    -- From petz.get_collisionbox(), .get_selectionbox() and .get_box()
    -- Returns two collisionboxes whose size has been multiplied by the specified factors, creating
    --      boxes that match both the adult and baby variants of a mob
    -- (The returned collisionboxes can also be used as selectionboxes, when required)

    p1 = vector.multiply(p1, scale_factor)
    p2 = vector.multiply(p2, scale_factor)

    -- N.B. The scale_factor and baby_scale_factor arguments are both optional
    local cbox
    if scale_factor then
        cbox = {p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, rotate = true}
    end

    local cbox_baby
    if baby_scale_factor then

        local p1b = vector.multiply(p1, baby_scale_factor)
        local p2b = vector.multiply(p2, baby_scale_factor)
        cbox_baby = {p1b.x, p1b.y, p1b.z, p2b.x, p2b.y, p2b.z, rotate = true}

    end

    return cbox, cbox_baby

end
