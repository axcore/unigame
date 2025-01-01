---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.roof_dirt_whitewashed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_register(data_table)

    -- Adapted from earthbuild/whitewash.lua
    -- Creates a whitewashred roofing item post based on a tree type
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "aspen", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "earthbuild:aspen_wood_supported_whitewashed_earth"
    --
    -- data_table optional fields:
    --      description (str): e.g. "Aspen Wood"
    --      ingredient (str): e.g. "unilib:tree_aspen_wood"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wood")
    local ingredient = data_table.ingredient or "unilib:tree_" .. part_name .. "_wood"

    local full_name = "unilib:roof_dirt_whitewashed_with_wood_" .. part_name

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.utils.brackets(S("Whitewashed Dirt Roofing"), description),
        tiles = {
            "unilib_dirt_whitewashed.png",
            "unilib_tree_" .. part_name .. "_wood.png",
            "unilib_roof_dirt_whitewashed_with_wood_" .. part_name .. ".png",
            "unilib_roof_dirt_whitewashed_with_wood_" .. part_name .. ".png",
            "unilib_roof_dirt_whitewashed_with_wood_" .. part_name .. ".png",
            "unilib_roof_dirt_whitewashed_with_wood_" .. part_name .. ".png",
        },
        groups = {choppy = 2, cracky = 2, crumbly = 1, flammable = 1},
        sounds = unilib.global.sound_table.dirt,

        drawtype = "normal",
        -- N.B. is_ground_content = false not in original code; added to match other rooves
        is_ground_content = false,
        paramtype = "light",
    })
    if unilib.global.pkg_executed_table["roof_dirt"] ~= nil then

        unilib.register_craft({
            output = full_name,
            recipe = {
                {"unilib:roof_dirt_with_wood_" .. part_name, "unilib:material_lime_slaked"},
            },
        })

    end
    if unilib.global.pkg_executed_table["roof_cob"] ~= nil then

        unilib.register_craft({
            output = full_name,
            recipe = {
                {"unilib:roof_cob_with_wood_" .. part_name, "unilib:material_lime_slaked"},
            },
        })

    end
    if unilib.global.pkg_executed_table["material_cob_whitewashed"] ~= nil then

        local c_cob = "unilib:material_cob_whitewashed"

        unilib.register_craft({
            output = full_name .. " 3",
            recipe = {
                {c_cob, c_cob, c_cob},
                {ingredient, "", ""},
                {"", "", ""},
            },
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.roof_dirt_whitewashed.init()

    return {
        description = "Whitewashed supported dirt roofing set",
        notes = "This package creates roofing items from the full range of super trees",
        depends = "material_lime_slaked",
        at_least_one = {"material_cob_whitewashed", "roof_cob", "roof_dirt"},
    }

end

function unilib.pkg.roof_dirt_whitewashed.post()

    local orig_name_table = {
        acacia = "earthbuild:acacia_wood_supported_whitewashed_earth",
        apple = "earthbuild:supported_whitewashed_earth",
        aspen = "earthbuild:aspen_wood_supported_whitewashed_earth",
        jungle = "earthbuild:jungle_wood_supported_whitewashed_earth",
        pine = "earthbuild:pine_wood_supported_whitewashed_earth",
    }

    for part_name, _ in pairs(unilib.global.super_tree_table) do

        local data_table = unilib.global.tree_table[part_name]
        local ingredient = "unilib:tree_" .. part_name .. "_wood"

        if unilib.global.super_tree_table[part_name] ~= nil and
                unilib.global.pkg_executed_table["tree_" .. part_name] ~= nil and
                core.registered_nodes[ingredient] ~= nil then

            do_register({
                part_name = part_name,
                orig_name = orig_name_table[part_name],

                replace_mode = mode,
                description = S("supported with @1", data_table.description),
                ingredient = ingredient,
            })

        end

    end

end
