---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_cauldron_soup = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

local boiling_msg = S("boiling, drop two ingredients inside to make soup")
local boiled_msg = S("boiled, use a wooden bowl to get soup")

local collision_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, -0.5},
        {-0.5, -0.5, 0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.5, -0.5, -0.5, 0.5, 0.5},
        {0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
    },
}

local sound_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_fill(pos, node, clicker, itemstack)

    -- Was cauldron.filling()

    local inv = clicker:get_inventory()
    local wield_name = clicker:get_wielded_item():get_name()

    -- Test whether the wielded item is a bucket full of potable water (but not any other kind of
    --      liquid), or an empty bucket
    local full_bucket, empty_bucket
    local data_table = unilib.global.full_bucket_table[wield_name]
    if data_table ~= nil and data_table.potable_flag then

        full_bucket = wield_name
        empty_bucket = data_table.empty_bucket

    elseif unilib.global.empty_bucket_table[wield_name] ~= nil then

        empty_bucket = wield_name

    end

    -- Fill or empty the cauldron, as appropriate
    if empty_bucket ~= nil then

        if wield_name == empty_bucket and (
            node.name == "unilib:machine_cauldron_soup_idle" or
            node.name == "unilib:machine_cauldron_soup_boiling" or
            node.name == "unilib:machine_cauldron_soup_boiled"
        ) then

            -- An empty bucket that can contain potable water
            local meta = core.get_meta(pos)
            local liquid_type = meta:get_string("water")
            full_bucket = unilib.global.empty_bucket_table[empty_bucket] .. "_with_" .. liquid_type

            if itemstack:get_count() > 1 then

                if inv:room_for_item("main", full_bucket .. " 1") then

                    itemstack:take_item()
                    inv:add_item("main", full_bucket .. " 1")

                else

                    core.chat_send_player(
                        clicker:get_player_name(),
                        S("No room in your inventory to add a bucket of water.")
                    )

                    return itemstack

                end

            else

                -- Fill the bucket
                itemstack:replace(full_bucket)

            end

            -- Empty the caulrdon
            core.set_node(
                pos,
                {name = "unilib:machine_cauldron_soup_empty", param2 = node.param2}
            )

        elseif wield_name == full_bucket and node.name == "unilib:machine_cauldron_soup_empty" then

            -- A bucket of potable water
            core.set_node(
                pos,
                {name = "unilib:machine_cauldron_soup_idle", param2 = node.param2}
            )

            itemstack:replace(empty_bucket)

            -- Remember which type of water has been used, e.g. by removing
            --      "unilib:bucket_steel_with_" to leave "water_ordinary"
            local meta = core.get_meta(pos)
            meta:set_string("water", unilib.global.full_bucket_table[wield_name]["liquid_type"])

        end

        return itemstack

    end

end

local function stop_sound(pos)

    -- Was cauldron.stop_sound()

    local spos = core.hash_node_position(pos)
    if sound_table[spos] then
        core.sound_stop(sound_table[spos])
    end

end

local function idle_construct(pos)

    -- Was cauldron.idle_construct()

    local timer = core.get_node_timer(pos)
    timer:start(10.0)
    stop_sound(pos)

end

local function boiling_construct(pos)

    -- Was cauldron.boiling_construct()

    local spos = core.hash_node_position(pos)
    sound_table[spos] = core.sound_play("unilib_cauldron_boiling", {
        pos = pos,
        max_hear_distance = 5,
        gain = 0.8,
        loop = true
    })

    local meta = core.get_meta(pos)
    meta:set_string("infotext", unilib.utils.brackets(S("Soup Cauldron"), boiling_msg))

    local timer = core.get_node_timer(pos)
    timer:start(5.0)

end

local function idle_timer(pos)

    -- Was cauldron.idle_timer()

    local below_node = {x = pos.x, y = pos.y - 1, z = pos.z}
    -- (Don't heat the cauldron with fireflies...)
    if core.get_item_group(core.get_node(below_node).name, "fire") == 0 then
        return true
    end

    -- (The water must be retrievable from the boiling cauldron variant)
    local meta = core.get_meta(pos)
    local water = meta:get_string("water")

    local node = core.get_node(pos)
    core.set_node(pos, {name = "unilib:machine_cauldron_soup_boiling", param2 = node.param2})
    meta:set_string("water", water)

    return true

end

local function is_edible(itemstring)

    -- Was eatable()
    -- Ugly hack to determine if an item has the function unilib.cuisine.eat_on_use() (or the
    --      corresponding original function, core.item_eat() ) in its definition

    local full_name = itemstring:match("[%w_:]+")
    local func_def = core.registered_items[full_name].on_use

    if func_def and (
        string.format("%q", string.dump(func_def)):find("cuisine_eat_on_use") or
        string.format("%q", string.dump(func_def)):find("item_eat")
    ) then
        return true
    else
        return false
    end

end

local function boiling_timer(pos)

    -- Was cauldron.boiling_timer()

    local node = core.get_node(pos)

    -- (If fire has been removed, go back to the "idle" state)
    local node_under = {x = pos.x, y = pos.y - 1, z = pos.z}
    if core.get_item_group(core.get_node(node_under).name, "fire") == 0 then

        -- (The water must be retrievable after the boiling cauldron variant cools down)
        local meta = core.get_meta(pos)
        local water = meta:get_string("water")
        core.set_node(pos, {name = "unilib:machine_cauldron_soup_idle", param2 = node.param2})
        meta:set_string("water", water)

    end

    -- (The things thrown into the cauldron by the player)
    local contents_list = core.get_objects_inside_radius(pos, 0.5)
    if not next(contents_list) then
        return true
    end

    -- (Filter out anything that is not a valid ingredient)
    local ingredient_list = {}
    for _, obj in pairs(contents_list) do

        if obj and not obj:is_player() and obj:get_luaentity().itemstring then

            local itemstring = obj:get_luaentity().itemstring
            local item_name, multiple = unilib.utils.get_item_and_multiple(itemstring)
            -- N.B. In the original code, if the ingredient contained one of a list of words like
            --      "apple" and "carrot", then it was deemed a suitable ingredient for soup
            -- Here, we are stricter; the player should not be allowed to use both salad tomatoes
            --      and salad tomato seeds to produce a +30 soup
            if item_name and is_edible(itemstring) then

                -- N.B. Unlike in the original code, a stack counts as 99 ingredients, not one!
                for i = 1, multiple do
                    ingredient_list[#ingredient_list + 1] = item_name
                end

            end

        end

    end

    if #ingredient_list >= 2 then

        for _, obj in pairs(contents_list) do
            obj:remove()
        end

        core.set_node(pos, {name = "unilib:machine_cauldron_soup_boiled", param2 = node.param2})

    end

    return true

end

function take_soup(pos, node, clicker, itemstack)

    -- Was cauldron.take_soup()

    local inv = clicker:get_inventory()
    local wield_item = clicker:get_wielded_item()
    local full_name = wield_item:get_name()

    if full_name == "unilib:utensil_bowl_wooden" then

        if wield_item:get_count() > 1 then

            if inv:room_for_item("main", "unilib:food_soup_mixed 1") then

                itemstack:take_item()
                inv:add_item("main", "unilib:food_soup_mixed 1")

            else

                core.chat_send_player(clicker:get_player_name(),
                    S("No room in your inventory to add a bowl of mixed soup."))
                return itemstack

            end

        else

            itemstack:replace("unilib:food_soup_mixed 1")

        end

        core.set_node(pos, {name = "unilib:machine_cauldron_soup_empty", param2 = node.param2})

    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_cauldron_soup.init()

    return {
        description = "Soup cauldron",
        notes = "Place the cauldron above a fire. Put a bucket of water into it. Wait until the" ..
                " water boils, then drop at least two suitable ingredients into it (using the" ..
                " Minetest \"drop\" key). When the soup has boiled, use a wooden bowl to" ..
                " collect it. N.B. The ingredient detection system is fiddly; it's better to" ..
                " throw in a stack of two (or more) apples, than to throw in each apple" ..
                " separately",
        depends = {"food_soup_mixed", "metal_iron", "utensil_bowl_wooden"},
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.machine_cauldron_soup.exec()

    local c_iron = "unilib:metal_iron_lump"

    unilib.register_node("unilib:machine_cauldron_soup_empty", "xdecor:cauldron_empty", mode, {
        -- From xdecor:cauldron_empty
        description = S("Soup Cauldron"),
        tiles = {
            "unilib_machine_cauldron_soup_top_empty.png",
            "unilib_machine_cauldron_soup_side.png",
        },
        groups = {cracky = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.node,

        collision_box = collision_box,
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("infotext", unilib.utils.brackets(S("Soup Cauldron"), S("empty")))

            stop_sound(pos)

        end,

        on_rightclick = do_fill,

    })
    unilib.register_craft({
        -- From xdecor:cauldron_empty
        output = "unilib:machine_cauldron_soup_empty",
        recipe = {
            {c_iron, "", c_iron},
            {c_iron, "", c_iron},
            {c_iron, c_iron, c_iron},
        },
    })

    unilib.register_node("unilib:machine_cauldron_soup_idle", "xdecor:cauldron_idle", mode, {
        -- From xdecor:cauldron_idle
        description = S("Soup Cauldron"),
        tiles = {
            "unilib_machine_cauldron_soup_top_idle.png",
            "unilib_machine_cauldron_soup_side.png",
        },
        groups = {cracky = 2, not_in_creative_inventory = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.node,

        collision_box = collision_box,
        drop = "unilib:machine_cauldron_soup_empty",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("infotext", unilib.utils.brackets(S("Soup Cauldron"), S("idle")))

            idle_construct(pos)

        end,

        on_rightclick = do_fill,

        on_timer = idle_timer,
    })

    unilib.register_node("unilib:machine_cauldron_soup_boiling", "xdecor:cauldron_boiling", mode, {
        -- From xdecor:cauldron_boiling
        description = S("Soup Cauldron"),
        tiles = {
            {
                name = "unilib_machine_cauldron_soup_top_boiling_animated.png",
                animation = {type = "vertical_frames", length = 3.0}
            },
            "unilib_machine_cauldron_soup_side.png"
        },
        groups = {cracky = 2, not_in_creative_inventory = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.node,

        collision_box = collision_box,
        damage_per_second = 2,
        drop = "unilib:machine_cauldron_soup_empty",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("infotext", unilib.utils.brackets(S("Soup Cauldron"), boiling_msg))

            boiling_construct(pos)

        end,

        on_destruct = function(pos)
            stop_sound(pos)
        end,

        on_rightclick = do_fill,

        on_timer = boiling_timer,
    })

    unilib.register_node("unilib:machine_cauldron_soup_boiled", "xdecor:cauldron_soup", mode, {
        -- From xdecor:cauldron_soup
        description = S("Soup Cauldron"),
        tiles = {
            {
                name = "unilib_machine_cauldron_soup_top_boiled_animated.png",
                animation = {type = "vertical_frames", length = 3.0}
            },
            "unilib_machine_cauldron_soup_side.png"
        },
        groups = {cracky = 2, not_in_creative_inventory = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.node,

        collision_box = collision_box,
        damage_per_second = 2,
        drop = "unilib:machine_cauldron_soup_empty",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype2 = "facedir",

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("infotext", unilib.utils.brackets(S("Soup Cauldron"), boiled_msg))

        end,

        on_destruct = function(pos)
            stop_sound(pos)
        end,

        on_rightclick = take_soup,
    })

    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:machine_cauldron_soup_empty", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

        unilib.override_item("unilib:machine_cauldron_soup_idle", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

        unilib.override_item("unilib:machine_cauldron_soup_boiling", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

        unilib.override_item("unilib:machine_cauldron_soup_boiled", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
