---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_cracked = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_cracked.init()

    return {
        description = "Decorative cracked stone",
        notes = "This package creates nodes from the full range of super stones",
        suggested = {
            "tool_pick_wood",                   -- group:pickaxe
        },
    }

end

function unilib.pkg.decor_stone_cracked.post()

    for stone_type, _ in pairs(unilib.global.super_stone_table) do

        local smooth_name = "unilib:stone_" .. stone_type

        local smooth_def_table = core.registered_nodes[smooth_name]
        if smooth_def_table ~= nil then

            local orig_name
            if stone_type == "desert" then
                orig_name = "lib_materials:cobble_stone_desert_default"
            end

            unilib.register_node(
                -- From GLEMr4, lib_materials:cobble_stone_desert_default
                "unilib:decor_stone_" .. stone_type .. "_cracked",
                orig_name,
                mode,
                {
                    description = unilib.utils.brackets(smooth_def_table.description, S("Cracked")),
                    tiles = {
                        smooth_def_table.tiles[1] .. "^(unilib_stone_ordinary_cobble.png" ..
                                "^[mask:unilib_mask_stone_cobble.png)",
                    },
                    groups = {cracky = 3, stone = 2},
                    -- N.B. sounds missing in original code
                    sounds = unilib.global.sound_table.stone,

                    -- N.B. is_ground_content = false not in original code; added to match other
                    --      decor items
                    is_ground_content = false,
                }
            )
            unilib.register_craft({
                -- Original to unilib
                type = "shapeless",
                output = "unilib:decor_stone_" .. stone_type .. "_cracked 3",
                recipe = {smooth_name, smooth_name, smooth_name, "group:pickaxe"},
            })

        end

    end

end
