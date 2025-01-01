---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_glass_stained = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

local glass_type_list = {"single", "double", "triple", "quadruple", "noncuple", "offset"}

local nodebox_table = {
    single = {{-0.5, -0.5, 0, 0.5, 0.5, 0}},
    double = {{-0.5, -0.5, 0, 0.5, 1.5, 0}},
    triple = {{-0.5, -0.5, 0, 0.5, 1.5, 0}, {0.5, -0.5, 0, 1.5, 0.5, 0}},
    quadruple = {{-0.5, -0.5, 0, 1.5, 1.5, 0}},
    noncuple = {{-1.5, -1.5, 0, 1.5, 1.5, 0}},
    offset = {{-0.5, -0.5, 1, 0.5, 0.5, 1}},
}

local thick_nodebox_table = {
    single = {{-0.5, -0.5, -0.03125, 0.5, 0.5, 0.03125}},
    double = {{-0.5, -0.5, -0.03125, 0.5, 1.5, 0.03125}},
    triple = {{-0.5, -0.5, -0.03125, 0.5, 1.5, 0.03125}, {-0.5, -0.5, -0.03125, 1.5, 0.5, 0.03125}},
    quadruple = {{-0.5, -0.5, -0.03125, 1.5, 1.5, 0.03125}},
    noncuple = {{-1.5, -1.5, -0.03125, 1.5, 1.5, 0.03125}},
    offset = {{-0.5, -0.5, 0.96875, 0.5, 0.5, 1.03125}},
}

local selection_box_table = {
    single = {{-0.5, -0.5, -0.25, 0.5, 0.5, 0.25}},
    double = {{-0.5, -0.5, -0.25, 0.5, 1.5, 0.25}},
    triple = {{-0.5, -0.5, -0.25, 0.5, 1.5, 0.25}, {-0.5, -0.5, -0.25, 1.5, 0.5, 0.25}},
    quadruple = {{-0.5, -0.5, -0.25, 1.5, 1.5, 0.25}},
    noncuple = {{-1.5, -1.5, -0.25, 1.5, 1.5, 0.25}},
    offset = {{-0.5, -0.5, 0.75, 0.5, 0.5, 1.25}},
}

local desc_table = {
    single = S("Single"),
    double = S("Double"),
    triple = S("Triple"),
    quadruple = S("Quadruple"),
    noncuple = S("Noncuple"),
    offset = S("Offset"),
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_crafts(item_name, main_craft_table, main_output)

    -- Add a glass_type to get a full node name
    local basic_name = "unilib:" .. item_name
    -- The basic ingredient for craft recipes
    local single_name = basic_name .. "_single"

    -- The "main_craft" and "main_output" arguments are used only in this craft recipe
    unilib.register_craft({
        output = single_name .. " " .. tostring(main_output),
        recipe = main_craft_table,
    })

    -- Use the basic ingredient to create other related stained glass items
    unilib.register_craft({
        output = basic_name .. "_double",
        recipe = {
            {single_name},
            {single_name}
        },
    })

    unilib.register_craft({
        output = single_name .. " 2",
        recipe = {
            {basic_name .. "_double"},
        },
    })

    unilib.register_craft({
        output = basic_name .. "_triple",
        recipe = {
            {single_name, ""},
            {single_name, single_name}
        },
    })

    unilib.register_craft({
        output = single_name .. " 3",
        recipe = {
            {basic_name .. "_triple"},
        },
    })

    unilib.register_craft({
        output = basic_name .. "_quadruple",
        recipe = {
            {single_name, single_name},
            {single_name, single_name}
        },
    })

    unilib.register_craft({
        output = single_name .. " 4",
        recipe = {
            {basic_name .. "_quadruple"},
        },
    })

    unilib.register_craft({
        output = basic_name .. "_noncuple",
        recipe = {
            {single_name, single_name, single_name},
            {single_name, single_name, single_name},
            {single_name, single_name, single_name}
        },
    })

    unilib.register_craft({
        output = single_name .. " 9",
        recipe = {
            {basic_name .. "_noncuple"},
        },
    })

    unilib.register_craft({
        output = basic_name .. "_offset",
        recipe = {
            {single_name}
        },
    })

    unilib.register_craft({
        output = single_name,
        recipe = {
            {basic_name .. "_offset"},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_glass_stained.register_stained_glass(data_table)

    -- Each call to this function produces six stained glass variants from a single glass texture,
    --      corresponding to the six key-value pairs in the tables above
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "rhombus_blue" (corresponding to set #1 in the original code)
    --      description (str): e.g. "Blue Rhombus Stained Glass"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      craft_list (list): e.g. {"blue", "blue", "blue"}, corresponding to the basic colour set
    --          in the "dye_basic" package. If not specified, the stained glass items can't be
    --          crafted
    --      orig_num (int): A value in the range 1-18, or nil for any new stained glass items

    local part_name = data_table.part_name
    local description = data_table.description

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local craft_list = data_table.craft_list or nil
    local orig_num = data_table.orig_num or nil

    for _, glass_type in pairs(glass_type_list) do

        local full_name = "unilib:glass_stained_" .. part_name .. "_" .. glass_type
        local orig_name = nil
        if orig_num ~= nil then
            orig_name = "glass_stained:glass_" .. orig_num .. "_" .. glass_type
        end

        local img = "unilib_glass_stained_" .. part_name .. ".png"

        unilib.register_node(full_name, orig_name, replace_mode, {
            description = unilib.utils.brackets(description, desc_table[glass_type]),
            tiles = {img},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.glass,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = nodebox_table[glass_type],
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = selection_box_table[glass_type],
            },
            sunlight_propagates = true,
            use_texture_alpha = "clip",
            wield_image = img,
        })

    end

    if craft_list ~= nil then

        register_crafts(
            "glass_stained_" .. part_name,
            {
                {"unilib:dye_" .. craft_list[1], "unilib:pane_glass_ordinary_flat"},
                {"unilib:dye_" .. craft_list[2], "unilib:pane_glass_ordinary_flat"},
                {"unilib:dye_" .. craft_list[3], "unilib:pane_glass_ordinary_flat"},
            },
            3
        )

    end

end

function unilib.pkg.shared_glass_stained.register_sheet(data_table)

    -- Each call to this function produces six sheet variants from a single pane (which is
    --      usually glass, but can also be things like spiked steel). Each variant corresponds to
    --      the six key-value pairs in the tables above
    -- Sheets differ from panes in that they don't connect at 90-degree angles to neighbouring
    --      sheets
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "glass_sheet_ordinary"
    --      orig_name (str): e.g. "glass_stained:pane_glass"
    --      description (str): e.g. "Ordinary Sheet Glass"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      craft_output (int): An integer as a string, e.g. 4
    --      craft_table (table): A craft recipe
    --      edge_img (str): e.g. "unilib_pane_glass_ordinary_edge.png"
    --      front_img (str): e.g. "unilib_glass_ordinary.png"
    --      sound_type (str): e.g. "glass", "metal"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local description = data_table.description

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local craft_output = data_table.craft_output or 4
    local craft_table = data_table.craft_table or nil
    local edge_img = data_table.edge_img or "unilib_pane_glass_ordinary_edge.png"
    local front_img = data_table.front_img or "unilib_glass_ordinary.png"
    local sound_type = data_table.sound_type or "glass"

    for _, glass_type in pairs(glass_type_list) do

        local full_name = "unilib:" .. part_name .. "_" .. glass_type
        local this_orig_name
        if orig_name ~= nil then
            this_orig_name = orig_name .. "_" .. glass_type
        end

        unilib.register_node(full_name, this_orig_name, replace_mode, {
            description = unilib.utils.brackets(description, desc_table[glass_type]),
            tiles = {edge_img, edge_img, front_img},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table[sound_type],

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = thick_nodebox_table[glass_type],
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = selection_box_table[glass_type],
            },
            sunlight_propagates = true,
            use_texture_alpha = "clip",
            wield_image = front_img,
        })

    end

    if craft_table ~= nil then
        register_crafts(part_name, craft_table, craft_output)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_glass_stained.init()

    return {
        description = "Shared functions for stained/sheet glass (from glass_stained)",
        notes = "These items can be partially embedded inside other nodes, like arches or" ..
                " upside-down stairs. Calls from packages like \"glass_sheet_ordinary\" allow" ..
                " those types of glass to be embedded, too",
        depends = {"dye_basic", "pane_glass_ordinary"},
    }

end
