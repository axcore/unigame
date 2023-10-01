---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes_classic
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_bushes_classic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bushes_classic.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function after_dig_node(pos, oldnode, oldmetadata, digger)

    if not (digger and pos and oldnode) then
        return
    end

    -- Find out which bush type we are dealing with
    local bush_name = ""
    local can_harvest = false

    if oldnode.name == "unilib:bush_ornamental_fruitless" then

        -- This bush has not grown fruits yet (but will eventually)
        bush_name = oldmetadata.fields.bush_type
        -- (No fruits to be found, so "can_harvest" stays false)

    else

        bush_name = unilib.get_last_component(oldnode.name)
        -- This bush really carries fruits
        can_harvest = true

    end

    -- Find out which tool the digger was wielding (if any)
    local toolstack = digger:get_wielded_item()
    local capabilities = toolstack:get_tool_capabilities()

    -- What the player will get (e.g. "unilib:fruit_strawberry_picked 4")
    local harvested

    -- Failure to find out what the tool can do: destroy the bush and return nothing
    local groupcaps = capabilities.groupcaps
    if not groupcaps then

        return

    -- Digging by hand or something like that
    elseif groupcaps.snappy then

        -- Plant a new bush without fruits
        minetest.swap_node(pos, {type = "node", name = "unilib:bush_ornamental_fruitless"})
        local meta = minetest.get_meta(pos)
        meta:set_string('bush_type', bush_name)

        -- Construct the stack of fruits the player will get
        -- Only bushes that have grown fruits can actually give fruits
        if can_harvest then

            local amount = "4"
            harvested = "unilib:fruit_" .. bush_name .. "_picked " .. amount

        end

    -- Digging with something like a shovel
    elseif groupcaps.crumbly then

        -- With a chance of 1/3, return 2 bushes
        local amount
        if math.random(1,3) == 1 then
            amount = "2"
        else
            amount = "1"
        end

        -- Return the bush itself
        harvested = "unilib:bush_ornamental_" .. bush_name .. " " .. amount

    -- Digging with something like an axe
    elseif groupcaps.choppy then

        -- Return some sticks (the amount may vary)
        local amount = math.random(4, 20)
        harvested = "unilib:item_stick_ordinary " .. amount

    -- Otherwise destroy the bush
    else

        return

    end

    -- Give the result of the harvesting to the player
    if harvested then

        local itemstack = ItemStack(harvested)
        local inventory = digger:get_inventory()
        if inventory:room_for_item("main", itemstack) then
            inventory:add_item("main", itemstack)
        else
            minetest.item_drop(itemstack, digger, pos)
        end

    end

end

local function after_place_node(pos, placer, itemstack)

    if not (itemstack and pos) then
        return
    end

    minetest.swap_node(pos, {name = "unilib:bush_ornamental_fruitless"})

    local meta = minetest.get_meta(pos)
    local bush_name = unilib.get_last_component(itemstack:get_name())
    meta:set_string("bush_type", bush_name)

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_bushes_classic.register_bush(data_table)

    -- Adapted from bushes_classic/cooking.lua
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "strawberry", "fruitless"
    --      orig_name (str): e.g. "bushes:strawberry_bush", "bushes:fruitless_bush"
    --
    -- data_table optional fields:
    --      description (str): e.g. "Ornamental Strawberry Bush", "Fruitless Ornamental Bush"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local description = data_table.description or S("Ornamental Bush")

    local group_table = {attached_node = 1, bush = 1, flammable = 2, snappy = 3}
    if part_name == "fruitless" then
        group_table.not_in_creative_inventory = 1
    end

    unilib.register_node("unilib:bush_ornamental_" .. part_name, orig_name, mode, {
        description = description,
        tiles = {"unilib_bush_ornamental_" .. part_name .. ".png"},
        groups = group_table,
        sounds = unilib.sound_table.leaves,

        drawtype = "mesh",
        drop = "",
        mesh = "unilib_bush_ornamental.obj",
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,

        after_dig_node = function(pos, oldnode, oldmetadata, digger)
            return after_dig_node(pos, oldnode, oldmetadata, digger)
        end,

        after_place_node = function(pos, placer, itemstack)
            return after_place_node(pos, placer, itemstack)
        end,
    })

end

function unilib.pkg.shared_bushes_classic.register_berry(data_table)

    -- Adapted from bushes_classic/cooking.lua
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "strawberry" (the "fruitless" bush does not produce berries)
    --      orig_name (str): e.g. "bushes:strawberry"
    --
    -- data_table optional fields:
    --      description (str): e.g. "Picked Strawberry"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local description = data_table.description or S("Picked Berry")

    local full_name = "unilib:fruit_" .. part_name .. "_picked"
    local group_table = {food_berry = 1, flammable = 2}
    group_table["food_" .. part_name] = 1

    unilib.register_craftitem(full_name, orig_name, mode, {
        description = description,
        inventory_image = "unilib_fruit_" .. part_name .. "_picked.png",
        groups = group_table,

        on_use = unilib.cuisine_eat_on_use(full_name, 1),
    })

end

function unilib.pkg.shared_bushes_classic.register_pie(data_table)

    -- Adapted from bushes_classic/cooking.lua
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "strawberry", "mixed"
    --      basket_orig_name (str): "bushes:basket_strawberry", "bushes:basket_mixed_berry"
    --      cooked_orig_name (str): "bushes:strawberry_pie_cooked", "bushes:mixed_berry_pie_cooked"
    --      raw_orig_name (str): "bushes:strawberry_pie_raw", "bushes:mixed_berry_pie_raw"
    --      slice_orig_name (str): "bushes:strawberry_pie_slice", "bushes:mixed_berry_pie_slice"
    --
    -- data_table optional fields:
    --       basket_description (str): e.g. "Basket with Strawberry Pies",
    --          "Basket with Mixed Berry Pies"
    --       cooked_description (str): e.g. "Cooked Strawberry Pie", "Cooked Mixed Berry Pie"
    --       raw_description (str): e.g. "Raw Strawberry Pie", "Raw Mixed Berry Pie"
    --       slice_description (str): e.g. "Slice of Strawberry Pie", "Slice of Mixed Berry Pie"

    local part_name = data_table.part_name
    local basket_orig_name = data_table.basket_orig_name
    local cooked_orig_name = data_table.cooked_orig_name
    local raw_orig_name = data_table.raw_orig_name
    local slice_orig_name = data_table.slice_orig_name

    local basket_description = data_table.basket_description or S("Basket with Pies")
    local cooked_description = data_table.cooked_description or S("Cooked Pie")
    local raw_description = data_table.raw_description or S("Raw Pie")
    local slice_description = data_table.slice_description or S("Slice of Pie")

    local basket_full_name = "unilib:item_basket_with_pie_" .. part_name
    local cooked_full_name = "unilib:food_pie_" .. part_name .. "_cooked"
    local raw_full_name = "unilib:food_pie_" .. part_name .. "_raw"
    local slice_full_name = "unilib:food_pie_" .. part_name .. "_slice"

    -- Raw pie
    unilib.register_craftitem(raw_full_name, raw_orig_name, mode, {
        description = raw_description,
        inventory_image = "unilib_food_pie_" .. part_name .. "_raw.png",
        -- N.B. No groups in original code
        groups = {food_pie = 1},

        on_use = unilib.cuisine_eat_on_use(raw_full_name, 4),
    })
    if part_name ~= "mixed" then

        local c_food = "group:food_" .. part_name

        unilib.register_craft({
            output = raw_full_name,
            recipe = {
                {"group:food_sugar", "group:food_flour", "group:food_sugar"},
                {c_food, c_food, c_food},
            },
        })

    else

        unilib.register_craft({
            output = raw_full_name .. " 2",
            recipe = {
                {"group:food_sugar", "group:food_flour", "group:food_sugar"},
                {"group:food_berry", "group:food_berry", "group:food_berry"},
                {"group:food_berry", "group:food_berry", "group:food_berry"},
            },
        })

    end

    -- Cooked pie
    unilib.register_craftitem(cooked_full_name, cooked_orig_name, mode, {
        description = cooked_description,
        inventory_image = "unilib_food_pie_" .. part_name .. "_cooked.png",
        -- N.B. No groups in original code
        groups = {food_pie = 1},

        on_use = unilib.cuisine_eat_on_use(cooked_full_name, 6),
    })
    unilib.register_craft({
        type = "cooking",
        output = cooked_full_name,
        recipe = raw_full_name,
        cooktime = 30,
    })

    -- Slice of pie
    unilib.register_craftitem(slice_full_name, slice_orig_name, mode, {
        description = slice_description,
        inventory_image = "unilib_food_pie_" .. part_name .. "_slice.png",
        -- N.B. No groups in original code
        groups = {food_pie = 1},

        on_use = unilib.cuisine_eat_on_use(slice_full_name, 1),
    })
    unilib.register_craft({
        output = slice_full_name .. " 6",
        recipe = {
            {cooked_full_name},
        },
    })

    -- Basket with pies
    unilib.register_node(basket_full_name, basket_orig_name, mode, {
        description = basket_description,
        tiles = {"unilib_item_basket_with_pie_" .. part_name .. ".png", "unilib_item_basket.png"},
        -- N.B. no food_pie in original code
        groups = {dig_immediate = 3, food_pie = 1},
        -- (no sounds)

        drawtype = "mesh",
        mesh = "unilib_item_basket_full.obj",
        paramtype = "light",
        paramtype2 = "facedir",

        on_use = unilib.cuisine_eat_on_use(basket_full_name, 18),
    })
    unilib.register_craft({
        output = basket_full_name,
        recipe = {
            {cooked_full_name, cooked_full_name, cooked_full_name},
            {"", "unilib:item_basket", ""},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_bushes_classic.init()

    return {
        description = "Shared functions for ornamental bushes (from bushes_classic mod)",
        notes = "Bushes from plantlife/bushes_classic can only be dug using a suitable tool," ..
                " such as an axe. Otherwise, punching the bushes harvests their berries",
        depends = {"ingredient_flour_ordinary", "item_stick_ordinary"},
    }

end

function unilib.pkg.shared_bushes_classic.exec()

    unilib.pkg.shared_bushes_classic.register_pie({
        -- Provides unilib:item_basket_with_pie_mixed, unilib:food_pie_mixed_cooked,
        --      unilib:food_pie_mixed_raw, unilib:food_pie_mixed_slice
        part_name = "mixed",
        basket_orig_name = "bushes:basket_mixed_berry",
        cook_orig_name = "bushes:mixed_berry_pie_cooked",
        raw_orig_name = "bushes:mixed_berry_pie_raw",
        slice_orig_name = "bushes:mixed_berry_pie_slice",

        basket_description = S("Basket with Mixed Berry Pies"),
        cook_description = S("Cooked Mixed Berry Pie"),
        raw_description = S("Raw Mixed Berry Pie"),
        slice_description = S("Slice of Mixed Berry Pie"),
    })

    -- (Do not spawn fruitless bushes. Any of the bushes which are not added by a package are
    --      ignored by Minetest)
    -- N.B. Original decoration code required specific light/humidity/temperature. This has been
    --      omitted for simplicity
    unilib.register_decoration("bushes_classic_bush_ornamental", {
        deco_type = "simple",
        decoration = {
            "unilib:bush_ornamental_blackberry",
            "unilib:bush_ornamental_blueberry",
            "unilib:bush_ornamental_gooseberry",
            "unilib:bush_ornamental_raspberry",
            "unilib:bush_ornamental_strawberry",
        },

        fill_ratio = unilib.biome_lib_fill_ratio,
    })

end
