---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- magnet_override_base.lua
--      Shared functions that can be overriden by other code. Code adapted from the "item_drop" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions (can be overriden by other code, if required)
---------------------------------------------------------------------------------------------------

function unilib.magnet.can_pickup(entity, player)

    -- This function is executed before picking up an item or making it fly to the player. If it
    --      does not return true, the item is ignored
    -- It is also executed before collecting the item after it flew to the player, if it did not
    --      reach them for magnet_time seconds

    if entity.item_drop_picked then

        -- Ignore items where picking has already failed
        return false

    else

        return true

    end

end

function unilib.magnet.before_collect(entity, pos, player)

    -- Executed before an item is collected by a player
    -- (no default code)

end

function unilib.magnet.after_collect(entity, pos, player)

    -- Executed before an item is collected by a player
    entity.item_drop_picked = true

end
