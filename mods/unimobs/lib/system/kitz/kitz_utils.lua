---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- kitz_utils.lua
--      Shared API functions from the petz/kitz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local max = math.max
local min = math.min
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared API functions (files) (from petz/kitz/api/api_helper_functions.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.does_file_exist(path)

    -- Was kitz.file_exists()
    -- Returns true if the specified filepath exists, false if not

    local f = io.open(path, "r")
    if f ~= nil then

        io.close(f)
        return true

    else

        return false

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (general) (from petz/kitz/api/api_helper_functions.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.register_discovered_item(player, mob_type, discovery_type, full_name)

    -- Original to unimobs
    -- The main formspec for mobs displays the item(s) used for repelling/following/feeding/
    --      breeding/capturing
    -- However, if unimobs.petz_setting.conceal_unused_items_flag is true, the items are concealed
    --      (not visible) unless they've actually been used by the player for that purpose
    -- When repelling/following/feeding/breeding/capturing occurs, this function should be called to
    --      register the items used in the player's metadata
    -- Note that discoveries are only stored when unimobs.petz_setting.conceal_unused_items_flag is
    --      true, and when the player is in survival mode
    --
    -- "discovery_type" should be one of the strings "repel", "follow", "feed", "breed", "capture"
    -- "full_name" is the full name of the item, e.g. "unilib:crop_wheat_harvest"

    if unilib.utils.is_creative(player:get_player_name()) or
            not unimobs.petz_setting.conceal_unused_items_flag then
        return
    end

    local discovery_table =
            core.deserialize(unilib.utils.get_player_attribute(player, "kitz_discovery_table"))
    if discovery_table == nil or discovery_table == "" then
        discovery_table = {}
    end

    -- Table in the form
    --      discovery_table[mob_type][discovery_type] = mini_table
    -- ...where "mini_table" has one or more discovered items as keys
    if discovery_table[mob_type] == nil then
        discovery_table[mob_type] = {}
    end

    if discovery_table[mob_type][discovery_type] == nil then
        discovery_table[mob_type][discovery_type] = {}
    end

    discovery_table[mob_type][discovery_type][full_name] = true

    unilib.utils.set_player_attribute(
        player, "kitz_discovery_table", core.serialize(discovery_table)
    )

end

function unimobs.kitz_api.remove_mob(self)

    -- Was kitz.remove_mob()
    -- Clears the mob's high-level and low-level behaviour lists, before removing it from the world

    unimobs.mobkit_api.clear_both_queues(self)
    self.object:remove()

end

function unimobs.kitz_api.retrieve_discovered_item(player, mob_type, discovery_type, item_list)

    -- Original to unimobs
    -- A convenience function for retrieving the data, stored as player metadata, in calls to
    --      unimobs.kitz_api.register_discovered_item()
    -- Note that discoveries are only stored when unimobs.petz_setting.conceal_unused_items_flag is
    --      true, and when the player is in survival mode. Before calling this function, it's up to
    --      the calling code to check both of those conditions
    --
    -- "item_list" can be a single item (e.g. "unilib:crop_wheat_harvest") or a list of items
    -- Returns the first item in that list which has been stored as a discovery, or nil if none of
    --      the items have been stored as discoveries

    -- (Convert strings to a list of one item)
    item_list = unilib.utils.convert_to_list(item_list)

    -- Retrieve player metadata
    local discovery_table =
            core.deserialize(unilib.utils.get_player_attribute(player, "kitz_discovery_table"))

    -- Look up the item(s)
    if discovery_table == nil or
            discovery_table == "" or
            discovery_table[mob_type] == nil or
            discovery_table[mob_type][discovery_type] == nil then
        return nil
    end

    for _, full_name in ipairs(item_list) do

        if discovery_table[mob_type][discovery_type][full_name] ~= nil then
            return full_name
        end

    end

    return nil

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (inventory cubes) (from petz/kitz/api/api_helper_functions.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.create_inv_cube(tile_list)

    -- Was kitz.create_inv_cube()
    -- Returns an inventory cube composed of the specified textures, for use in formspecs

    if not tile_list then
        return
    end

    local inv_cube = "[inventorycube"
    local tile_top, tile_left, tile_right
    tile_top = tile_list[1]
    if unimobs.kitz_api.is_table(tile_top) then
        tile_top = tile_top.name
    end

    if tile_list[3] then

        tile_right = tile_list[3]
        if unimobs.kitz_api.is_table(tile_right) then
            tile_right = tile_right.name
        end

    else

        tile_right = tile_top

    end

    if tile_list[6] then

        tile_left = tile_list[6]
        if unimobs.kitz_api.is_table(tile_left) then
            tile_left = tile_left.name
        end

    else

        tile_left = tile_top

    end

    inv_cube = inv_cube .. "{" .. tile_top .. "{" .. tile_left .. "{" .. tile_right
    return inv_cube

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (maths) (from petz/kitz/api/api_helper_functions.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.clamp_value_in_range(val, low, high)

    -- Was kitz.math.clamp()
    -- Returns "val" clamped to the specified "low" and "high" values

    return min(max(val, low), high)

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (nodes) (from petz/kitz/api/api_helper_functions.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.get_list_of_adjacent_node_positions(pos, non_oblique_flag)

    -- Was kitz.adjacent_pos_grid()
    -- Returns a list of positions, which are adjacent to the position "pos"; the returned list is
    --      in a random order
    -- By default, returns only the north/south/west/east positions; if "non_oblique_flag" is true,
    --      returns all eight positions

    local grid_list = {}
    local cell_list = {
        {x = 0, y = 0, z = 1},
        {x = 0, y = 0, z = -1},
        {x = 1, y = 0, z = 0},
        {x = -1, y = 0, z = 0},
    }

    if not non_oblique_flag then

        cell_list[#cell_list + 1] = {x = 1, y = 0, z = 1}
        cell_list[#cell_list + 1] = {x = 1, y = 0, z = -1}
        cell_list[#cell_list + 1] = {x = -1, y = 0, z = 1}
        cell_list[#cell_list + 1] = {x = -1, y = 0, z = -1}

    end

    local shuffled_cell_list = unimobs.kitz_api.shuffle_table_indices(cell_list)
    for _, cell_pos in ipairs(shuffled_cell_list) do
        grid_list[#grid_list + 1] = vector.add(pos, cell_pos)
    end

    return grid_list

end

function unimobs.kitz_api.get_random_adjacent_node_position(pos, non_oblique_flag)

    -- Was kitz.get_random_adjacent_pos()
    -- Returns a random position which is adjacent to the position "pos"
    -- By default, returns only one of the north/south/west/east positions; if "non_oblique_flag" is
    --      true, returns one of eight positions

    local grid_list = unimobs.kitz_api.get_list_of_adjacent_node_positions(pos, non_oblique_flag)
    return grid_list[random(1, #grid_list)]

end

function unimobs.kitz_api.is_air(pos)

    -- Was kitz.is_air()
    -- Returns true if the node at position "pos" is air, false otherwise

    local node = unimobs.mobkit_api.get_node_defn_at_pos(pos)
    if node and node.name == "air" then
        return true
    else
        return false
    end

end

function unimobs.kitz_api.is_liquid(pos)

    -- Was kitz.is_liquid()
    -- Returns true if the node at position "pos" is a liquid, false otherwise

    local node = unimobs.mobkit_api.get_node_defn_at_pos(pos)
    if node and (node.drawtype == "liquid" or node.drawtype == "flowingliquid") then
        return true
    else
        return false
    end

end

function unimobs.kitz_api.is_walkable(pos, offset)

    -- Was kitz.is_walkable()
    -- Returns true if the node at position "pos", adjusted (in the vertical direction) by the
    --      optional "offset", is walkable
    -- Returns false otherwise

    if offset then
        pos = vector.new(pos.x, pos.y + offset, pos.z)
    end

    local node = unimobs.mobkit_api.get_node_defn_at_pos(pos)
    if node and node.walkable then
        return true
    else
        return false
    end

end

function unimobs.kitz_api.node_has_group(pos, group)

    -- Was kitz.in_group()
    -- Tests whether the node at position "pos" has the specified "group"
    -- If not, returns false; otherwise returns the matching group's value

    local node = core.get_node_or_nil(pos)
    if node then

        local group_value = core.get_item_group(node.name, group)
        if group_value > 0 then
            return group_value
        else
            return false
        end

    else

        return false

    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (strings) (from petz/kitz/api/api_helper_functions.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.is_string_empty(s)

    -- Was kitz.string_is_empty(), duplicated by petz.str_is_empty()
    -- Returns true if the specified string is empty, false otherwise

    return s == nil or s == ""

end

function unimobs.kitz_api.remove_whitespace_in_string(val)

    -- Was petz.str_remove_spaces(); renamed to be part of the Kitz API, to be paired with the
    --      function above
    -- Removes any whitespace from the specified string, "val"

    val = val:gsub("%s+", "")
    return val

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (tables) (from petz/kitz/api/api_helper_functions.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.is_table(val)

    -- Was kitz.is_table()
    -- Returns true if the specified value is a table, false otherwise

    if type(val) == "table" then
        return true
    else
        return false
    end

end

function unimobs.kitz_api.is_table_empty(t)

    -- Was kitz.table_is_empty()
    -- Returns true if the specified value is an empty table, false otherwise

    if type(t) ~= "table" then
        return false
    end

    local next = next
    if next(t) == nil then
        return true
    else
        return false
    end

end

function unimobs.kitz_api.shuffle_table_indices(t)

    -- Was kitz.table_shuffle()
    -- Shuffles the numeric indices of the specified table, and returns it

    -- What does this line do? Your guess is as good as mine!
    local len, random = #t, random

    -- Shuffle the table
    for i = len, 2, -1 do

        local j = random(1, i)
        t[i], t[j] = t[j], t[i]

    end

    return t

end
