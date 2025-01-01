---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fachwerk
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_fachwerk = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.fachwerk.add_mode

local hint_text = S("use the screwdriver to rotate")

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_description(orig_description, extra)

    if orig_description ~= nil then
        return unilib.utils.hint(unilib.utils.brackets(orig_description, extra), hint_text)
    else
        return unilib.utils.hint(extra, hint_text)
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_fachwerk.register_timber_frame(data_table)

    -- Creates a timber frame using an ingredient node
    --
    -- data_table compulsory fields:
    --      ingredient (str): e.g. "unilib:clay_ordinary"
    --      orig_name (str): e.g. "default:clay"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      simple_flag (bool): If true, only variants using timber frames from the fachwerk mod
    --          are created. If false (or not specified), variants with timber from the plaster mod
    --          are also created. Use true for clays, plasters and woods, false for glass and stones
    --      transparent_flag (bool): If true, the "ingredient" is something transparent, like glass

    local ingredient = data_table.ingredient
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local simple_flag = data_table.simple_flag or false
    local transparent_flag = data_table.transparent_flag or false

    local ingredient_def_table = core.registered_nodes[ingredient]
    if ingredient_def_table == nil then
        return
    end

    -- e.g. "default:desert_stone" produces "fachwerk:desert_stone", "fachwerk:desert_stone_1" etc
    local orig_item_name
    if orig_name ~= nil then
        orig_item_name = unilib.utils.get_item_name(orig_name)
    end

    local orig_description = ingredient_def_table.description
    local orig_img = ingredient_def_table.tiles[1] or "unilib_unknown.png"

    local group_table = {choppy = 2, cracky = 3, oddly_breakable_by_hand = 2}

    -- Timber frames from fachwerk
    local square_orig_name
    if orig_item_name ~= nil then
        square_orig_name = "fachwerk:" .. orig_item_name
    end

    -- For glass and other transparent nodes, we use the drawtype "glasslike_framed"; the inner part
    --      of the two-pixel wide frame is invisible on the side facing away, but that's better than
    --      having a non-transparent node
    local drawtype = "normal"
    if transparent_flag then
        drawtype = "glasslike_framed"
    end

    unilib.register_node(ingredient .. "_with_frame_square", square_orig_name, replace_mode, {
        description = get_description(orig_description, S("Square Timber Frame")),
        tiles = {orig_img .. "^unilib_frame_timber_square_overlay.png"},
        groups = group_table,
        -- N.B. Equivalent of unilib.global.sound_table.stone in original code
        sounds = ingredient_def_table.sounds,

        drawtype = drawtype,
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        output = ingredient .. "_with_frame_square 8",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", ingredient, "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })

    local up_orig_name
    if orig_item_name ~= nil then
        up_orig_name = "fachwerk:" .. orig_item_name .. "_1"
    end

    unilib.register_node(ingredient .. "_with_beam_oblique_up", up_orig_name, replace_mode, {
        description = get_description(orig_description, S("Timber Frame with Oblique Beam")),
        tiles = {
            orig_img .. "^unilib_frame_timber_square_overlay.png",
            orig_img .. "^unilib_frame_timber_square_overlay.png",
            orig_img .. "^unilib_frame_timber_beam_oblique_up_overlay.png",
            orig_img .. "^unilib_frame_timber_beam_oblique_up_overlay.png^[transformFX",
            orig_img .. "^unilib_frame_timber_beam_oblique_up_overlay.png^[transformFX",
            orig_img .. "^unilib_frame_timber_beam_oblique_up_overlay.png",
        },
        groups = group_table,
        -- N.B. Equivalent of unilib.global.sound_table.stone in original code
        sounds = ingredient_def_table.sounds,

        drawtype = drawtype,
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        output = ingredient .. "_with_beam_oblique_up 8",
        recipe = {
            {ingredient, "group:wood", ingredient},
            {ingredient, ingredient, ingredient},
            {"group:wood", ingredient, ingredient},
        },
    })

    local down_orig_name
    if orig_item_name ~= nil then
        down_orig_name = "fachwerk:" .. orig_item_name .. "_2"
    end

    unilib.register_node(ingredient .. "_with_beam_oblique_down", down_orig_name, replace_mode, {
        description = get_description(orig_description, S("Timber Frame with Oblique Beam")),
        tiles = {
            orig_img .. "^unilib_frame_timber_square_overlay.png",
            orig_img .. "^unilib_frame_timber_square_overlay.png",
            orig_img .. "^unilib_frame_timber_beam_oblique_down_overlay.png",
            orig_img .. "^unilib_frame_timber_beam_oblique_down_overlay.png^[transformFX",
            orig_img .. "^unilib_frame_timber_beam_oblique_down_overlay.png^[transformFX",
            orig_img .. "^unilib_frame_timber_beam_oblique_down_overlay.png",
        },
        groups = group_table,
        -- N.B. Equivalent of unilib.global.sound_table.stone in original code
        sounds = ingredient_def_table.sounds,

        drawtype = drawtype,
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        output = ingredient .. "_with_beam_oblique_down 8",
        recipe = {
            {ingredient, ingredient, "group:wood"},
            {ingredient, ingredient, ingredient},
            {ingredient, "group:wood", ingredient},
        },
    })

    local cross_orig_name
    if orig_item_name ~= nil then
        cross_orig_name = "fachwerk:" .. orig_item_name .. "_cross"
    end

    unilib.register_node(ingredient .. "_with_cross_timber", cross_orig_name, replace_mode, {
        description = get_description(orig_description, S("Timber Frame with Cross")),
        tiles = {orig_img .. "^unilib_frame_timber_cross_overlay.png"},
        groups = group_table,
        -- N.B. Equivalent of unilib.global.sound_table.stone in original code
        sounds = ingredient_def_table.sounds,

        drawtype = drawtype,
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        -- N.B. .paramtype and .paramtype2 missing in original code
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        output = ingredient .. "_with_cross_timber 8",
        recipe = {
            {"group:wood", ingredient, "group:wood"},
            {ingredient, "group:wood", ingredient},
            {"group:wood", ingredient, "group:wood"},
        },
    })

    if not simple_flag then

        -- Original timber frames, following the design in the plaster mod
        unilib.register_node(ingredient .. "_with_beam_diagonal_up", nil, replace_mode, {
            description = get_description(orig_description, S("Timber Frame with Diagonal Beam")),
            tiles = {
                orig_img .. "^unilib_frame_timber_square_overlay.png",
                orig_img .. "^unilib_frame_timber_square_overlay.png",
                orig_img .. "^unilib_frame_timber_beam_diagonal_up_overlay.png",
                orig_img .. "^unilib_frame_timber_beam_diagonal_up_overlay.png^[transformFX",
                orig_img .. "^unilib_frame_timber_beam_diagonal_up_overlay.png^[transformFX",
                orig_img .. "^unilib_frame_timber_beam_diagonal_up_overlay.png",
            },
            groups = group_table,
            -- N.B. Equivalent of unilib.global.sound_table.stone in original code
            sounds = ingredient_def_table.sounds,

            drawtype = drawtype,
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
            paramtype2 = "facedir",
        })
        unilib.register_craft({
            output = ingredient .. "_with_beam_diagonal_up 8",
            recipe = {
                {ingredient, ingredient, "group:wood"},
                {ingredient, "group:wood", ingredient},
                {"group:wood", ingredient, ingredient},
            },
        })

        if unilib.setting.fachwerk_all_frames_flag then

            unilib.register_node(ingredient .. "_with_beam_diagonal_down", nil, replace_mode, {
                description =
                        get_description(orig_description, S("Timber Frame with Diagonal Beam")),
                tiles = {
                    orig_img .. "^unilib_frame_timber_square_overlay.png",
                    orig_img .. "^unilib_frame_timber_square_overlay.png",
                    orig_img .. "^unilib_frame_timber_beam_diagonal_down_overlay.png",
                    orig_img .. "^unilib_frame_timber_beam_diagonal_down_overlay.png^[transformFX",
                    orig_img .. "^unilib_frame_timber_beam_diagonal_down_overlay.png^[transformFX",
                    orig_img .. "^unilib_frame_timber_beam_diagonal_down_overlay.png",
                },
                groups = group_table,
                -- N.B. Equivalent of unilib.global.sound_table.stone in original code
                sounds = ingredient_def_table.sounds,

                drawtype = drawtype,
                -- N.B. is_ground_content = false not in original code
                is_ground_content = false,
                paramtype = "light",
                paramtype2 = "facedir",
            })
            unilib.register_craft({
                output = ingredient .. "_with_beam_diagonal_up 8",
                recipe = {
                    {"group:wood", ingredient, ingredient},
                    {ingredient, "group:wood", ingredient},
                    {ingredient, ingredient, "group:wood"},
                },
            })

        end

        unilib.register_node(ingredient .. "_with_beam_triangle_up", nil, replace_mode, {
            description = get_description(
                orig_description, S("Timber Frame with Triangular Beams")
            ),
            tiles = {
                orig_img .. "^unilib_frame_timber_square_overlay.png",
                orig_img .. "^unilib_frame_timber_square_overlay.png",
                orig_img .. "^unilib_frame_timber_beam_triangle_up_overlay.png",
                orig_img .. "^unilib_frame_timber_beam_triangle_up_overlay.png^[transformFX",
                orig_img .. "^unilib_frame_timber_beam_triangle_up_overlay.png^[transformFX",
                orig_img .. "^unilib_frame_timber_beam_triangle_up_overlay.png",
            },
            groups = group_table,
            -- N.B. Equivalent of unilib.global.sound_table.stone in original code
            sounds = ingredient_def_table.sounds,

            drawtype = drawtype,
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
            paramtype2 = "facedir",
        })
        unilib.register_craft({
            output = ingredient .. "_with_beam_triangle_up 8",
            recipe = {
                {ingredient, ingredient, "group:wood"},
                {ingredient, "group:wood", ingredient},
                {"group:wood", ingredient, "group:wood"},
            },
        })

        if unilib.setting.fachwerk_all_frames_flag then

            unilib.register_node(ingredient .. "_with_beam_triangle_down", nil, replace_mode, {
                description = get_description(
                    orig_description, S("Timber Frame with Triangular Beams")
                ),
                tiles = {
                    orig_img .. "^unilib_frame_timber_square_overlay.png",
                    orig_img .. "^unilib_frame_timber_square_overlay.png",
                    orig_img .. "^unilib_frame_timber_beam_triangle_down_overlay.png",
                    orig_img .. "^unilib_frame_timber_beam_triangle_down_overlay.png^[transformFX",
                    orig_img .. "^unilib_frame_timber_beam_triangle_down_overlay.png^[transformFX",
                    orig_img .. "^unilib_frame_timber_beam_triangle_down_overlay.png",
                },
                groups = group_table,
                -- N.B. Equivalent of unilib.global.sound_table.stone in original code
                sounds = ingredient_def_table.sounds,

                drawtype = drawtype,
                -- N.B. is_ground_content = false not in original code
                is_ground_content = false,
                paramtype = "light",
                paramtype2 = "facedir",
            })
            unilib.register_craft({
                output = ingredient .. "_with_beam_triangle_down 8",
                recipe = {
                    {"group:wood", ingredient, ingredient},
                    {ingredient, "group:wood", ingredient},
                    {"group:wood", ingredient, "group:wood"},

                },
            })

        end

        unilib.register_node(ingredient .. "_with_frame_horizontal", nil, replace_mode, {
            description = get_description(orig_description, S("Horizontal Timber Frame")),
            tiles = {
                orig_img .. "^unilib_frame_timber_horizontal_overlay.png",
                orig_img .. "^unilib_frame_timber_horizontal_overlay.png^[transformFX",
                orig_img .. "^unilib_frame_timber_end_overlay.png",
                orig_img .. "^unilib_frame_timber_end_overlay.png",
                orig_img .. "^unilib_frame_timber_horizontal_overlay.png",
                orig_img .. "^unilib_frame_timber_horizontal_overlay.png^[transformFX",
            },
            groups = group_table,
            -- N.B. Equivalent of unilib.global.sound_table.stone in original code
            sounds = ingredient_def_table.sounds,

            drawtype = drawtype,
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
            paramtype2 = "facedir",
        })
        unilib.register_craft({
            output = ingredient .. "_with_frame_horizontal 8",
            recipe = {
                {"group:wood", "group:wood", "group:wood"},
                {ingredient, ingredient, ingredient},
                {"group:wood", "group:wood", "group:wood"},
            },
        })

        if unilib.setting.fachwerk_all_frames_flag then

            unilib.register_node(ingredient .. "_with_frame_vertical", nil, replace_mode, {
                description = get_description(orig_description, S("Vertical Timber Frame")),
                tiles = {
                    orig_img .. "^unilib_frame_timber_end_overlay.png",
                    orig_img .. "^unilib_frame_timber_end_overlay.png",
                    orig_img .. "^unilib_frame_timber_vertical_overlay.png",
                    orig_img .. "^unilib_frame_timber_vertical_overlay.png^[transformFX",
                    orig_img .. "^unilib_frame_timber_vertical_overlay.png^[transformFX",
                    orig_img .. "^unilib_frame_timber_vertical_overlay.png",
                },
                groups = group_table,
                -- N.B. Equivalent of unilib.global.sound_table.stone in original code
                sounds = ingredient_def_table.sounds,

                drawtype = drawtype,
                -- N.B. is_ground_content = false not in original code
                is_ground_content = false,
                paramtype = "light",
                paramtype2 = "facedir",
            })
            unilib.register_craft({
                output = ingredient .. "_with_frame_vertical 8",
                recipe = {
                    {"group:wood", ingredient, "group:wood"},
                    {"group:wood", ingredient, "group:wood"},
                    {"group:wood", ingredient, "group:wood"},
                },
            })

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_fachwerk.init()

    return {
        description = "Shared functions for timber frames (from fachwerk)",
    }

end
