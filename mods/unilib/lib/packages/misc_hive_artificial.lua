---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_hive_artificial = {}

local S = unilib.intllib
local F = core.formspec_escape
local mode = unilib.global.imported_mod_table.xdecor.add_mode

-- The radius within which flowers must exist, in order for bees to collect honey
local hive_radius = 4
-- Minimum number of flowers within that radius, before bees collect honey
local flower_min = 3

-- Maximum honey that each hive can store
local honey_max = 16
-- Minimum time (in seconds) to produce one honey
local honey_time = 64
-- To avoid switching formspecs constantly, record the last formspec used
local last_formspec = nil

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function set_formspec(meta, status)

    local msg
    if status == "night" then
        msg = S("The bees are sleeping")
    elseif status == "working" then
        msg = S("The bees are making honey")
    elseif status == "full" then
        msg = S("The hive is full of honey!")
    else
        msg = S("The bees need more flowers!")
    end

    -- N.B. formspec tweaked for aesthetics
    --[[
    local formspec = "size[8,6;]" ..
            "label[0.5,0;" .. msg .. "]" ..
            "image[6,1;1,1;unilib_misc_hive_artificial_bee.png]" ..
            "image[5,1;1,1;unilib_misc_hive_artificial_bg.png]" ..
            "list[context;honey;5,1;1,1;]" ..
            "list[current_player;main;0,2.35;8,4;]" ..
            "listring[current_player;main]" ..
            "listring[context;honey]" ..
            unilib.misc.get_hotbar_bg(0, 2.35)
    ]]--
    local formspec = "size[8,5;]" ..
            "label[0.5,0.2;" .. F(msg) .. "]" ..
            "image[6.5,0;1,1;unilib_misc_hive_artificial_bee.png]" ..
            "image[5.5,0;1,1;unilib_misc_hive_artificial_bg.png]" ..
            "list[context;honey;5.5,0;1,1;]" ..
            "list[current_player;main;0,1.35;8,4;]" ..
            "listring[current_player;main]" ..
            "listring[context;honey]" ..
            unilib.misc.get_hotbar_bg(0, 2.35)

    meta:set_string("formspec", formspec)

    last_formspec = status

end

local function on_construct(pos)

    local meta = core.get_meta(pos)
    set_formspec(meta, "need_flowers")
    meta:set_string("infotext", S("Artificial Hive"))

    local inv = meta:get_inventory()
    inv:set_size("honey", 1)

    local timer = core.get_node_timer(pos)
    timer:start(math.random(honey_time, (honey_time * 2)))

end

local function on_timer(pos)

    local timeofday = (core.get_timeofday() or 0) * 24000
    local meta = core.get_meta(pos)

    -- Honey only during daylight hours
    if timeofday < 5500 or timeofday > 18500 then

        if last_formspec ~= "night" then
            set_formspec(meta, "night")
        end

        return true

    end

    local inv = core.get_meta(pos):get_inventory()
    local honeystack = inv:get_stack("honey", 1)
    local honey = honeystack:get_count()

    local minp = vector.add(pos, -hive_radius)
    local maxp = vector.add(pos, hive_radius)
    local flowers = core.find_nodes_in_area_under_air(minp, maxp, "group:flower")

    if honey >= honey_max then

        if last_formspec ~= "full" then
            set_formspec(meta, "full")
        end

        local timer = core.get_node_timer(pos)
        timer:stop()
        return true

    elseif #flowers >= flower_min then

        if last_formspec ~= "working" then
            set_formspec(meta, "working")
        end

        inv:add_item("honey", "unilib:food_honey_synthetic")

    else

        if last_formspec ~= "need_flowers" then
            set_formspec(meta, "need_flowers")
        end

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
        sounds = unilib.global.sound_table.node,

        -- N.B. is_ground_content = false not in original code; added to match other rooves
        is_ground_content = false,
        paramtype2 = "facedir",

        allow_metadata_inventory_put = function()
            return 0
        end,

        can_dig = function(pos)

            local inv = core.get_meta(pos):get_inventory()
            return inv:is_empty("honey")

        end,

        on_construct = on_construct,

        on_punch = function(_, _, puncher)
            puncher:set_hp(puncher:get_hp() - 2)
        end,

        on_timer = on_timer,

        on_metadata_inventory_take = function(pos, _, _, stack)

            if stack:get_count() == honey_max then

                local timer = core.get_node_timer(pos)
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
