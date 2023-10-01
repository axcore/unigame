---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.container_barrel_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function can_dig(pos, player)

    -- Can only dig the barrel if there are no more vessels/buckets in either slot
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()

    return inv:is_empty("input") and inv:is_empty("output")

end

local function on_metadata_inventory_put(pos, listname, index, stack, player)

    -- The barrel received input; either a new liquid that is to be poured in or a vessel that is to
    --      be filled

    -- (no code)

end

local function on_construct(pos)

    -- Prepares the formspec

    local meta = minetest.get_meta(pos)
    local percent = math.random(1, 100)

    meta:set_string(
        "formspec",
        "size[8,9]" ..
        "image[2.6,2;2,3;unilib_stone_sandstone_ordinary.png^[lowpart:" .. (100 - percent) ..
                ":unilib_stone_desert.png]" ..
        "label[2.2,0;" .. S("Pour") .. ":]" ..
        "list[current_name;input;3,0.5;1,1;]" ..
        "label[5,3.3;" .. S("Fill") .. ":]" ..
        "list[current_name;output;5,3.8;1,1;]" ..
        "list[current_player;main;0,5;8,4;]"
    )

    -- Which liquid is in the barrel, and how much?
    meta:set_string("liquid_type", "")
    meta:set_int("liquid_level", 0)

    local inv = meta:get_inventory()

    inv:set_size("input", 1)
    inv:set_size("output", 1)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_barrel_normal.init()

    return {
        description = "Normal barrel (to contain liquids)",
        notes = "Punch to change between horizontal/vertical position, right-click to open/close" ..
                " the barrel",
        depends = {"metal_steel", "misc_tub"},
    }

end

function unilib.pkg.container_barrel_normal.exec()

    -- The barrel contains a lot of nodeboxes, which may be too much for weaker hardware
    if unilib.cottages_slow_flag then
        return
    end

    -- (Upright barrel)
    unilib.register_node("unilib:container_barrel_normal", "cottages:barrel", mode, {
        -- From cottages:barrel
        description = unilib.brackets(S("Normal Barrel"), S("Closed")),
        tiles = {"unilib_container_barrel_normal.png"},
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, snappy = 1, tree = 1},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.wood,

        drawtype = "mesh",
        drop = "unilib:container_barrel_normal",
        is_ground_content = false,
        mesh = "unilib_container_barrel_normal.obj",
        paramtype = "light",

        can_dig = function(pos,player)
            return can_dig(pos, player)
        end,

        on_construct = function(pos)
            return on_construct(pos)
        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)
            return on_metadata_inventory_put(pos, listname, index, stack, player)
        end,

        on_punch = function(pos, node, puncher)

            minetest.add_node(
                pos,
                {name = "unilib:container_barrel_normal_horizontal", param2 = node.param2}
            )

        end,
    })

    -- (Upright barrel, open)
    unilib.register_node("unilib:container_barrel_normal_open", "cottages:barrel_open", mode, {
        -- From cottages:barrel_open
        description = unilib.brackets(S("Normal Barrel"), S("Open")),
        tiles = {"unilib_container_barrel_normal.png"},
        groups = {
            choppy = 2, flammable = 2, not_in_creative_inventory = 1, oddly_breakable_by_hand = 1,
            snappy = 1, tree = 1,
        },
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.wood,

        drawtype = "mesh",
        drop = "unilib:container_barrel_normal",
        is_ground_content = false,
        mesh = "unilib_container_barrel_normal_open.obj",
        paramtype = "light",

        on_punch = function(pos, node, puncher)

            minetest.add_node(
                pos,
                {name = "unilib:container_barrel_normal_horizontal_open", param2 = node.param2}
            )
        end,
    })

    -- (Horizontal barrel)
    unilib.register_node(
        "unilib:container_barrel_normal_horizontal",
        "cottages:barrel_lying",
        mode,
        {
            -- From cottages:barrel_lying
            description = unilib.brackets(S("Horizontal Normal Barrel"), S("Closed")),
            tiles = {"unilib_container_barrel_normal.png"},
            groups = {
                choppy = 2, flammable = 2, not_in_creative_inventory = 1,
                oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
            },
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            drawtype = "mesh",
            drop = "unilib:container_barrel_normal",
            is_ground_content = false,
            mesh = "unilib_container_barrel_normal_horizontal.obj",
            paramtype = "light",
            paramtype2 = "facedir",

            on_punch = function(pos, node, puncher)

                if node.param2 < 4 then

                    minetest.add_node(
                        pos,
                        {
                            name = "unilib:container_barrel_normal_horizontal",
                            param2 = (node.param2 + 1)
                        }
                    )

                else

                    minetest.add_node(pos, {name = "unilib:container_barrel_normal", param2 = 0})

                end

            end,

            on_rightclick = function(pos, node, puncher)

                minetest.add_node(
                    pos,
                    {name = "unilib:container_barrel_normal_horizontal_open", param2 = node.param2}
                )

            end,
        }
    )

    -- (Horizontal barrel, open)
    unilib.register_node(
        -- From cottages:barrel_lying_open
        "unilib:container_barrel_normal_horizontal_open",
        "cottages:barrel_lying_open",
        mode,
        {
            description = unilib.brackets(S("Horizontal Normal Barrel"), S("Open")),
            tiles = {"unilib_container_barrel_normal.png"},
            groups = {
                choppy = 2, flammable = 2, not_in_creative_inventory = 1,
                oddly_breakable_by_hand = 1, snappy = 1, tree = 1,
            },
            -- N.B. no sounds in original code
            sounds = unilib.sound_table.wood,

            drawtype = "mesh",
            drop = "unilib:container_barrel_normal",
            is_ground_content = false,
            mesh = "unilib_container_barrel_normal_horizontal_open.obj",
            paramtype = "light",
            paramtype2 = "facedir",

            on_punch = function(pos, node, puncher)

                if node.param2 < 4 then

                    minetest.add_node(
                        pos,
                        {
                            name = "unilib:container_barrel_normal_horizontal_open",
                            param2 = (node.param2 + 1),
                        }
                    )

                else

                    minetest.add_node(
                        pos,
                        {name = "unilib:container_barrel_normal_open", param2 = 0}
                    )

                end

            end,

            on_rightclick = function(pos, node, puncher)

                minetest.add_node(
                    pos,
                    {name = "unilib:container_barrel_normal_horizontal", param2 = node.param2}
                )

            end,
        }
    )

    -- (Craft recipes)
    unilib.register_craft({
        -- From cottages:barrel
        output = "unilib:container_barrel_normal",
        recipe = {
            {"group:wood", "", "group:wood" },
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })
    unilib.register_craft({
        -- From cottages:barrel
        output = "unilib:container_barrel_normal",
        recipe = {
            {"unilib:misc_tub"},
            {"unilib:misc_tub"},
        },
    })

    unilib.register_craft({
        -- From cottages:tub
        output = "unilib:misc_tub 2",
        recipe = {
            {"unilib:container_barrel_normal"},
        },
    })

end
