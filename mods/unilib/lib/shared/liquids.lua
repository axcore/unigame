---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- liquids.lua
--      Set up shared functions for liquids
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.check_bucket_protection(pos, name, text)

    -- Adapted from bucket/init.lua

    if minetest.is_protected(pos, name) then

        unilib.log(
            "action",
            (name ~= "" and name or "A mod") .. " tried to " .. text .. " at protected position " ..
            minetest.pos_to_string(pos) .. " with a bucket"
        )
        minetest.record_protection_violation(pos, name)
        return true

    else

        return false

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (bucket/liquid registration)
---------------------------------------------------------------------------------------------------

function unilib.register_bucket(data_table)

    -- Adapted from bucket/init.lua
    -- Registers a type of bucket in global variables (the empty bucket itself should be registered
    --      with a call to unilib.register_craftitem(), as usual)
    -- During ../lib/system/import_pkg.lua's consolidation stage, after all package .exec()
    --      functions have been executed, but before package .post() functions are executed, all
    --      buckets are combined with all liquids to create new items
    -- The new liquid-in-bucket items are then available for the .post() functions to use
    --
    -- This function also creates the empty bucket craftitem
    --
    -- Note that buckets that DON'T contain a liquid (e.g. the bucket of cactus pulp) should not
    --      call this function. For a code example, see the "food_pulp_cactus" package
    --
    -- data_table compulsory fields:
    --      orig_name (str or list): A list of all liquid-in-bucket variants to replace, e.g.
    --          { "bucket:bucket_empty", "bucket:bucket_water", ... }
    --      bucket_type (str): e.g. "bucket_steel", "bucket_wood", usually matching the parent
    --          package name
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burntime (int): e.g. 22 for a wooden bucket, or 0 if not flammable. The later call to
    --          unilib.register_liquid_in_bucket() will not put a flammable liquid (e.g. lava)
    --          inside a flammable bucket (e.g. wooden buckets)
    --      description (str): e.g. "Steel Bucket"
    --      group_table (table): e.g. {tool = 1}. These groups are applied both to the empty bucket
    --          and all its filled variants
    --      ingredient (str): e.g. "unilib:metal_steel_ingot", "group:wood"
    --      stack_max (int): e.g. 1, 99

    local orig_name = data_table.orig_name
    local bucket_type = data_table.bucket_type

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burntime = data_table.burntime or 0
    local description = data_table.description or S("Bucket")
    local group_table = data_table.group_table or {tool = 1}
    local ingredient = data_table.ingredient or nil
    local stack_max = data_table.stack_max or 99

    local full_name = "unilib:" .. bucket_type .. "_empty"

    -- Update global variables
    local def_table = {}
    def_table.bucket_type = bucket_type
    def_table.burntime = burntime
    def_table.description = description
    def_table.group_table = group_table

    unilib.generic_bucket_table[bucket_type] = def_table

    -- Create the empty bucket craftitem
    unilib.register_craftitem(full_name, orig_name, replace_mode, {
        description = unilib.brackets(description, S("Empty")),
        inventory_image = "unilib_" .. bucket_type .. "_empty.png",
        groups = group_table,

        liquids_pointable = true,
        stack_max = stack_max,

        on_use = function(itemstack, user, pointed_thing)

            if pointed_thing.type == "object" then

                pointed_thing.ref:punch(user, 1.0, { full_punch_interval = 1.0 }, nil)
                return user:get_wielded_item()

            elseif pointed_thing.type ~= "node" then

                -- Do nothing if it's neither object nor node
                return

            end

            -- Check if pointing to a liquid source registered with unilib
            local liquiddef = nil
            local itemname = nil
            local burn_flag = false

            local item_count = user:get_wielded_item():get_count()
            local node = minetest.get_node(pointed_thing.under)
            local liquid_name = unilib.reverse_liquid_table[node.name]

            if liquid_name ~= nil then

                liquiddef = unilib.generic_liquid_table[liquid_name]
                if liquiddef ~= nil then
                    itemname = "unilib:" .. bucket_type .. "_with_" .. liquid_name
                end

                -- Check that a flammable bucket isn't trying to pick up a flammable liquid
                if liquiddef.burntime ~= nil and liquiddef.burntime > 0 and burntime > 0 then
                    burn_flag = true
                end

            elseif minetest.get_modpath("bucket") ~= nil and bucket_type == "bucket_steel" then

                -- Otherwise, check if using a steel bucket to point to a liquid source registered
                --      with minetest_game/bucket (for backwards compatibility)
                liquiddef = bucket.liquids[node.name]
                if liquiddef ~= nil then
                    itemname = liquiddef.itemname
                end

            end

            if itemname ~= nil and (not burn_flag) and (
                (liquiddef.source_name ~= nil and node.name == liquiddef.source_name) or
                (liquiddef.source ~= nil and node.name == liquiddef.source)
            ) then
                if unilib.check_bucket_protection(
                    pointed_thing.under,
                    user:get_player_name(),
                    "take " .. node.name
                ) then
                    return
                end

                -- By default, set to return filled bucket
                local giving_back = itemname

                -- Check if holding more than 1 empty bucket
                if item_count > 1 then

                    -- If space in inventory add filled bucket, otherwise drop as item
                    local inv = user:get_inventory()
                    if inv:room_for_item("main", {name = itemname}) then

                        inv:add_item("main", itemname)

                    else

                        local pos = user:get_pos()
                        pos.y = math.floor(pos.y + 0.5)
                        minetest.add_item(pos, itemname)

                    end

                    -- Set to return empty buckets minus 1
                    giving_back = full_name .. " " .. tostring(item_count - 1)

                end

                -- force_renew requires a source neighbour
                local source_neighbour = false
                if liquiddef.force_renew_flag then

                    source_neighbour = minetest.find_node_near(
                        pointed_thing.under, 1, liquiddef.source_name
                    )

                end

                if not (source_neighbour and liquiddef.force_renew_flag) then
                    minetest.add_node(pointed_thing.under, {name = "air"})
                end

                return ItemStack(giving_back)

            else

                -- Non-liquid nodes will have their on_punch triggered
                local node_def = minetest.registered_nodes[node.name]
                if node_def then
                    node_def.on_punch(pointed_thing.under, node, user, pointed_thing)
                end
                return user:get_wielded_item()

            end

        end,
    })
    if ingredient ~= nil then

        unilib.register_craft({
            output = full_name,
            recipe = {
                {ingredient, "", ingredient},
                {"", ingredient, ""},
            },
        })

    end

    -- Set the fallback empty bucket, if none has been set yet (see the notes in
    --      ../shared/global.lua)
    if unilib.fallback_empty_bucket == nil then
        unilib.fallback_empty_bucket = full_name
    end

end

function unilib.register_liquid(data_table)

    -- Adapted from buckets/init.lua
    -- Registers a type of liquid in global variables (the source/flowing nodes themselves should be
    --      registered with a call to unilib.register_node(), as usual)
    -- During ../lib/system/import_pkg.lua's consolidation stage, after all package .exec()
    --      functions have been executed, but before package .post() functions are executed, all
    --      buckets are combined with all liquids to create new items
    -- The new liquid-in-bucket items are then available for the .post() functions to use
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "water_ordinary"
    --      source_name (str): e.g. "unilib:liquid_water_ordinary_source"
    --      flowing_name (str): e.g. "unilib:liquid_water_ordinary_flowing"
    --
    -- data_table optional fields:
    --      burntime (int): e.g. 60 for lava, or 0 if not flammable
    --      craftable_flag (bool): Set to true for water suitable for general use in craft recipes
    --              (including, for example, some muddy waters, but not dyed water); false for all
    --              other types of liquid
    --      description (str): e.g. "Ordinary Water"
    --      force_renew_flag (bool): Set to true to override the "liquid_renewable = false". See the
    --          notes in the "liquid_water_river" package for an example
    --      group_table (table): These groups are applied to all buckets filled with this liquid.
    --          This function adds the groups .craftable_bucket, potable_bucket and water_bucket as
    --          appropriate, so there is no need for the calling code to do that. The later call to
    --          unilib.register_liquid_in_bucket() adds the groups of the empty bucket, typically
    --          {tool = 1}, so there is no need for the calling code to do that
    --      potable_flag (bool): Set to true for water suitable for drinking, and for use in food
    --          recipes; false (or nil) for all other types of water
    --      water_flag (bool): Set to true for water, false (or nil) for other types of liquid

    local def_table = {}

    def_table.part_name = data_table.part_name
    def_table.source_name = data_table.source_name
    def_table.flowing_name = data_table.flowing_name

    def_table.burntime = data_table.burntime or 0
    def_table.craftable_flag = data_table.craftable_flag or false
    def_table.description = data_table.description or S("Liquid")
    def_table.force_renew_flag = data_table.force_renew_flag or false
    def_table.group_table = data_table.group_table or {}
    def_table.potable_flag = data_table.potable_flag or false
    def_table.water_flag = data_table.water_flag or false

    if def_table.craftable_flag and def_table.group_table.craftable_bucket == nil then
        def_table.group_table.craftable_bucket = 1
    end

    if def_table.potable_flag and def_table.group_table.potable_bucket == nil then
        def_table.group_table.potable_bucket = 1
    end

    if def_table.water_flag and def_table.group_table.water_bucket == nil then
        def_table.group_table.water_bucket = 1
    end

    unilib.generic_liquid_table[data_table.part_name] = def_table
    unilib.reverse_liquid_table[data_table.source_name] = data_table.part_name
    -- (Not needed by buckets, but added anyway)
    unilib.reverse_liquid_table[data_table.flowing_name] = data_table.part_name

end

function unilib.register_liquid_in_bucket(data_table)

    -- Adapted from bucket/init.lua
    -- Called by ../lib/system/import_pkg.lua during its consolidation stage, all empty buckets
    --      having been registered by calls to unilib.register_bucket(), and all liquids having been
    --      registered in calls to unilib.register_liquid()
    --
    -- data_table compulsory fields:
    --      bucket_type (str): a key in unilib.generic_bucket_table
    --      liquid_name (str): a key in unilib.generic_liquid_table
    --
    -- Return values:
    --      The full name of the filled bucket, e.g. "unilib:bucket_steel_with_water_ordinary"

    local bucket_type = data_table.bucket_type
    local liquid_name = data_table.liquid_name

    local filled_bucket_name = "unilib:" .. bucket_type .. "_with_" .. liquid_name
    local empty_bucket_name = "unilib:" .. bucket_type .. "_empty"
    local bucket_table = unilib.generic_bucket_table[bucket_type]
    local liquid_table = unilib.generic_liquid_table[liquid_name]
    local description = unilib.brackets(bucket_table.description, liquid_table.description)
    local img = "unilib_" .. bucket_type .. "_empty.png^unilib_bucket_" .. liquid_name ..
            "_overlay.png"

    local group_table = {}
    for k, v in pairs(liquid_table.group_table) do
        group_table[k] = v
    end

    for k, v in pairs(bucket_table.group_table) do
        group_table[k] = v
    end

    -- Do not place flammable liquids (e.g. lava) in flammable buckets (e.g. wooden)
    if bucket_table.burntime > 0 and liquid_table.burntime > 0 then
        return
    end

    -- Register the liquid in its bucket
    unilib.register_craftitem(filled_bucket_name, nil, nil, {
        description = description,
        inventory_image = img,
        groups = group_table,

        liquids_pointable = true,
        stack_max = 1,

        on_place = function(itemstack, user, pointed_thing)

            -- Must be pointing to node
            if pointed_thing.type ~= "node" then
                return
            end

            local node = minetest.get_node_or_nil(pointed_thing.under)
            local ndef = node and minetest.registered_nodes[node.name]

            -- Call on_rightclick if the pointed node defines it
            if ndef and ndef.on_rightclick and not (
                user and user:is_player() and
                user:get_player_control().sneak
            ) then
                return ndef.on_rightclick(pointed_thing.under, node, user, itemstack)
            end

            local lpos

            -- Check if pointing to a buildable node
            if ndef and ndef.buildable_to then

                -- Buildable; replace the node
                lpos = pointed_thing.under

            else

                -- Not buildable to; place the liquid above
                -- Check if the node above can be replaced
                lpos = pointed_thing.above
                node = minetest.get_node_or_nil(lpos)
                local above_ndef = node and minetest.registered_nodes[node.name]

                if not above_ndef or not above_ndef.buildable_to then

                    -- Do not remove the bucket with the liquid
                    return itemstack

                end

            end

            if unilib.check_bucket_protection(
                lpos,
                user and user:get_player_name() or "",
                "place " .. liquid_table.source_name
            ) then
                return
            end

            minetest.set_node(lpos, {name = liquid_table.source_name})
            return ItemStack("unilib:" .. bucket_type .. "_empty")

        end
    })

    -- For flammable liquids, register a craft recipe
    if liquid_table.burntime ~= nil and liquid_table.burntime > 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = filled_bucket_name,
            burntime = liquid_table.burntime,

            replacements = {{filled_bucket_name, empty_bucket_name}},
        })

    end

    -- Update global variables
    unilib.empty_bucket_table[filled_bucket_name] = empty_bucket_name

    if liquid_table.craftable_flag == true then
        table.insert(unilib.craftable_bucket_list, {filled_bucket_name, empty_bucket_name})
    end

    if liquid_table.potable_flag == true then
        table.insert(unilib.potable_bucket_list, {filled_bucket_name, empty_bucket_name})
    end

    if liquid_table.water_flag == true then
        table.insert(unilib.water_bucket_list, {filled_bucket_name, empty_bucket_name})
    end

    return filled_bucket_name

end

---------------------------------------------------------------------------------------------------
-- Shared functions (register melting ice/snow)
---------------------------------------------------------------------------------------------------

function unilib.register_ice_snow_melting(full_name, data_table)

    -- Original to unilib
    -- Ice/snow items that are capable of melting into water should call this function, so that
    --      suitable ABMs can act on them
    --
    -- Args:
    --      full_name (str): e.g. "unilib:snow_soft_block"
    --      data_table (table): Table containing the keys .source and .flowing, the full names of
    --          the pair of water nodes. If not specified, "unilib:liquid_water_ordinary_source"
    --          and "unilib:liquid_water_ordinary_flowing" are used

    unilib.ice_snow_melting_table[full_name] = data_table

end

---------------------------------------------------------------------------------------------------
-- Shared functions (lava registration)
---------------------------------------------------------------------------------------------------

function unilib.register_lava(data_table)

    -- Original to unilib
    -- Registers a type of lava in global variables, as well as the stone node produced when the
    --      lava cools
    -- Lava items are also registered like any other type of liquid, with calls to
    --      unilib.register_liquid() and unilib.register_node()
    --
    -- data_table compulsory fields:
    --      data_table.cooled_name (str): e.g. "unilib:stone_obsidian"
    --      data_table.lava_name (str): e.g. "unilib:liquid_lava_ordinary_source"

    -- (Lava cooling is handled by an ABM, after all packages have been loaded)
    unilib.lava_cooling_table[data_table.lava_name] = data_table.cooled_name

end
