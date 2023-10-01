---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_saw_circular = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

local F = minetest.formspec_escape

---------------------------------------------------------------------------------------------------
-- Object prototype
---------------------------------------------------------------------------------------------------

local prototype_saw = {}

---------------------------------------------------------------------------------------------------
-- Object prototype methods
---------------------------------------------------------------------------------------------------

function prototype_saw:extract_stair_type(adj_full_name)

    -- Original to unilib
    -- Returns the stair type (a key in unilib.stair_cost_table)
    -- e.g. converts "unilib:stone_ordinary_stair_simple" to "_stair_simple"

    full_name = unilib.stair_deconvert_table[adj_full_name]
    return string.sub(adj_full_name, (#full_name + 1), -1)

end

function prototype_saw:get_cost(inv, stackname)

    -- Gets the cost in microblocks for the node's stair type

    local name = minetest.registered_aliases[stackname] or stackname

    for i, item in pairs(inv:get_list("output")) do
        if item:get_name() == name then
            return unilib.stair_cost_table[unilib.extract_stair_type(name)]
        end
    end

end

function prototype_saw:get_output_inv(full_name, amount, max_output)

    -- Populates the output (RHS) inventory, after a node or stack has been dragged into the
    --      "input" slot
    -- Called with the name of the node in the "input" slot, the equivalent "amount" of microblocks
    --      (number of nodes x microblock cost per node), and the maximum output specified by the
    --      user

    local list = {}
    local pos = #list

    if (not max_output or max_output < 1 or max_output > 99) then
        max_output = 99
    end

    -- If there is nothing in the "input" slot, then of course the output inventory should be empty
    --      too
    if amount < 1 then
        return list
    end

    -- Add each stair type to the output inventory, in the appropriate quantities
    for _, stair_type in pairs(self.stair_type_list) do

        if unilib.stair_cost_table[stair_type] ~= nil then

            local cost = unilib.stair_cost_table[stair_type]
            local balance = math.min(math.floor(amount/cost), max_output)
            local adj_full_name = full_name .. stair_type

            if minetest.registered_nodes[adj_full_name] then

                pos = pos + 1
                list[pos] = adj_full_name .. " " .. balance

            end

        end

    end

    return list

end

function prototype_saw:reset(pos)

    -- Resets the saw, when it is placed for the first time, and when the last full block has been
    --      removed from the "input" slot
    -- The "max_offered" setting is not reset

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local owner = meta:get_string("owner")

    inv:set_list("input",  {})
    inv:set_list("micro",  {})
    inv:set_list("output", {})

    meta:set_int("anz", 0)
    meta:set_string("infotext", self.empty_description .. self.get_owner_str(owner))

end

function prototype_saw:update_inventory(pos, amount)

    -- Updates the inventories when the player adds or removes something from the "input" slot

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()

    -- "amount" is the microblock equivalent of the node(s) added to the "input" slot
    amount = meta:get_int("anz") + amount

    -- Any material in the "recycle" slot is recycled automatically
    inv:set_list("recycle",  {})

    -- Do a complete reset if the last block has been removed
    if amount < 1 then

        self:reset(pos)
        return

    end

    local stack = inv:get_stack("input",  1)
    -- At least one "normal" block is necessary to see what kind of stairs are requested
    if stack:is_empty() then

        -- Any microblocks not taken out yet are now lost (covers material loss in the machine)
        self:reset(pos)
        return

    end

    local full_name = stack:get_name() or ""
    local def_table = stack:get_definition()
    local owner = meta:get_string("owner")

    -- In the "input" slot, display as many full blocks as possible
    inv:set_list("input", {
        full_name .. " " .. math.floor(amount / 8)
    })

    -- In the "micro" slot, display any leftover microblocks (0-7)
    inv:set_list("micro", {
        full_name .. "_stair_micro_bottom " .. (amount % 8)
    })

    -- Update display
    inv:set_list(
        "output",
        self:get_output_inv(full_name, amount, meta:get_int("max_offered"))
    )

    -- Store how many microblocks are now available
    meta:set_int("anz", amount)
    meta:set_string("infotext",
        S(self.work_description, def_table and def_table.description or item_name) ..
                self.get_owner_str(owner)
    )

end

---------------------------------------------------------------------------------------------------
-- Object prototype functions
---------------------------------------------------------------------------------------------------

function prototype_saw.allow_metadata_inventory_move(
        pos, from_list, from_index, to_list, to_index, count, player
)
    -- Notes from moreblocks:
    -- Moving the inventory of the "prototype_saw" around is not allowed because it is a fictional
    --      inventory
    -- Moving the inventory around would be rather impractical and make things more difficult to
    --      calculate

    return 0

end

function prototype_saw.allow_metadata_inventory_put(pos, listname, index, stack, player)

    -- Only the "input" and "recycle" slots are intended as input slots
    if listname == "output" or listname == "micro" then
        return 0
    end

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local stackname = stack:get_name()
    local count = stack:get_count()

    -- Deal with dropping into the "recycle" slot
    -- Only allow those items that are offered in the output inventory to be recycled
    if listname == "recycle" then

        if not inv:contains_item("output", stackname) then
            return 0
        end

        local stackmax = stack:get_stack_max()
        local instack = inv:get_stack("input", 1)
        local microstack = inv:get_stack("micro", 1)
        local incount = instack:get_count()
        local incost = (incount * 8) + microstack:get_count()
        local maxcost = (stackmax * 8) + 7
        local cost = prototype_saw:get_cost(inv, stackname)

        if (incost + cost) > maxcost then
            return math.max((maxcost - incost) / cost, 0)
        end

        return count

    end

    -- Deal with dropping into the "input" slot
    -- Only accept certain blocks as input which are known to be craftable into stairs
    if listname == "input" then

        -- Don't allow one node to be placed on top of a different kind of node
        if not inv:is_empty("input") then

            if inv:get_stack("input", index):get_name() ~= stackname then
                return 0
            end

        end

        -- Don't allow one type of node in the "input" slot, if another kind of node is in the
        --      "recycle" slot
        if not inv:is_empty("micro") then

            local microstackname = unilib.stair_convert_tabl[inv:get_stack("micro", 1):get_name()]
            if microstackname ~= stackname then
                return 0
            end

        end

        -- Return the number of nodes for which there is room in the "input" slot
        if unilib.stair_convert_table[stackname] ~= nil and inv:room_for_item("input", stack) then
            return count
        end

        -- There is no room in the "input" slot
        return 0

    end

end

function prototype_saw.allow_metadata_inventory_take(pos, listname, index, stack, player)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local input_stack = inv:get_stack(listname,  index)
    local player_inv = player:get_inventory()

    if not player_inv:room_for_item("main", input_stack) then
        return 0
    else
        return stack:get_count()
    end

end

function prototype_saw.can_dig(pos,player)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    if not inv:is_empty("input") or
            not inv:is_empty("micro") or
            not inv:is_empty("recycle") then

        return false

    else

        -- Can be dug by anyone when empty, not only by the owner
        return true

    end

end

function prototype_saw.get_owner_str(owner)

    -- Converts the player name "singeplayer" into the string " owned by singledplayer" (etc)
    -- Returns an empty string if there is no owner

    if owner and owner ~= "" then
        return (" (%s)"):format(S("owned by @1", owner))
    else
        return ""
    end

end

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_saw(version, description, empty_description, work_description, ingredient)

    -- Create an instance of the "prototype_saw" class, one for each circular saw type, in order to
    --      make this data available to its code
    -- The original moreblocks circular saw corresponds to our Mark IV saw
    local self = {
        version = version,
        description = description,                  -- Already translated
        empty_description = empty_description,      -- Already translated
        work_description = work_description,        -- NOT already translated
        stair_type_list = unilib.stair_ordered_table[version],
    }

    setmetatable(self, {__index = prototype_saw})

    local full_name = "unilib:machine_saw_circular_mark" .. tostring(version)
    local orig_name = nil
    if version == 4 then
        orig_name = "moreblocks:circular_saw"
    end

    -- Register the node
    unilib.register_node(full_name, orig_name, mode, {
        -- From moreblocks:circular_saw
        description = description,
        tiles = {
            "unilib_machine_saw_circular_mark" .. tostring(version) .. "_top.png",
            "unilib_machine_saw_circular_bottom.png",
            "unilib_machine_saw_circular_side.png",
        },
        groups = {choppy = 2,oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.4, -0.5, -0.4, -0.25, 0.25, -0.25},         -- Leg
                {0.25, -0.5, 0.25, 0.4, 0.25, 0.4},             -- Leg
                {-0.4, -0.5, 0.25, -0.25, 0.25, 0.4},           -- Leg
                {0.25, -0.5, -0.4, 0.4, 0.25, -0.25},           -- Leg
                {-0.5, 0.25, -0.5, 0.5, 0.375, 0.5},            -- Tabletop
                {-0.01, 0.4375, -0.125, 0.01, 0.5, 0.125},      -- Saw blade (top)
                {-0.01, 0.375, -0.1875, 0.01, 0.4375, 0.1875},  -- Saw blade (bottom)
                {-0.25, -0.0625, -0.25, 0.25, 0.25, 0.25},      -- Motor case
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,

        -- Set the owner of this circular saw
        after_place_node = function(pos, placer)

            local meta = minetest.get_meta(pos)
            local owner = placer and placer:get_player_name() or ""

            meta:set_string("owner",  owner)
            meta:set_string("infotext", self.empty_description .. self.get_owner_str(owner))

        end,

        -- Only the "input" and "recycle" slots are intended as input slots
        allow_metadata_inventory_put = self.allow_metadata_inventory_put,
        allow_metadata_inventory_take = self.allow_metadata_inventory_take,

        can_dig = self.can_dig,

        -- Set up the formspec for the saw
        on_construct = function(pos)

            local meta = minetest.get_meta(pos)

            meta:set_string(
                "formspec",
                "size[11,10]"..
                "label[0,0;" .. F(S("Input\nmaterial")) .. "]" ..
                "list[current_name;input;1.5,0;1,1;]" ..
                "label[0,1;" .. F(S("Leftover\nmaterial")) .. "]" ..
                "list[current_name;micro;1.5,1;1,1;]" ..
                "label[0,2;" .. F(S("Recycle\noutput")).. "]" ..
                "list[current_name;recycle;1.5,2;1,1;]" ..
                "field[0.3,4;2.5,1;max_offered;" .. F(S("Max output")) .. ":;${max_offered}]" ..
                "button[1.5,4.5;1,1;Set;" .. F(S("Set")).. "]" ..
                "list[current_name;output;2.8,0;8,6;]" ..
                "list[current_player;main;1.5,6.25;8,4;]" ..
                "listring[current_name;output]" ..
                "listring[current_player;main]" ..
                "listring[current_name;input]" ..
                "listring[current_player;main]" ..
                "listring[current_name;micro]" ..
                "listring[current_player;main]" ..
                "listring[current_name;recycle]" ..
                "listring[current_player;main]"
            )

            meta:set_int("anz", 0)              -- No microblocks still inside
            meta:set_string("max_offered", 99)  -- The maximum output, specifed by the user
            meta:set_string("infotext", self.empty_description)

            local inv = meta:get_inventory()
            inv:set_size("input", 1)            -- Input slot for full blocks of material x
            inv:set_size("micro", 1)            -- Storage for 1-7 surplus microblocks
            inv:set_size("recycle", 1)          -- Surplus partial blocks can be placed here
            -- Unlike the original moreblocks saw, this code only provides the number of slots
            --      required
            inv:set_size("output", #self.stair_type_list)

            self:reset(pos)

        end,

        -- Taking is allowed from all slots (even the internal microblock slot). Moving is
        --      forbidden. Putting something in is slightly more complicated than taking anything
        --      because we have to make sure it is of a suitable material
        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            -- We need to find out if the saw is already set to a specific material or not
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local stackname = stack:get_name()
            local count = stack:get_count()

            -- Putting something into the input slot is only possible if that had been empty before
            --      or contained something of the same material
            if listname == "input" then

                -- Each new block is worth 8 microblocks
                self:update_inventory(pos, 8 * count)

            elseif listname == "recycle" then

                -- Let's look at which shape this represents
                local cost = self:get_cost(inv, stackname)
                local input_stack = inv:get_stack("input", 1)
                -- Check if this would not exceed input itemstack "max_stacks"
                if input_stack:get_count() + ((cost * count) / 8) <=
                        input_stack:get_stack_max() then

                    self:update_inventory(pos, cost * count)

                end

            end

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            -- Notes from moreblocks:
            -- The recycle field plays no role here since it is processed immediately

            -- Prevent (inbuilt) swapping between inventories with different blocks corrupting
            --      player inventory or the saw with "unknown" items
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local input_stack = inv:get_stack(listname, index)

            if not input_stack:is_empty() and input_stack:get_name()~=stack:get_name() then

                local player_inv = player:get_inventory()

                -- Prevent arbitrary item duplication
                inv:remove_item(listname, input_stack)

                if player_inv:room_for_item("main", input_stack) then
                    player_inv:add_item("main", input_stack)
                end

                self:reset(pos)
                return

            end

            -- If it is one of the stairs on offer, then find out how many microblocks have to be
            --      subtracted
            if listname == "output" then

                local stair_type = unilib.extract_stair_type(stack:get_name())
                local cost = unilib.stair_cost_table[stair_type] * stack:get_count()
                self:update_inventory(pos, -cost)

            elseif listname == "micro" then

                -- Each microblock costs 1 microblock
                self:update_inventory(pos, -stack:get_count())

            elseif listname == "input" then

                -- Each normal (= full) block taken costs 8 microblocks
                self:update_inventory(pos, 8 * -stack:get_count())

            end

        end,

        -- The amount of items offered per shape can be configured
        on_receive_fields = function(pos, formname, fields, sender)

            local meta = minetest.get_meta(pos)
            local this_max = tonumber(fields.max_offered)

            if this_max and this_max > 0 then

                meta:set_string("max_offered",  this_max)
                -- Update to show the correct number of items
                self:update_inventory(pos, 0)

            end

        end,

        allow_metadata_inventory_move = self.allow_metadata_inventory_move,
    })

    -- Register the craft recipe, with the specified ingot as the active ingredient
    unilib.register_craft({
        -- From moreblocks
        output = full_name,
        recipe = {
            {"", ingredient, "" },
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "", "group:wood"},
        }
    })

    return self

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_saw_circular.init()

    return {
        description = "Circular saw",
        notes = "Creates up to four types of circular saw, one for each group of stair nodes" ..
                " enabled in Minetest settings",
        at_least_one = {"metal_bronze", "metal_gold", "metal_steel", "mineral_diamond"},
    }

end

function unilib.pkg.machine_saw_circular.exec()

    -- Create a circular saw for each group of stair nodes that have been enabled
    if unilib.add_stairs_basic_flag and unilib.pkg_executed_table["metal_steel"] ~= nil then

        register_saw(
            -- Version
            1,
            -- Descriptions for various states
            S("Circular Saw Mk I"),
            S("Circular Saw Mk I is empty"),
            "Circular Saw Mk I is working on @1",
            -- Ingredient
            "unilib:metal_steel_ingot"
        )

    end

    if unilib.add_stairs_stairs_redo_flag and unilib.pkg_executed_table["metal_bronze"] ~= nil then

        register_saw(
            2,
            S("Circular Saw Mk II"),
            S("Circular Saw Mk II is empty"),
            "Circular Saw Mk III is working on @1",
            "unilib:metal_bronze_ingot"
        )

    end

    if unilib.add_stairs_stairsplus_flag and unilib.pkg_executed_table["metal_gold"] ~= nil then

        register_saw(
            3,
            S("Circular Saw Mk III"),
            S("Circular Saw Mk III is empty"),
            "Circular Saw Mk III is working on @1",
            "unilib:metal_gold_ingot"
        )

    end

    if unilib.add_stairs_moreblocks_flag and
            unilib.pkg_executed_table["mineral_diamond"] ~= nil then

        register_saw(
            4,
            S("Circular Saw Mk IV"),
            S("Circular Saw Mk IV is empty"),
            "Circular Saw Mk IV is working on @1",
            "unilib:mineral_diamond_gem"
        )

    end

end
