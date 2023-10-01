---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ldm32
-- Code:    LGPL 2.1+
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_ldm32 = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ldm32.add_mode

local default_max_range = 32

local midpoint_beam = "unilib:machine_meter_beam_yellow"
local section_beam = "unilib:machine_meter_beam_white"

---------------------------------------------------------------------------------------------------
-- Local functions - general
---------------------------------------------------------------------------------------------------

local function beam_off(pos, facedir_param2, beam_name, range)

    -- Was laser_off()

    local block_pos = vector.new(pos)
    local beam_pos = vector.new(pos)
    local beam_direction = minetest.facedir_to_dir(facedir_param2)

    for i = range, 0, -1 do

        beam_pos = vector.add(block_pos, vector.multiply(beam_direction, i))
        local node = minetest.get_node(beam_pos)

        if (node.name == beam_name or node.name == midpoint_beam or node.name == section_beam) and
                node.param2 == facedir_param2 then
            minetest.set_node(beam_pos, {name = "air"})
        end

    end

end

local function beam_check(pos, facedir_param2, range)

    -- Was laser_check()

    local meta = minetest.get_meta(pos)
    local beam_name = meta:get_string("beam_name")
    local max_range = meta:get_int("max_range")

    local block_pos = vector.new(pos)
    local beam_pos = vector.new(pos)
    local beam_direction = minetest.facedir_to_dir(facedir_param2)
    local is_not_beam = false

    for i = 1, range + 1, 1 do

        beam_pos = vector.add(block_pos, vector.multiply(beam_direction, i))
        local node = minetest.get_node(beam_pos)

        if node.name ~= beam_name and
                node.name ~= midpoint_beam and
                node.name ~= section_beam and
                i <= range then
            is_not_beam = true
        elseif node.name == "air" and i <= max_range then
            is_not_beam = true
        end

    end

    return is_not_beam

end

local function set_infotext(meta, msg)

    -- Original to unilib

    meta:set_string("infotext", unilib.brackets(meta:get_string("description"), msg))

end

---------------------------------------------------------------------------------------------------
-- Local functions - distance meter
---------------------------------------------------------------------------------------------------

local function distance_beam_on(pos, facedir_param2, range)

    -- Was laser_on()

    local meta = minetest.get_meta(pos)
    local beam_name = meta:get_string("beam_name")
    local max_range = meta:get_int("max_range")

    local block_pos = vector.new(pos)
    local beam_pos = vector.new(pos)
    local beam_direction = minetest.facedir_to_dir(facedir_param2)

    for i = 1, range + 1, 1 do

        beam_pos = vector.add(block_pos, vector.multiply(beam_direction, i))
        local node = minetest.get_node(beam_pos)
        -- (Distance meters can't produce midpoint/section beams, but check for them anyway, in
        --      case rogue beams have been left behind by a surveyor's meter)
        if node.name == "air" or
                node.name == beam_name or
                node.name == midpoint_beam or
                node.name == section_beam then

            if i <= range then

                minetest.set_node(beam_pos, {name = beam_name, param2 = facedir_param2})
                set_infotext(meta, S("Distance: @1m", tostring(i)))
                meta:set_int("range", i)

            else

                set_infotext(meta, S("Distance: out of range"))
                meta:set_int("range", max_range)

            end

        else

            break

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions - surveyor's meter
---------------------------------------------------------------------------------------------------

local function surveyor_beam_on(pos, facedir_param2, range)

    -- Was laser_on()

    local meta = minetest.get_meta(pos)
    local beam_name = meta:get_string("beam_name")
    local max_range = meta:get_int("max_range")
    local section_len = meta:get_int("section_len")

    local block_pos = vector.new(pos)
    local beam_pos = vector.new(pos)
    local beam_direction = minetest.facedir_to_dir(facedir_param2)

    -- (N.B. When "range" is 0, for example because an adjacent node exists, no beam is produced)
    for i = 1, range + 1, 1 do

        beam_pos = vector.add(block_pos, vector.multiply(beam_direction, i))
        local node = minetest.get_node(beam_pos)
        if node.name == "air" or
                node.name == beam_name or
                node.name == midpoint_beam or
                node.name == section_beam then

            if i <= range then

                local this_name = beam_name
                if section_len ~= 0 and i % section_len == 0 then
                    this_name = section_beam
                end

                minetest.set_node(beam_pos, {name = this_name, param2 = facedir_param2})
                set_infotext(meta, S("Distance: @1m", tostring(i)))
                meta:set_int("range", i)

            else

                set_infotext(meta, S("Distance: out of range"))
                meta:set_int("range", max_range)

            end

        else

            break

        end

    end

    if meta:get_string("midpoint_on") == "true" then

        local this_range = meta:get_int("range")
        local this_name = midpoint_beam
        local midpoint = math.floor(this_range / 2)
        if midpoint > 1 then

            beam_pos = vector.add(block_pos, vector.multiply(beam_direction, midpoint))
            minetest.set_node(beam_pos, {name = this_name, param2 = facedir_param2})

        end

    end

end

local function surveyor_populate_output(pos)

    local meta = minetest.get_meta(pos)
    local node = minetest.get_node(pos)
    local def_table = minetest.registered_nodes[node.name]

    local dropdown_text, section_len
    local max_range = meta:get_int("max_range")
    -- (Section lengths that are appropriate for the laser's maximum range)
    if max_range <= 32 then

        dropdown_text = S("None") .. ",2,3,4,5,6,7,8"

    elseif max_range <= 64 then

        dropdown_text = S("None") .. ",2,3,4,5,6,7,8,9,10,11,12,13,14,15,16"

    else

        dropdown_text = S("None") .. ",2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20," ..
                "21,22,23,24,25,26,27,28,29,30,31,32"

    end

    -- (Compensate for the missing "1" setting in dropdown_text)
    section_len = meta:get_int("section_len")
    if section_len == 0 then
        section_len = 1
    end

    meta:set_string("formspec", "size[4.5,3]" ..
        "image[0,0;1,1;" .. def_table.inventory_image .. "]" ..
        "label[1,0.2;" .. def_table.description .. "]" ..
        "checkbox[0,0.9;beam_on;" .. S("Laser beam turned on") .. ";" ..
                meta:get_string("is_on") .. "]" ..
        "checkbox[0,1.4;midpoint;" .. S("Show mid-point") .. ";" ..
                meta:get_string("midpoint_on") .. "]" ..
        "label[0,2.2;" .. S("Show sections of length") .. "]" ..
        "dropdown[2.8,2.1;1.2,1;section;" .. dropdown_text .. ";" .. tostring(section_len) .. "]"
    )

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_ldm32.register_meter_distance(data_table)

    -- Adapted from ldm32/init.lua
    -- Registers a distance meter, which displays the unobstructed distance between two nodes (up
    --      to a maximum range), but without midpoint/section markers
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "simple"
    --      orig_name (str): e.g. "ldm32:casing"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      beam_colour (str): One of the colours in unilib's basic colour set, e.g. "red". Only
    --          a limited selection of colours have been coded; to add more, see the code below
    --      description (str): e.g. "Distance Meter"
    --      ingredient (str): Used in the craft recipe, e.g. "unilib:mineral_mese_crystal"
    --          (and create new textures)
    --      max_range (int): Maximum range of the laser beam (minimum 1)

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local beam_colour = data_table.beam_colour or "red"
    local description = data_table.description or S("Distance Meter")
    local ingredient = data_table.ingredient or "unilib:mineral_mese_crystal"
    local max_range = data_table.max_range or default_max_range

    local full_name = "unilib:machine_meter_distance_" .. part_name
    local machine_img = "unilib_machine_meter_distance.png"
    local lens_img = "unilib_machine_meter_lens_" .. beam_colour .. ".png"
    local inv_img = "unilib_machine_meter_distance_" .. part_name .. "_inv.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {lens_img, machine_img},
        groups = {dig_immediate = 3, snappy = 3},
        -- (no sounds)

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.07, -0.5, -0.5, 0.07, -0.25, 0.5},
            },
        },
        drawtype = "mesh",
        inventory_image = inv_img,
        is_ground_content = true,
        mesh = "unilib_machine_meter.obj",
        -- N.B. paramtype = "light" not in original code
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.07, -0.5, -0.5, 0.07, -0.25, 0.5},
            },
        },
        stack_max = 1,
        use_texture_alpha = "clip",

        after_destruct = function(pos, oldnode, oldmetadata)

            local meta = minetest.get_meta(pos)
            -- (beam_off() call moved to the preserve_metadata() callback)
            set_infotext(meta, S("Off"))
            meta:set_string("is_on", "false")

        end,

        after_dig_node = function(pos, oldnode)

            local meta = minetest.get_meta(pos)
            -- (beam_off() call moved to the preserve_metadata() callback)
            set_infotext(meta, S("Off"))
            meta:set_string("is_on", "false")

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            local node = minetest.get_node(pos)

            meta:set_string("is_on", "false")
            meta:set_int("facedir", node.param2)
            -- N.B. These values are original to unilib
            meta:set_int("max_range", max_range)
            meta:set_string("beam_name", "unilib:machine_meter_beam_" .. beam_colour)
            meta:set_string("description", description)

            set_infotext(meta, S("Off"))

        end,

        on_place = minetest.rotate_node,

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            local meta = minetest.get_meta(pos)
            local node = minetest.get_node(pos)
            local timer = minetest.get_node_timer(pos)

            if meta:get_string("is_on") == "false" then

                distance_beam_on(pos, node.param2, max_range)
                meta:set_string("is_on", "true")
                timer:start(1)

            else

                beam_off(pos, node.param2, meta:get_string("beam_name"), meta:get_int("range"))
                set_infotext(meta, S("Off"))
                meta:set_string("is_on", "false")
                timer:stop()

            end

        end,

        on_timer = function(pos)

            local meta = minetest.get_meta(pos)
            local node = minetest.get_node(pos)
            local timer = minetest.get_node_timer(pos)
            local is_not_beam = false
            local is_air = false

            if meta:get_string("is_on") == "true" then

                if beam_check(pos, node.param2, meta:get_int("range")) then

                    beam_off(pos, node.param2, meta:get_string("beam_name"), meta:get_int("range"))
                    distance_beam_on(pos, node.param2, max_range)

                end

                if meta:get_int("facedir") ~= node.param2 and meta:get_string("is_on") then

                    beam_off(pos, meta:get_int("facedir"), meta:get_string("beam_name"), max_range)
                    distance_beam_on(pos, node.param2, max_range)
                    meta:set_int("facedir", node.param2)

                end

            end

            timer:start(1)

        end,

        preserve_metadata = function(pos, oldnode, oldmeta, drops)

            -- (The old metadata is not available to the .after_destruct() or .after_dig_node()
            --      functions, so the call to beam_off() must be made from here)
            beam_off(
                pos,
                oldnode.param2,
                tostring(oldmeta.beam_name),
                tonumber(oldmeta.range) or max_range
            )

        end,
    })
    -- (Original craft recipe used "group:wood" in the top-left slot)
    unilib.register_craft({
        output = full_name,
        recipe = {
            {ingredient, "unilib:dye_" .. beam_colour, ingredient},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })

end

function unilib.pkg.shared_ldm32.register_meter_surveyor(data_table)

    -- Adapted from ldm32/init.lua
    -- Registers a surveyor's meter, which displays the unobstructed distance between two nodes (up
    --      to a maximum range), as well as optional midpoint/section markers
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "simple"
    --      orig_name (str): e.g. "ldm32:casing"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      beam_colour (str): One of the colours in unilib's basic colour set, e.g. "red". Only
    --          a limited selection of colours have been coded; to add more, see the code below
    --      description (str): e.g. "Surveyor's Meter"
    --      ingredient (str): Used in the craft recipe, e.g. "unilib:mineral_mese_crystal"
    --          (and create new textures)
    --      max_range (int): Maximum range of the laser beam (minimum 1)

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local beam_colour = data_table.beam_colour or "red"
    local description = data_table.description or S("Surveyor's Meter")
    local ingredient = data_table.ingredient or "unilib:mineral_mese_crystal"
    local max_range = data_table.max_range or default_max_range

    local full_name = "unilib:machine_meter_surveyor_" .. part_name
    local machine_img = "unilib_machine_meter_surveyor.png"
    local lens_img = "unilib_machine_meter_lens_" .. beam_colour .. ".png"
    local inv_img = "unilib_machine_meter_surveyor_" .. part_name .. "_inv.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {lens_img, machine_img},
        groups = {dig_immediate = 3, snappy = 3},
        -- (no sounds)

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.07, -0.5, -0.5, 0.07, -0.25, 0.5},
            },
        },
        drawtype = "mesh",
        inventory_image = inv_img,
        is_ground_content = true,
        mesh = "unilib_machine_meter.obj",
        -- N.B. paramtype = "light" not in original code
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.07, -0.5, -0.5, 0.07, -0.25, 0.5},
            },
        },
        stack_max = 1,
        use_texture_alpha = "clip",

        after_destruct = function(pos, oldnode, oldmetadata)

            local meta = minetest.get_meta(pos)
            -- (beam_off() call moved to the preserve_metadata() callback)
            set_infotext(meta, S("Off"))
            meta:set_string("is_on", "false")

        end,

        after_dig_node = function(pos, oldnode)

            local meta = minetest.get_meta(pos)
            -- (beam_off() call moved to the preserve_metadata() callback)
            set_infotext(meta, S("Off"))
            meta:set_string("is_on", "false")

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            local node = minetest.get_node(pos)

            meta:set_string("is_on", "false")
            meta:set_int("facedir", node.param2)
            -- N.B. These values are original to unilib
            meta:set_int("max_range", max_range)
            meta:set_string("beam_name", "unilib:machine_meter_beam_" .. beam_colour)
            meta:set_string("description", description)
            meta:set_string("midpoint_on", "false")
            meta:set_int("section_len", 0)

            set_infotext(meta, S("Off"))

        end,

        on_place = minetest.rotate_node,

        on_receive_fields = function(pos, formname, fields, sender)

            local meta = minetest.get_meta(pos)
            local node = minetest.get_node(pos)
            local timer = minetest.get_node_timer(pos)

            if not fields.quit then

                if fields.beam_on ~= nil then

                    if fields.beam_on == "false" then

                        beam_off(
                            pos, node.param2, meta:get_string("beam_name"), meta:get_int("range")
                        )
                        set_infotext(meta, S("Off"))
                        meta:set_string("is_on", "false")
                        timer:stop()

                    elseif fields.beam_on == "true" then

                        surveyor_beam_on(pos, node.param2, max_range)
                        meta:set_string("is_on", "true")
                        timer:start(1)

                    end

                else

                    if fields.midpoint ~= nil then
                        meta:set_string("midpoint_on", fields.midpoint)
                    end

                    if fields.section ~= nil then

                        if fields.section == S("None") then
                            meta:set_int("section_len", 0)
                        else
                            meta:set_int("section_len", tonumber(fields.section))
                        end

                    end

                    if meta:get_string("is_on") == "true" then

                        beam_off(
                            pos, meta:get_int("facedir"), meta:get_string("beam_name"), max_range
                        )
                        surveyor_beam_on(pos, node.param2, max_range)

                    end

                end

            end

        end,

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            surveyor_populate_output(pos)

        end,

        on_timer = function(pos)

            local meta = minetest.get_meta(pos)
            local node = minetest.get_node(pos)
            local timer = minetest.get_node_timer(pos)
            local is_not_beam = false
            local is_air = false

            if meta:get_string("is_on") == "true" then

                if beam_check(pos, node.param2, meta:get_int("range")) then

                    beam_off(
                        pos, node.param2, meta:get_string("beam_name"), meta:get_int("range")
                    )
                    surveyor_beam_on(pos, node.param2, max_range)

                end

                if meta:get_int("facedir") ~= node.param2 and meta:get_string("is_on") then

                    beam_off(
                        pos, meta:get_int("facedir"), meta:get_string("beam_name"), max_range
                    )
                    surveyor_beam_on(pos, node.param2, max_range)
                    meta:set_int("facedir", node.param2)

                end

            end

            timer:start(1)

        end,

        preserve_metadata = function(pos, oldnode, oldmeta, drops)

            -- (The old metadata is not available to the .after_destruct() or .after_dig_node()
            --      functions, so the call to beam_off() must be made from here)
            beam_off(
                pos,
                oldnode.param2,
                tostring(oldmeta.beam_name),
                tonumber(oldmeta.range) or max_range
            )

        end,
    })
    -- (Original craft recipe used "group:wood" in the top-left slot)
    unilib.register_craft({
        output = full_name,
        recipe = {
            {ingredient, "unilib:dye_" .. beam_colour, ingredient},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_ldm32.init()

    return {
        description = "Shared functions for distance and surveyor's meters (from ldm32)",
        depends = {"dye_basic", "metal_steel"},
    }

end

function unilib.pkg.shared_ldm32.exec()

    -- Create laser beams in various colours (for the moment, only those actually required by
    --      packages)
    local colour_table = {
        -- (Used with distance meters)
        {"blue", nil, S("Blue Laser Beam"), {r = 64, g = 64, b = 128, a = 128}},
        {"cyan", nil, S("Cyan Laser Beam"), {r = 64, g = 96, b = 96, a = 128}},
        {"green", nil, S("Green Laser Beam"), {r = 64, g = 128, b = 64, a = 128}},
        -- (Used with surveyor's meters)
        {"orange", nil, S("Orange Laser Beam"), {r = 128, g = 96, b = 64, a = 128}},
        {"red", "ldm32:laser_beam", S("Red Laser Beam"), {r = 128, g = 64, b = 64, a = 128}},
        {"violet", nil, S("Violet Laser Beam"), {r = 128, g = 64, b = 128, a = 128}},
        -- (Creates "section_beam")
        {"white", nil, S("White Laser Beam"), {r = 128, g = 128, b = 128, a = 128}},
        -- (Creates "midpoint_beam")
        {"yellow", nil, S("Yellow Laser Beam"), {r = 128, g = 96, b = 64, a = 128}},
    }

    for _, row_list in pairs(colour_table) do

        local colour = row_list[1]
        local orig_name = row_list[2]
        local description = row_list[3]
        local rgb_table = row_list[4]

        local full_name = "unilib:machine_meter_beam_" .. colour

        unilib.register_node(full_name, orig_name, mode, {
            description = description,
            tiles = {"unilib_machine_meter_beam_" .. colour .. ".png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {not_in_creative_inventory = 1},
            -- (no sounds)

            buildable_to = true,
            diggable = false,
            drawtype = "mesh",
            light_source = 4,
            mesh = "unilib_machine_meter_beam.obj",
            paramtype = "light",
            paramtype2 = "facedir",
            pointable = false,
            post_effect_color = rgb_table,
            sunlight_propagates = true,
            use_texture_alpha = "blend",
            walkable = false,
        })

    end

end
