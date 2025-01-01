---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    drinks
-- Code:    MIT
-- Media:   CC by SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_drinks = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.drinks.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

function retrieve_juice(liq_vol, ves_vol, pos, able_to_fill, leftover_count, outputstack)

    -- Adapted from drinks/drink_machines.lua, was drinks.drinks_liquid_sub()

    local meta = core.get_meta(pos)
    local fullness = tonumber(meta:get_string("fullness"))
    local fruit = meta:get_string("fruit")
    local fruit_name = meta:get_string("fruit_name")
    local inv = meta:get_inventory()
    local fullness = fullness - (liq_vol * able_to_fill)
    meta:set_string("fullness", fullness)
    meta:set_string(
        "infotext",
        S("@1 % fullof @2 juice.", (math.floor((fullness / ves_vol) * 100)), fruit_name)
    )

    if ves_vol == 128 then

        meta:set_string(
            "formspec", unilib.pkg.shared_drinks.juice_storage_formspec(fruit_name, fullness, 128)
        )

    elseif ves_vol == 256 then

        meta:set_string(
            "formspec", unilib.pkg.shared_drinks.juice_storage_formspec(fruit_name, fullness, 256)
        )

    end

    -- (Special handling for canteens from the "thirsty" mod)
    if outputstack == "unilib:item_canteen_bronze" then

        inv:set_stack(
            "dst", 1, {name = "unilib:item_canteen_bronze", count = 1, wear = 60, metadata = ""}
        )

    elseif outputstack == "unilib:item_canteen_steel" then

        inv:set_stack(
            "dst", 1, {name = "unilib:item_canteen_steel", count = 1, wear = 40, metadata = ""}
        )

    -- (All other compatible vessels)
    elseif unilib.pkg.shared_drinks.empty_size_table[outputstack] then

        inv:set_stack(
            "dst",
            1,
            unilib.pkg.shared_drinks.reverse_convert_table[outputstack] .. "_" .. fruit .. " " ..
                    able_to_fill
        )
        inv:set_stack("src", 1, outputstack .. " " .. leftover_count)

    end

end

function add_juice(liq_vol, ves_typ, ves_vol, pos, inputcount, leftover_count, inputstack)

    -- Adapted from drinks/drink_machines.lua, was drinks.drinks_liquid_add()

    local meta = core.get_meta(pos)
    local fullness = tonumber(meta:get_string("fullness"))
    local fruit = meta:get_string("fruit")
    local fruit_name = meta:get_string("fruit_name")
    local inv = meta:get_inventory()
    local fullness = fullness + (liq_vol * inputcount)

    meta:set_string("fullness", fullness)
    inv:set_stack("src", 1, ves_typ .. " " .. inputcount)
    inv:set_stack("dst", 1, inputstack .. " " .. leftover_count)
    meta:set_string(
        "infotext",
        S("@1 % full of @2 juice.", (math.floor((fullness / ves_vol) * 100)), fruit_name)
    )

    if ves_vol == 256 then

        meta:set_string(
            "formspec", unilib.pkg.shared_drinks.juice_storage_formspec(fruit_name, fullness, 256)
        )

    elseif ves_vol == 128 then

        meta:set_string(
            "formspec", unilib.pkg.shared_drinks.juice_storage_formspec(fruit_name, fullness, 128)
        )

    end

end

function register_vessel(data_table)

    -- Adapted from drinks/init.lua, was drinks.register_item()
    -- Registers a node, combining an empty vessel with a juice type
    --
    -- data_table compulsory fields:
    --      juice_type (str): e.g. "apple", the string used to identify a juice in the "drinks"
    --          mod's internal code
    --      part_vessel_name (str): e.g. "unilib:vessel_glass_with_juice", add the "juice_type" to
    --          get the actual item registered, e.g. "unilib:vessel_glass_with_juice_apple"
    --      orig_vessel_name (str): e.g. "drinks:jcu_apple"
    --      empty_name (str): e.g. "unilib:vessel_glass_empty"
    --      orig_empty_name (str): e.g. "vessels:drinking_glass"
    --
    -- data_table optional fields:
    --      description (str): e.g. "Glass of Apple Juice"
    --      group_table (str): e.g. {drink = 1}
    --      inventory_image (str): A texture name, colourised with the juice's RGB (so that we don't
    --          need separate textures for every juice type)
    --      juice_description (str): e.g. "Apple"
    --      on_use_func (func or nil): Function called when the player consumes the juice
    --      size (int): The number of units this vessel can contain, e.g. 2 for drinking glasses

    local juice_type = data_table.juice_type
    local part_vessel_name = data_table.part_vessel_name
    local orig_vessel_name = data_table.orig_vessel_name
    local empty_name = data_table.empty_name
    local orig_empty_name = data_table.orig_empty_name

    local description = data_table.description or S("Vessel of Juice")
    local group_table = data_table.group_table or {drink = 1}
    local inventory_image = data_table.inventory_image or "unilib_juice_vessel_glass.png"
    local juice_description = data_table.juice_description or S("Juice")
    local on_use_func = data_table.on_use_func or nil
    local size = data_table.size or 2

    local vessel_name = part_vessel_name .. "_" .. juice_type

    local empty_def_table = core.registered_nodes[orig_empty_name]
    if empty_def_table then

        local juice_def_table = table.copy(empty_def_table)
        juice_def_table.description = description
        juice_def_table.juice_description = juice_description
        juice_def_table.inventory_image = inventory_image
        juice_def_table.wield_image = inventory_image
        juice_def_table.on_use = on_use_func

        for k, v in pairs(group_table) do
            juice_def_table.groups[k] = v
        end

        if inventory_image then

            juice_def_table.tiles = {inventory_image}
            juice_def_table.wield_img = inventory_image

        end

        unilib.register_node(vessel_name, orig_vessel_name, mode, juice_def_table)

        unilib.pkg.shared_drinks.vessel_convert_table[vessel_name] = juice_type
        unilib.pkg.shared_drinks.empty_convert_table[vessel_name] = empty_name
        unilib.pkg.shared_drinks.reverse_convert_table[empty_name] = part_vessel_name
        unilib.pkg.shared_drinks.empty_size_table[empty_name] = size

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_drinks.retrieve_available(liq_vol, ves_vol, outputstack, pos, count)

    -- Adapted from drinks/drink_machines.lua, was drinks.drinks_liquid_avail_sub()

    local meta = core.get_meta(pos)
    local fullness = tonumber(meta:get_string("fullness"))

    if fullness - (liq_vol * count) < 0 then

        local able_to_fill = math.floor(fullness / liq_vol)
        local leftover_count = count - able_to_fill
        retrieve_juice(liq_vol, ves_vol, pos, able_to_fill, leftover_count, outputstack)

    elseif fullness - (liq_vol * count) >= 0 then

        retrieve_juice(liq_vol, ves_vol, pos, count, 0, outputstack)

    end

end

function unilib.pkg.shared_drinks.add_available(
    liq_vol, ves_typ, ves_vol, pos, inputstack, inputcount
)
    -- Adapted from drinks/drink_machines.lua, was drinks.drinks_liquid_avail_add()

    local meta = core.get_meta(pos)
    local fullness = tonumber(meta:get_string("fullness"))
    if fullness + (liq_vol * inputcount) > ves_vol then

        local avail_ves_vol = ves_vol - fullness
        local can_empty = math.floor(avail_ves_vol / liq_vol)
        local leftover_count = inputcount - can_empty
        add_juice(liq_vol, ves_typ, ves_vol, pos, can_empty, leftover_count, inputstack)

    elseif fullness + (liq_vol * inputcount) <= ves_vol then

        add_juice(liq_vol, ves_typ, ves_vol, pos, inputcount, 0, inputstack)

    end

end

function unilib.pkg.shared_drinks.juice_storage_formspec(fruit_name, fullness, max)

    -- Adapted from drinks/formspecs.lua, was drinks.liquid_storage_formspec()

    return "size[8,8]" ..
        "label[0,0;" .. FS("Fill with the juice of your choice") .. "]" ..
        "label[0,0.4;" .. FS("Only one type of juice can be stored") .. "]" ..
        "label[1,1.2;" .. FS("Add juice here") .. "]" ..
        "label[4,1.2;" .. FS("Storing @1 juice", fruit_name) .. "]" ..
        "label[4,1.7;" .. FS("Holding @1 of @2 fruits", (fullness / 2), (max / 2)) .. "]" ..
        "label[1,2.2;" .. FS("Retrieve juice here") .. "]" ..
        "button[0,3;3,1;purge;" .. FS("Discard juice") .. "]" ..
        "label[3,3.2;" .. FS("(This button completely empties the container)") .. "]" ..
        "list[current_name;src;0,1;1,1;]" ..
        "list[current_name;dst;0,2;1,1;]" ..
        "list[current_player;main;0,4;8,5;]"

end

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Table converting an ingredient's item name (e.g. "fruit_apple" in "unilib:fruit_apple") into the
--      "juice_type" used by code imported from the drinks mod (e.g. "apple")
-- Table in the form
--      ingredient_convert_table[item_name] = juice_type
unilib.pkg.shared_drinks.ingredient_convert_table = {}
-- Table converting a full vessel's name (e.g. "unilib:bucket_steel_with_juice_apple",
--      "unilib:vessel_glass_with_juice_apple") into the ingredient's "juice_type" (e.g. "apple")
unilib.pkg.shared_drinks.vessel_convert_table = {}
-- Table converting a full vessel's name into the equivalent empty vessel's item name (e.g.
--      "unilib:vessel_glass_empty")
unilib.pkg.shared_drinks.empty_convert_table = {}
-- Reverse table, converting an empty vessel's name into the partial full vessel's name; just add
--      the "juice_type" to that (e.g. "unilib:vessel_glass_empty" >
--      "unilib:vessel_glass_with_juice" + "apple" = "unilib:vessel_glass_with_juice_apple"
unilib.pkg.shared_drinks.reverse_convert_table = {}

-- Table specifying the size of an empty vessel
-- This table can also be used, whenever we need to check that an item is a compatible empty vessel
-- All compatible empty vessels are listed here, except for empty buckets, which are added below
unilib.pkg.shared_drinks.empty_size_table = {}
unilib.pkg.shared_drinks.empty_size_table["unilib:vessel_glass_empty"] = 2
unilib.pkg.shared_drinks.empty_size_table["unilib:vessel_bottle_glass_empty"] = 4
unilib.pkg.shared_drinks.empty_size_table["unilib:vessel_bottle_steel_empty"] = 4
unilib.pkg.shared_drinks.empty_size_table["unilib:item_canteen_bronze"] = 30
unilib.pkg.shared_drinks.empty_size_table["unilib:item_canteen_steel"] = 20

-- Was drinks.juiceable
-- Table showing which items can be placed in the juice press. Table in the form
--      juiceable_table[juice_type] = true
unilib.pkg.shared_drinks.juiceable_table = {}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_drinks.init()

    return {
        description = "Shared functions for juice containers (from the drinks mod)",
        notes = "See also the \"utensil_press_hand\" package, which creates some squeezed drinks" ..
                " that are nothing to do with this code's original mod",
    }

end

function unilib.pkg.shared_drinks.post()

    -- Set up local variables using the global variable which stores all registered juice types
    for juice_type, mini_table in pairs(unilib.global.generic_juice_table) do

        local glass_orig_name, bottle_orig_name, steel_orig_name
        if mini_table.orig_flag then

            glass_orig_name = "drinks:jcu_" .. juice_type
            bottle_orig_name = "drinks:jbo_" .. juice_type
            steel_orig_name = "drinks:jsb_" .. juice_type

        end

        unilib.pkg.shared_drinks.juiceable_table[juice_type] = true
        for _, ingredient in pairs(mini_table.ingredient_list) do

            local item_name = unilib.utils.get_item_name(ingredient)
            unilib.pkg.shared_drinks.ingredient_convert_table[item_name] = juice_type

        end

        for bucket_type, _ in pairs(unilib.global.generic_bucket_table) do

            local part_vessel_name = "unilib:" .. bucket_type .. "_with_juice"
            local vessel_name = part_vessel_name .. "_" .. juice_type
            local empty_name = "unilib:" .. bucket_type .. "_empty"
            local img = "unilib_" .. bucket_type .. "_empty.png" ..
                    "^(unilib_juice_contents_bucket.png^[colorize:" .. mini_table.rgb .. ":200)"

            local orig_name = nil
            if bucket_type == "bucket_steel" and mini_table.orig_flag then
                orig_name = "drinks:jbu_" .. juice_type
            end

            -- N.B. Converted the original node to a craftitem, to match other unilib buckets
            -- If this change is reverted, then code in the "container_barrel_juice" and
            --      "container_silo_juice" packages, that checks both registered nodes and
            --      craftitems, can be simplified
            -- N.B. These buckets cannot be used for drinking, they are for moving liquids between
            --          barrels/silos
            -- N.B. These buckets cannot be emptied onto the ground (as a bucket of water could). To
            --      show the difference, the overlay texture for these buckets doesn't have a drip
            --      to one side
            --[[
            unilib.register_node(vessel_name, orig_name, mode, {
                -- From drinks:jbu_apple, etc
                description = S("Bucket of @1 Juice", mini_table.juice_description),
                tiles = {img},
                groups = {attached_node = 1, dig_immediate = 3, drink = 1, vessel = 1},
                sounds = unilib.global.sound_table.node,

                drawtype = "plantlike",
                inventory_image = img,
                is_ground_content = false,
                juice_description = mini_table.juice_description,
                paramtype = "light",
                selection_box = {
                    type = "fixed",
                    fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25},
                },
                walkable = false,
                wield_image = img,
            })
            ]]--
            unilib.register_craftitem(vessel_name, orig_name, mode, {
                -- From drinks:jbu_apple, etc
                description = S("Bucket of @1 Juice", mini_table.juice_description),
                inventory_image = img,
                groups = {tool = 1},

                juice_description = mini_table.juice_description,
                liquids_pointable = true,
                stack_max = 99,
            })
            unilib.pkg.shared_drinks.vessel_convert_table[vessel_name] = juice_type
            unilib.pkg.shared_drinks.empty_convert_table[vessel_name] = empty_name
            unilib.pkg.shared_drinks.reverse_convert_table[empty_name] = part_vessel_name
            unilib.pkg.shared_drinks.empty_size_table[empty_name] = 16

        end

        -- N.B. In original code, when hydration is enabled, a bottle hydrates a player twice as
        --      much as a glass
        -- unilib code (in ../lib/effects/cuisine/) fully hydrates the player after drinking any
        --      drink, including these glasses/bottles of juice

        register_vessel({
            juice_type = juice_type,
            part_vessel_name = "unilib:vessel_glass_with_juice",
            orig_vessel_name = glass_orig_name,
            empty_name = "unilib:vessel_glass_empty",
            orig_empty_name = "vessels:drinking_glass",

            description = S("Glass of @1 Juice", mini_table.juice_description),
            group_table = {drink = 1},
            inventory_image = "unilib_juice_contents_glass.png" ..
                    "^[colorize:" .. mini_table.rgb .. ":200^unilib_juice_vessel_glass.png",
            juice_description = mini_table.juice_description,
            size = 2,

            on_use_func = unilib.cuisine.drink_on_use(
                "unilib:vessel_glass_with_juice_" .. juice_type,
                mini_table.health,
                "unilib:vessel_glass_empty",
                nil,
                true            -- Update both satiation and hydration
            ),
        })

        register_vessel({
            juice_type = juice_type,
            part_vessel_name = "unilib:vessel_bottle_glass_with_juice",
            orig_vessel_name = bottle_orig_name,
            empty_name = "unilib:vessel_bottle_glass_empty",
            orig_empty_name = "vessels:glass_bottle",

            description = S("Bottle of @1 Juice", mini_table.juice_description),
            group_table = {drink = 1},
            inventory_image = "unilib_juice_contents_bottle.png" ..
                    "^[colorize:" .. mini_table.rgb .. ":200^unilib_juice_vessel_bottle.png",
            juice_description = mini_table.juice_description,
            size = 4,

            on_use_func = unilib.cuisine.drink_on_use(
                "unilib:vessel_bottle_glass_with_juice_" .. juice_type,
                mini_table.health * 2,
                "unilib:vessel_bottle_glass_empty",
                nil,
                true            -- Update both satiation and hydration
            ),
        })

        register_vessel({
            juice_type = juice_type,
            part_vessel_name = "unilib:vessel_bottle_steel_with_juice",
            orig_vessel_name = steel_orig_name,
            empty_name = "unilib:vessel_bottle_steel_empty",
            orig_empty_name = "vessels:steel_bottle",

            description = S("Steel Bottle of @1 Juice", mini_table.juice_description),
            group_table = {drink = 1},
            inventory_image = "unilib_vessel_bottle_steel_empty.png",
            juice_description = mini_table.juice_description,
            size = 4,

            on_use_func = unilib.cuisine.drink_on_use(
                "unilib:vessel_bottle_steel_with_juice_" .. juice_type,
                mini_table.health * 2,
                "unilib:vessel_bottle_steel_empty",
                nil,
                true            -- Update both satiation and hydration
            ),
        })

    end

end
