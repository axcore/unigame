---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- mobkit_queue.lua
--      Functions to handle the behaviour queues
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local abs = math.abs

---------------------------------------------------------------------------------------------------
-- Shared functions (from mobkit/init.lua)
---------------------------------------------------------------------------------------------------

function unimobs.mobkit_api.add_to_high_level_queue(self, name, func, priority)

    -- From mobkit/init.lua, was mobkit.queue_high(), duplicated by kitz.queue_high()
    -- Adds a behaviour definition to the high-level queue
    -- This function is only for use in behaviour packages; see the API for correct usage
    --
    -- CHANGES TO ORIGINAL MOBKIT BEHAVIOUR:
    -- The behaviour's "name" (usually matching its package name) should be specified, so it can be
    --      displayed when required
    -- The "priority" argument can be -1, which means "this behaviour automatically has the highest
    --      priority"

    local max_priority = unimobs.mobkit_api.get_queue_priority(self)
    if priority == -1 then
        priority = max_priority + 1
    end

    if priority > max_priority then
        unimobs.mobkit_api.clear_low_level_queue(self)
    end

    for i, behaviour_table in ipairs(self.hqueue_list) do

        if priority > behaviour_table.priority then

            table.insert(self.hqueue_list, i, {name = name, func = func, priority = priority})
            return

        end

    end

    table.insert(self.hqueue_list, {name = name, func = func, priority = priority})

end

function unimobs.mobkit_api.add_to_low_level_queue(self, name, func)

    -- From mobkit/init.lua, was mobkit.queue_low(), duplicated by kitz.queue_low()
    -- Adds a behaviour definition to the low-level queue
    -- This function is only for use in behaviour packages; see the API for correct usage
    --
    -- CHANGES TO ORIGINAL MOBKIT BEHAVIOUR:
    -- The behaviour's "name" (usually matching its package name) should be specified, so it can be
    --      displayed when required

    table.insert(self.lqueue_list, {name = name, func = func})

end

function unimobs.mobkit_api.clear_both_queues(self)

    -- Original to unimobs
    -- Convenience function for emptying both behaviour queues; a bit quicker than calling
    --      .clear_high_level_queue() and .clear_low_level_queue() consecutively

    self.hqueue_list = {}
    self.lqueue_list = {}

end

function unimobs.mobkit_api.clear_high_level_queue(self)

    -- From mobkit/init.lua, was mobkit.clear_queue_high(), duplicated by kitz.clear_queue_high()
    -- Empties the high-level queue

    self.hqueue_list = {}

end

function unimobs.mobkit_api.clear_low_level_queue(self)

    -- From mobkit/init.lua, was mobkit.clear_queue_low(), duplicated by kitz.clear_queue_low()
    -- Empties the low-level queue

    self.lqueue_list = {}

end

function unimobs.mobkit_api.execute_queues(self)

    -- From mobkit/init.lua, was execute_queues()
    -- Called by unimobs.mobkit_api.on_step_callback()
    -- Executes the first high-level behaviour (if any), and then the first low-level behaviour (if
    --      any)

    -- Execute high-level queue
    if #self.hqueue_list > 0 then

        local func = self.hqueue_list[1].func
        if func(self) then

            -- N.B. Fixed a disastrous bug in the original mobkit code: if one high-level
            --      behaviour calls another one (e.g. "hqb_find_liquid" calls "hqb_goto_liquid"),
            --      then the first item in self.hqueue_list is NOT the one which has just terminated
--          table.remove(self.hqueue_list, 1)
            for i, mini_table in pairs(self.hqueue_list) do

                if mini_table.func == func then

                    table.remove(self.hqueue_list, i)
                    break

                end

            end

            -- When a high-level behaviour finishes, all low-level behaviours depending on it are
            --      purged
            self.lqueue_list = {}

        end

    end

    -- Execute low-level queue
    if #self.lqueue_list > 0 then

        local func = self.lqueue_list[1].func
        if func(self) then

            -- N.B. The low-level queue is FIFO, so the bugfix above doesn't apply here
            table.remove(self.lqueue_list, 1)

        end

    end

end

function unimobs.mobkit_api.get_queue_priority(self)

    -- From mobkit/init.lua, was mobkit.get_queue_priority(), duplicated by
    --      kitz.get_queue_priority()
    -- Returns the priority of the highest-priority behaviour in the high-level queue; this is the
    --      behaviour that's currently running

    if #self.hqueue_list > 0 then
        return self.hqueue_list[1].priority
    else
        return 0
    end

end

function unimobs.mobkit_api.is_behaviour_in_high_level_queue(self, name)

    -- Original to unimobs
    -- Returns true if the named behaviour is in the high-level queue, false if not

    if not name then
        return false
    end

    for _, mini_table in ipairs(self.hqueue_list) do

        if mini_table.name == name then
            return true
        end

    end

    return false

end

function unimobs.mobkit_api.is_behaviour_in_low_level_queue(self, name)

    -- Original to unimobs
    -- Returns true if the named behaviour is in the low-level queue, false if not

    if not name then
        return false
    end

    for _, mini_table in ipairs(self.lqueue_list) do

        if mini_table.name == name then
            return true
        end

    end

    return false

end

function unimobs.mobkit_api.is_high_level_queue_empty(self)

    -- From mobkit/init.lua, was mobkit.is_queue_empty_high(), duplicated by
    --      kitz.is_queue_empty_high()
    -- Returns true if the high-level queue is empty, false otherwise

    if #self.hqueue_list == 0 then
        return true
    else
        return false
    end

end

function unimobs.mobkit_api.is_low_level_queue_empty(self)

    -- From mobkit/init.lua, was mobkit.is_queue_empty_low(), duplicated by
    --      kitz.is_queue_empty_low()
    -- Returns true if the low-level queue is empty, false otherwise

    if #self.lqueue_list == 0 then
        return true
    else
        return false
    end

end
