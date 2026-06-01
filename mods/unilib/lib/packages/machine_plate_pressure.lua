---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_plate_pressure = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_construct(pos)

    local timer = core.get_node_timer(pos)
    timer:start(0.1)

end

local function on_timer(pos)

    local objs = core.get_objects_inside_radius(pos, 0.8)
    if not next(objs) or not doors.get then
        return true
    end

    local minp = {x = pos.x - 2, y = pos.y, z = pos.z - 2}
    local maxp = {x = pos.x + 2, y = pos.y, z = pos.z + 2}
    local doors = core.find_nodes_in_area(minp, maxp, "group:door")

    for _, player in pairs(objs) do

        if player:is_player() then

            for i = 1, #doors do
                unilib.pkg.shared_xdecor.toggle_door(pos, doors[i], player)
            end

            break

        end

    end

    return true

end

local function do_register(data_table)

    local part_name = data_table.part_name
    local orig_name_list = data_table.orig_name_list

    local description = data_table.description or S("Pressure Plate")
    local img = "unilib_machine_plate_pressure_" .. part_name .. ".png"
    local group_table = data_table.group_table or {cracky = 3, oddly_breakable_by_hand = 2}
    local sound_table = data_table.sound_table or unilib.global.sound_table.node

    unilib.register_node(
        "unilib:machine_plate_pressure_" .. part_name .. "_off",
        orig_name_list[1],
        mode,
        {
            description = description,
            tiles = {img},
            groups = group_table,
            sounds = sound_table,

            drawtype = "nodebox",
            -- N.B. inventory_image not in original code
            inventory_image = img,
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "opaque",

            on_construct = on_construct,
            on_timer = on_timer,
        }
    )
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:machine_plate_pressure_" .. part_name .. "_off", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    unilib.register_node(
        "unilib:machine_plate_pressure_" .. part_name .. "_on",
        orig_name_list[2],
        mode,
        {
            -- (no description)
            tiles = {img},
            groups = group_table,
            sounds = sound_table,

            drawtype = "nodebox",
            drop = "unilib:machine_plate_pressure_" .. part_name .. "_off",
            -- N.B. inventory_image not in original code
            inventory_image = img,
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.4375, -0.5, -0.4375, 0.4375, -0.475, 0.4375},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "opaque",
        }
    )
    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:machine_plate_pressure_" .. part_name .. "_on", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_plate_pressure.init()

    return {
        description = "Simple pressure plates",
        notes = "Stand on the plate to open or close any adjoining doors and trapdoors (for a" ..
                " few seconds). These plates are described as \"simple\" to distinguish them" ..
                " from the ones provided by mesecons",
        depends = {"item_stick_ordinary", "shared_xdecor"},
        optional = {"item_stick_iron", "shared_screwdriver"},
    }

end

function unilib.pkg.machine_plate_pressure.exec()

    local c_stick = "unilib:item_stick_ordinary"

    do_register({
        -- From xdecor:pressure_wood_off, xdecor:pressure_wood_on. Creates
        --      unilib:machine_plate_pressure_wood_off, machine_plate_pressure_wood_on
        part_name = "wood",
        orig_name_list = {"xdecor:pressure_wood_off", "xdecor:pressure_wood_on"},

        description = S("Simple Wooden Pressure Plate"),
        group_table = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 2},
        sound_table = unilib.global.sound_table.wood,
    })
    -- N.B. Original craft recipe conflicts with recipe in "machine_plate_pressure" package, and
    --      with the pressure plate in mesecons
    --[[
    unilib.register_craft({
        -- From xdecor:pressure_wood_off
        type = "shapeless",
        output = "unilib:machine_plate_pressure_wood_off",
        recipe = {"group:wood", "group:wood"},
    })
    ]]--
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_plate_pressure_wood_off",
        recipe = {
            {"group:wood", "group:wood"},
            {c_stick, c_stick},
        },
    })
    -- N.B. These items were renamed in unilib v1.1.0
    core.register_alias(
        "unilib:device_plate_pressure_wood_off", "unilib:machine_plate_pressure_wood_off"
    )
    core.register_alias(
        "unilib:device_plate_pressure_wood_on", "unilib:machine_plate_pressure_wood_on"
    )

    -- (For the stone pressure plate, use a different stick if it's available)
    if unilib.global.pkg_executed_table["item_stick_iron"] ~= nil then
        c_stick = "unilib:item_stick_iron"
    end
    
    do_register({
        -- From xdecor:pressure_stone_off, xdecor:pressure_stone_on. Creates
        --      unilib:machine_plate_pressure_stone_off, machine_plate_pressure_stone_on
        part_name = "stone",
        orig_name_list = {"xdecor:pressure_stone_off", "xdecor:pressure_stone_on"},

        description = S("Simple Stone Pressure Plate"),
        group_table = {cracky = 3, oddly_breakable_by_hand = 2},
        sound_table = unilib.global.sound_table.stone,
    })
    -- N.B. Original craft recipe does not conflict with other packages or with mesecons, but
    --      modified it to match the new craft recipe above
    --[[
    unilib.register_craft({
        -- From xdecor:pressure_stone_off
        type = "shapeless",
        output = "unilib:machine_plate_pressure_stone_off",
        recipe = {"group:stone", "group:stone"},
    })
    ]]--
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_plate_pressure_stone_off",
        recipe = {
            {"group:stone", "group:stone"},
            {c_stick, c_stick},
        },
    })    
    -- N.B. These items were renamed in unilib v1.1.0
    core.register_alias(
        "unilib:device_plate_pressure_stone_off", "unilib:machine_plate_pressure_stone_off"
    )
    core.register_alias(
        "unilib:device_plate_pressure_stone_on", "unilib:machine_plate_pressure_stone_on"
    )
    
end
