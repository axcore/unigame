---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- kitz_drops.lua
--      Shared API functions from the petz/kitz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared helper functions (from petz/kitz/api/api_drops.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.drop_object(obj)

    -- Was kitz.drop_object()
    -- Drops an object (such as a pony's horseshoe) as an entity, if possible; otherwise just
    --      removes it from the world

    if obj then

        if obj:get_luaentity() then
            unimobs.kitz_api.set_drop_velocity(obj)
        else
            obj:remove()
        end

    end

end

function unimobs.kitz_api.set_drop_velocity(obj)

    -- Was kitz.drop_velocity()
    -- Sets the velocity of an entity being dropped by a mob (e.g. a pony's horseshoe)

    obj:set_velocity({
        x = random(-10, 10) / 9,
        y = 6,
        z = random(-10, 10) / 9,
    })

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/kitz/api/api_drops.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.make_mob_drop_single_item(self, itemstack)

    -- Was kitz.drop_item()
    -- Causes the mob (or player) to drop only one item, "itemstack"

    if not itemstack then
        return
    end

    local pos
    if type(self) == "table" then

        -- Entity
        pos = self.object:get_pos()

    else

        -- Player
        pos = self:get_pos()

    end

    local obj = core.add_item(pos, itemstack)
    unimobs.kitz_api.drop_object(obj)

end

function unimobs.kitz_api.make_mob_drop_multiple_items(self, killed_by_player_flag)

    -- Was kitz.drop_items()
    -- Called when the mob dies
    -- Causes the mob to drop one or more items, as specified by the entity's .drop_list field
    -- If "killed_by_player_flag" is true, the mob drops only rare items (self.drop_list.min = 0)
    --
    -- An example of a .drop_list field:
    --      drop_list = {
    --          {name = "unilib:food_lamb_chop_raw", chance = 1, min = 1, max = 1},
    --          {name = "unilib:item_bone_animal", chance = 5, min = 1, max = 1},
    --      },

    if not self.drop_list or #self.drop_list == 0 then
        return
    end

    -- Baby mobs don't drop anything (stop killing them, you monster!)
    if self.is_baby_flag then
        return
    end

    local obj, item, num
    local pos = self.object:get_pos()
    for n = 1, #self.drop_list do

        if random(1, self.drop_list[n].chance) == 1 then

            num = random(self.drop_list[n].min or 0, self.drop_list[n].max or 1)
            item = self.drop_list[n].name

            -- Only drop rare items (self.drop_list.min = 0) if killed by a player
            if killed_by_player_flag then
                obj = core.add_item(pos, ItemStack(item .. " " .. num))
            elseif self.drop_list[n].min ~= 0 then
                obj = core.add_item(pos, ItemStack(item .. " " .. num))
            end

            unimobs.kitz_api.drop_object(obj)

        end

    end

    -- Prevent the dead mob from dropping anything else
    self.drop_list = {}

end

function unimobs.kitz_api.make_node_drop_items(pos)

    -- Was kitz.node_drop_items()
    -- Causes the node at the specified "pos" to drop one or more items, as specified by the
    --      .drop_list field in the node's metadata
    -- Since nodes not created by unimobs probably don't define a .drop_list field, then only a few
    --      nodes are affected

    local meta = core.get_meta(pos)
    if not meta then
        return
    end

    local drop_list = core.deserialize(meta:get_string("drop_list"))
    if not drop_list or #drop_list == 0 then
        return
    end

    local obj, item, num
    for n = 1, #drop_list do

        if random(1, drop_list[n].chance) == 1 then

            num = random(drop_list[n].min or 0, drop_list[n].max or 1)
            item = drop_list[n].name
            if drop_list[n].min ~= 0 then
                obj = core.add_item(pos, ItemStack(item .. " " .. num))
            end

            unimobs.kitz_api.drop_object(obj)

        end

    end

end
