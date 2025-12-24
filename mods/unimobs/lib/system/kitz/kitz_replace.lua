---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- kitz_replace.lua
--      Shared API functions from the petz/kitz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Local functions (from petz/kitz/api/api_replace.lua)
---------------------------------------------------------------------------------------------------

local function play_replace_sound(self, sound_name, max_hear_distance)

    -- Adapted from kitz.replace()

    unimobs.kitz_api.make_sound(
        "object",
        self.object,
        sound_name,
        max_hear_distance or unimobs.kitz_const.default_max_hear_distance
    )

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/kitz/api/api_replace.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.make_mob_replace_node(self, sound_name, max_hear_distance)

    -- Was kitz.replace()
    -- Causes the mob to replace one node with another (for example, causes it to "eat" turf,
    --      leaving behind a dirt node)
    -- The "sound_name" and "max_hear_distance" arguments are optional
    --
    -- Example mob properties, replacing grass with dirt:
    --
    --      .replace_data_list = {
    --          { OLD_NODE, NEW_NODE, Y_OFFSET },
    --          {"group:grass", "air", -1},
    --          {"default:dirt_with_grass", "default:dirt", -2}
    --      }
    --      .replace_rate = 10
    --      .replace_turf_flag = true
    --
    -- Note that even when .replace_turf_flag is true, we still list minetest_game nodes in
    --      .replace_data_list, when appropriate (for compatibility with worlds using minetest_game
    --      nodes instead of the unilib equivalents)

    if not self.replace_rate or
            not self.replace_data_list or
            #self.replace_data_list == 0 or
            self.is_baby_flag == true or
            self.object:get_velocity().y ~= 0 or
            random(1, self.replace_rate) > 1 then
        return false
    end

    -- Special case - replace unilib dirt-with-turf nodes
    if self.replace_turf_flag then

        local pos = self.object:get_pos()
        pos.y = pos.y + self.replace_turf_offset

        if #core.find_nodes_in_area(pos, pos, "group:soil") > 0 then

            local node = core.get_node(pos)
            local data_table = unilib.global.dirt_with_turf_table[node.name]
            if data_table then

                core.set_node(pos, {name = "unilib:" .. data_table.dirt_part_name})
                if sound_name then
                    play_replace_sound(self, sound_name, max_hear_distance)
                end

                return true

            end

        end

    end

    -- Default behaviour - replace only nodes specified by .replace_data_list
    local num, what, with, y_offset
    num = random(#self.replace_data_list)
    what = self.replace_data_list[num][1] or ""
    with = self.replace_data_list[num][2] or ""
    y_offset = self.replace_data_list[num][3] or 0

    local pos = self.object:get_pos()
    pos.y = pos.y + y_offset
    if #core.find_nodes_in_area(pos, pos, what) > 0 then

        core.set_node(pos, {name = with})
        if sound_name then
            play_replace_sound(self, sound_name, max_hear_distance)
        end

        return true

    else

        return false

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.refine_replace_data(entity_name)

    -- Original to unimobs
    -- Called from the .post() function of any mob packages which set their .replace_data_list
    --      property
    -- Refines the list to remove non-existent nodes

    local replace_data_list = core.registered_entities[entity_name]["replace_data_list"]
    if replace_data_list ~= nil then

        local new_list = {}
        -- mini_list in the form [ old_node, replacement_node, offset]
        for _, mini_list in ipairs(replace_data_list) do

            if (
                string.sub(mini_list[1], 1, 6) == "group:" or
                core.registered_nodes[mini_list[1]] ~= nil
            ) and (
                string.sub(mini_list[2], 1, 6) == "group:" or
                core.registered_nodes[mini_list[2]] ~= nil            
            ) then
                table.insert(new_list, mini_list)
            end

        end

        core.registered_entities[entity_name]["replace_data_list"] = new_list

    end

end
