---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_hive_artificial = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xdecor.add_mode

-- Maximum honey that each hive can store
local honey_max = 16
-- Minimum time (in seconds) to produce one honey
local honey_time = 64

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_construct(pos)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()

    local formspec = "size[8,6;]" ..
            "label[0.5,0;" .. S("Bees are making honey...") .. "]" ..
            "image[6,1;1,1;unilib_misc_hive_artificial_bee.png]" ..
            "image[5,1;1,1;unilib_misc_hive_artificial_bg.png]" ..
            "list[context;honey;5,1;1,1;]" ..
            "list[current_player;main;0,2.35;8,4;]" ..
            "listring[current_player;main]" ..
            "listring[context;honey]" ..
            unilib.get_hotbar_bg(0, 2.35)

    meta:set_string("formspec", formspec)
    meta:set_string("infotext", S("Artificial Hive"))
    inv:set_size("honey", 1)

    local timer = minetest.get_node_timer(pos)
    timer:start(math.random(honey_time, (honey_time * 2)))

end

local function on_timer(pos)

    local time = (minetest.get_timeofday() or 0) * 24000

    -- Honey only during daylight hours
    if time < 5500 or time > 18500 then
        return true
    end

    local inv = minetest.get_meta(pos):get_inventory()
    local honeystack = inv:get_stack("honey", 1)
    local honey = honeystack:get_count()

    local radius = 4
    local minp = vector.add(pos, -radius)
    local maxp = vector.add(pos, radius)
    local flowers = minetest.find_nodes_in_area_under_air(minp, maxp, "group:flower")

    if #flowers > 2 and honey < honey_max then

        inv:add_item("honey", "unilib:food_honey_synthetic")

    elseif honey == honey_max then

        local timer = minetest.get_node_timer(pos)
        timer:stop()
        return true

    end

    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_hive_artificial.init()

    return {
        description = "Artificial hive",
        notes = "When placed near flowers, the (invisible) bees produce synthetic honey",
        depends = "item_paper_ordinary",
    }

end

function unilib.pkg.misc_hive_artificial.exec()

    local c_paper = "unilib:item_paper_ordinary"

    unilib.register_node("unilib:misc_hive_artificial", "xdecor:hive", mode, {
        -- From xdecor:hive
        description = S("Artificial Hive"),
        tiles = {
            "unilib_misc_hive_artificial_top.png",
            "unilib_misc_hive_artificial_top.png",
            "unilib_misc_hive_artificial_side.png",
            "unilib_misc_hive_artificial_side.png",
            "unilib_misc_hive_artificial_side.png",
            "unilib_misc_hive_artificial_front.png",
        },
        groups = {choppy = 3, flammable = 1, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.node,

        paramtype2 = "facedir",

        allow_metadata_inventory_put = function()
            return 0
        end,

        can_dig = function(pos)

            local inv = minetest.get_meta(pos):get_inventory()
            return inv:is_empty("honey")

        end,

        on_construct = on_construct,

        on_punch = function(_, _, puncher)
            puncher:set_hp(puncher:get_hp() - 2)
        end,

        on_timer = on_timer,

        on_metadata_inventory_take = function(pos, _, _, stack)

            if stack:get_count() == honey_max then

                local timer = minetest.get_node_timer(pos)
                timer:start(math.random(honey_time, (honey_time * 2)))

            end

        end
    })
    --[[
    unilib.register_craft({
        -- From xdecor:hive
        output = "unilib:misc_hive_artificial",
        recipe = {
            {"group:stick", "group:stick", "group:stick"},
            {c_paper, c_paper, c_paper},
            {"group:stick", "group:stick", "group:stick"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From xdecor:hive
        output = "unilib:misc_hive_artificial",
        recipe = {
            {"group:stick", "group:food_honey", "group:stick"},
            {c_paper, c_paper, c_paper},
            {"group:wood", "group:food_honey", "group:wood"},
        },
    })

end
