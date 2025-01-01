---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_shields
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_castle_shields = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_shields.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local recipe_table = {
    barry = { {"bg", "bg", ""}, {"", "", ""}, {"fg", "fg", ""} },
    bend = { {"bg", "", ""}, {"", "fg", ""}, {"", "", "bg"} },
    bend_sinister = { {"", "", "bg"}, {"", "fg", ""}, {"bg", "", ""} },
    checkly = { {"bg", "", "fg"}, {"", "", ""}, {"fg", "", "bg"} },
    chevron = { {"bg", "", "bg"}, {"", "fg", ""}, {"", "", ""} },
    chevron_sinister = { {"", "", ""}, {"", "fg", ""}, {"bg", "", "bg"} },
    cross = { {"", "bg", ""}, {"fg", "", "fg"}, {"", "bg", ""} },
    fess = { {"", "", ""}, {"bg", "fg", "bg"}, {"", "", ""} },
    pale = { {"", "bg", ""}, {"", "fg", ""}, {"", "bg", ""} },
    paly = { {"bg", "", "fg"}, {"bg", "", "fg"}, {"", "", ""} },
    per_bend = { {"", "bg", "fg"}, {"", "", "bg"}, {"", "", ""} },
    per_fess = { {"bg", "fg", "bg"}, {"", "", ""}, {"", "", ""} },
    per_pale = { {"", "", "bg"}, {"", "", "fg"}, {"", "", "bg"} },
    per_saltire = { {"bg", "", ""}, {"", "fg", ""}, {"bg", "", ""} },
    quarterly = { {"bg", "bg", ""}, {"", "", ""}, {"", "fg", "fg"} },
    saltire = { {"bg", "", "bg"}, {"", "fg", ""}, {"bg", "", "bg"} },
}

local function compile_recipe(style, bg_colour, fg_colour)

    if recipe_table[style] == nil then

        -- Unrecognised style; use the craft recipe from the original mod's code as a failsafe
        return {
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"unilib:dye_" .. bg_colour, "unilib:metal_steel_ingot", "unilib:dye_" .. fg_colour},
        }

    else

        local return_list = { {}, {}, {} }

        for a = 1, 3 do

            for b = 1, 3 do

                if recipe_table[style][a][b] == "bg" then
                    return_list[a][b] = "unilib:dye_" .. bg_colour
                elseif recipe_table[style][a][b] == "fg" then
                    return_list[a][b] = "unilib:dye_" .. fg_colour
                else
                    return_list[a][b] = "unilib:metal_steel_ingot"
                end

            end

        end

        return return_list

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_castle_shields.register_mounted_shield(data_table)

    -- Adapted from castle_shields/shield_functions.lua
    -- Creates a mounted shield in the specified colours
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "slash_red_blue"
    --      orig_name (str): e.g. "castle_shields:shield_1"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      bg_colour (str): any colour from unilib's basic dye set, specifically "black", "blue",
    --          "brown", "cyan", "green", "green_dark", "grey", "grey_dark", "magenta", "orange",
    --          "pink", "red", "violet", "white", "yellow"
    --      description (str): e.g. "Red and Blue Slash"
    --      fg_colour (str) (str): any colour from unilib's basic dye set
    --      style (str): The shield style matching a mask texture: "bend_sinister", "chevron",
    --          "cross" (from the original code), or "barry", "bend", "checkly", "chevron_sinister",
    --          "fess", "pale", "paly", "per_bend", "per_fess", "per_pale", "per_saltire",
    --          "quarterly" (original to unilib)

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local bg_colour = data_table.bg_colour or "white"
    local fg_colour = data_table.fg_colour or "red"
    local description = data_table.description or S("Red and white cross")
    local style = data_table.style or "cross"

    local side_img = "unilib_misc_shield_mounted_" .. bg_colour .. ".png"
    local front_img = "unilib_misc_shield_mounted_" .. bg_colour .. ".png" ..
            "^(unilib_misc_shield_mounted_" .. fg_colour .. ".png" ..
            "^[mask:unilib_mask_misc_shield_mounted_" .. style .. ".png)"

    unilib.register_node("unilib:misc_shield_mounted_" .. part_name, orig_name, replace_mode, {
        description = unilib.utils.brackets(S("Mounted Shield"), description),
        tiles = {
            side_img,
            side_img,
            side_img,
            side_img,
            "unilib_misc_shield_mounted_back.png",
            front_img,
        },
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.metal,

        -- N.B. display_offset added for compatibility with display frames
        display_offset = -3.5,
        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.500000, -0.125000, 0.375000, 0.500000, 0.500000, 0.500000},
                {-0.437500, -0.312500, 0.375000, 0.425000, 0.500000, 0.500000},
                {-0.312500, -0.437500, 0.375000, 0.312500, 0.500000, 0.500000},
                {-0.187500, -0.500000, 0.375000, 0.187500, 0.500000, 0.500000},
            },
        },
        paramtype2 = "facedir",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.500000, -0.500000, 0.375000, 0.500000, 0.500000, 0.500000},
            },
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_shield_mounted_" .. part_name,
        recipe = compile_recipe(style, bg_colour, fg_colour),
    })

end


---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_castle_shields.init()

    return {
        description = "Shared functions for mounted shields (from castle modpack)",
        depends = {"dye_basic", "metal_steel"},
    }

end
