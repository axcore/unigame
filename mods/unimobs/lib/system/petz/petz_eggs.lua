---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_eggs.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local ceil = math.ceil
local floor = math.floor
local random = math.random

-- Ducks, hens etc only look for empty nests within this range (1 in original code)
local lay_range = 2
-- Number of empty nests within range, in order for a creature to lay an egg in one of them (2 in
--      original code)
local empty_nest_requirement = 1

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_eggs.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.lay_egg(self)

    -- From petz.lay_egg()
    -- Makes the specified mob lay an egg at random intervals (if permitted)

    -- Basic checks
    -- N.B. Fixed bug in original code, which allowed males to lay eggs
    if not self.egg_name or self.is_male_flag or core.registered_items[self.egg_name] then
        return
    end

    -- Increase the probability of laying an egg according to the "productivity" gene, and also the
    --      maximum number of eggs that can be laid
    local lay_egg_interval = unimobs.petz_setting.lay_egg_interval
    local max_laid_eggs =
            unimobs.petz_api.get_custom_msetting(self.mob_type, "custom_max_laid_eggs") or
            unimobs.petz_setting.max_laid_eggs

    local genetic_value = self.genetic_table["productivity"]
    local data_table = unimobs.petz_api.get_genetic_range_table(self, "productivity")
    if genetic_value ~= nil and genetic_value > 0 and data_table ~= nil then

        local reduction_factor = unimobs.petz_setting.genetic_productivity_factor * (
            (genetic_value - data_table.overall_min) /
            (data_table.overall_max - data_table.overall_min)
        )

        lay_egg_interval = ceil(lay_egg_interval * (1 - reduction_factor))
        max_laid_eggs = floor(max_laid_eggs + (max_laid_eggs * reduction_factor))

    end

    if not unimobs.mobkit_api.check_main_timer(
        self, unimobs.petz_api.get_random_interval(lay_egg_interval)
    ) or self.egg_count >= max_laid_eggs then
        return
    end

    -- Setup
    local pos = self.object:get_pos()
    local laid_egg_flag = false

    -- Lay an egg in a nest (in the original code, eggs produced by hens and ducks)
    if self.nest_empty_name or self.nest_full_name then

        -- Basic checks
        if not self.nest_empty_name or
                not core.registered_items[self.nest_empty_name] or
                not self.nest_full_name or
                not core.registered_items[self.nest_full_name] then
            return
        end

        -- Find nearby empty nests
        local nearby_node_list = core.find_nodes_in_area(
            {x = pos.x - lay_range, y = pos.y - 1, z = pos.z - lay_range},
            {x = pos.x + lay_range, y = pos.y + 1, z = pos.z + lay_range},
            self.nest_empty_name
        )

        -- N.B. In original code, a single duck could lay a new egg every few seconds, given enough
        --      empty nests
        -- In our version, we apply the same timer to all egg-laying creatures (having moved the
        --      call to unimobs.mobkit_api.check_main_timer() to the beginning of this function),
        --      but we compensate by increasing "lay_range" from 1 to 2, and reducing the number of
        --      nearby empty nests required from 2 to 1
        if #nearby_node_list >= empty_nest_requirement then

            -- Lay an egg in one of the nearby nests
            local nest_node = nearby_node_list[random(1, #nearby_node_list)]
            core.set_node(nest_node, {name = self.nest_full_name})
            laid_egg_flag = true

        end

    -- Lay an egg on the ground (in the original code, eggs produced by ants, geckos and penguins)
    else

        -- Do not lay eggs when in a liquid, or if the number of mobs in the immediate area has
        --      reached the maximum
        if unimobs.petz_api.is_mob_in_liquid(self) or
                unimobs.petz_api.check_mob_limit(pos, self.mob_type) then
            return
        end

        if core.registered_nodes[self.egg_name] and unimobs.kitz_api.is_air(pos) then

            -- Node-style eggs; in the original code, produced by ant queens and geckos
            core.set_node(pos, {name = self.egg_name})
            laid_egg_flag = true

        -- N.B. Fixed obvious bug in original code - don't try to create non-existent craftitem
        --      eggs, just because the .is_air() call just above failed
        elseif core.registered_craftitems[self.egg_name] then

            -- Eggs which are implemented as entities/craftitems; in the original code, produced by
            --      penguins
            core.add_entity(
                -- (The false flag selects from a list of 8 positions, 1 in each compass direction)
                unimobs.kitz_api.get_random_adjacent_node_position(pos, false),
                self.egg_name
            )

            laid_egg_flag = true

        end

    end

    if laid_egg_flag then
        self.egg_count = unimobs.mobkit_api.add_mob_memory(self, "egg_count", self.egg_count + 1)
    end

end

function unimobs.petz_api.extract_egg_from_nest(pos, player, itemstack, egg_name, empty_nest_name)

    -- From petz.extract_egg_from_nest()
    -- When the player right-clicks a nest-with-egg node, move the egg to the player's inventory,
    --      and replace the full nest with an empty one
    -- "itemstack" is the item wielded by the player (if any), "egg_name" is a string like
    --      "unilib:egg_chicken_normal", and the optional "empty_nest_name" argument is a string
    --      like "unilib:misc_nest"

    local inv = player:get_inventory()
    if inv:room_for_item("main", egg_name) then

        -- Add the egg to the player's inventory
        if (
            -- (Player is wielding a stack of eggs)
            itemstack:get_name() == egg_name and itemstack:get_count() < itemstack:get_stack_max()
        ) or (
            -- (Player is wielding nothing)
            itemstack:get_name() == ""
        ) then
            -- (Increase the stack of eggs, or create a stack containing 1 egg)
            itemstack:add_item(egg_name)
        else
            inv:add_item("main", egg_name)
        end

        -- Replace the full nest with an empty nest (if that package has been loaded), otherwise
        --      just remove the nest
        if empty_nest_name and core.registered_nodes[empty_nest_name] ~= nil then
            core.set_node(pos, {name = empty_nest_name})
        else
            core.remove_node(pos)
        end

    else

        core.chat_send_player(
            player:get_player_name(), S("There isn't enough room in your inventory for the egg")
        )

    end

    return itemstack

end
