---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_pie = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pie.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Package dependencies for the replacement items are handled by this package, in the .init()
--      function
unilib.pkg.shared_pie.replace_table = {
    {"animalia:bucket_milk", "unilib:bucket_steel_empty"},
    {"mobs:bucket_milk", "unilib:bucket_steel_empty"},
    {"mobs:wooden_bucket_milk", "unilib:bucket_wood_empty"},
    {"petz:bucket_milk", "unilib:bucket_steel_empty"},
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function replace_pie(pos, node, puncher)

    -- Is this my pie?
    if core.is_protected(pos, puncher:get_player_name()) then
        return
    end

    -- How much pie is left? (range 1-4)
    local pie_name = node.name:sub(1, -3)
    local pie_num = tonumber(node.name:sub(-1))

    -- Are we using a crystal shovel to pick up full pie using soft touch?
    local tool = puncher:get_wielded_item():get_name()
    if pie_num == 1 and tool == "unilib:tool_shovel_crystallite" then

        local inv = puncher:get_inventory()
        core.remove_node(pos)

        if inv:room_for_item("main", {name = pie_name .. "_1"}) then

            inv:add_item("main", pie_name .. "_1")

        else

            pos.y = pos.y + 0.5
            core.add_item(pos, {name = pie_name .. "_1"})

        end

        return

    end

    -- Eat a slice, or remove the whole pie
    if pie_num == 4 then
        node.name = "air"
    else
        node.name = pie_name .. "_" .. (pie_num + 1)
    end

    core.swap_node(pos, node)

    -- Update health. The call to unilib.cuisine.eat_on_use() is normally an item's .on_use()
    --      function, so we have to obtain that function, then call it
    local return_func = unilib.cuisine.eat_on_use(pie_name .. "_" .. pie_num, 4)
    return_func(ItemStack(pie_name .. "_" .. pie_num), puncher, node)

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_pie.register_baking(data_table)

    -- Register a baking item (used for cakes, pies etc)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "cake_banana"
    --      orig_part_name (str): e.g. "bana"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Banana Cake"

    local part_name = data_table.part_name
    local orig_part_name = data_table.orig_part_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Pie")

    local screwdriver_flag = false
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then
        screwdriver_flag = true
    end

    -- Full size
    unilib.register_node(
        "unilib:" .. part_name .. "_1",
        "pie:" .. orig_part_name .. "_0",
        replace_mode,
        {
            description = description,
            tiles = {
                "unilib_" .. part_name .. "_top.png",
                "unilib_" .. part_name .. "_bottom.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_side.png",
            },
            -- (no groups)
            sounds = unilib.global.sound_table.dirt,

            drawtype = "nodebox",
            inventory_image = "unilib_" .. part_name .. "_inv.png",
            -- N.B. is_ground_content = false not in original code; added to match other food items
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {-0.45, -0.5, -0.45, 0.45, 0, 0.45},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = false,
            use_texture_alpha = "clip",
            wield_image = "unilib_" .. part_name .. "_inv.png",

            on_punch = function(pos, node, puncher, pointed_thing)
                replace_pie(pos, node, puncher)
            end,

            on_rotate = screwdriver_flag and unilib.pkg.shared_screwdriver.rotate_simple,
        }
    )

    -- 3/4 size
    unilib.register_node(
        "unilib:" .. part_name .. "_2",
        "pie:" .. orig_part_name .. "_1",
        replace_mode,
        {
            description = unilib.utils.brackets(description, S("Three-Quarter Size")),
            tiles = {
                "unilib_" .. part_name .. "_top.png",
                "unilib_" .. part_name .. "_bottom.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_inside.png",
            },
            groups = {not_in_creative_inventory = 1},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "nodebox",
            drop = "",
            -- N.B. is_ground_content = false not in original code; added to match other food items
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {-0.45, -0.5, -0.25, 0.45, 0, 0.45},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "clip",

            on_punch = function(pos, node, puncher, pointed_thing)
                replace_pie(pos, node, puncher)
            end,

            on_rotate = screwdriver_flag and unilib.pkg.shared_screwdriver.rotate_simple,
        }
    )

    -- 1/2 size
    unilib.register_node(
        "unilib:" .. part_name .. "_3",
        "pie:" .. orig_part_name .. "_2",
        replace_mode,
        {
            description = unilib.utils.brackets(description, S("Half Size")),
            tiles = {
                "unilib_" .. part_name .. "_top.png",
                "unilib_" .. part_name .. "_bottom.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_inside.png",
            },
            groups = {not_in_creative_inventory = 1},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "nodebox",
            drop = "",
            -- N.B. is_ground_content = false not in original code; added to match other food items
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {-0.45, -0.5, 0.0, 0.45, 0, 0.45},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "clip",

            on_punch = function(pos, node, puncher, pointed_thing)
                replace_pie(pos, node, puncher)
            end,

            on_rotate = screwdriver_flag and unilib.pkg.shared_screwdriver.rotate_simple,
        }
    )

    -- 1/4 size
    unilib.register_node(
        "unilib:" .. part_name .. "_4",
        "pie:" .. orig_part_name .. "_3",
        replace_mode,
        {
            description = unilib.utils.brackets(description, S("Quarter Size")),
            tiles = {
                "unilib_" .. part_name .. "_top.png",
                "unilib_" .. part_name .. "_bottom.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_side.png",
                "unilib_" .. part_name .. "_inside.png",
            },
            groups = {not_in_creative_inventory = 1},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "nodebox",
            drop = "",
            -- N.B. is_ground_content = false not in original code; added to match other food items
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {-0.45, -0.5, 0.25, 0.45, 0, 0.45},
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "clip",

            on_punch = function(pos, node, puncher, pointed_thing)
                replace_pie(pos, node, puncher)
            end,

            on_rotate = screwdriver_flag and unilib.pkg.shared_screwdriver.rotate_simple,
        }
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_pie.init()

    return {
        description = "Shared functions for cakes, pies etc (from pies)",
        notes = "Punch a baked item to eat it, one slice at a time. Each baked item has four" ..
                " slices",
        optional = {
            "bucket_steel",
            "bucket_wood",
            "shared_screwdriver",
            "vessel_bottle_glass_empty",
        },
    }

end
