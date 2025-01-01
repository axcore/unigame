---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_dirty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_dirty.init()

    return {
        description = "Decorative dirty stone",
        notes = "This package creates nodes from the full range of super stones",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.decor_stone_dirty.post()

    for stone_type, _ in pairs(unilib.global.super_stone_table) do

        local smooth_def_table = core.registered_nodes["unilib:stone_" .. stone_type]
        if smooth_def_table ~= nil then

            local orig_name
            if stone_type == "ordinary" then
                orig_name = "lib_materials:dirt_stone"
            end

            unilib.register_node("unilib:decor_stone_" .. stone_type .. "_dirty", orig_name, mode, {
                -- From GLEMr4, lib_materials:dirt_stone
                description = unilib.utils.brackets(smooth_def_table.description, S("Dirty")),
                tiles = {
                    smooth_def_table.tiles[1] ..
                            "^(unilib_dirt_ordinary.png^[mask:unilib_mask_stone.png)",
                },
                groups = {cracky = 3, stone = 2},
                -- N.B. sounds missing in original code
                sounds = unilib.global.sound_table.stone,

                -- N.B. is_ground_content = false not in original code; added to match other decor
                --      items
                is_ground_content = false,
            })
            unilib.register_craft({
                -- Original to unilib
                type = "shapeless",
                output = "unilib:decor_stone_" .. stone_type .. "_dirty",
                recipe = {"unilib:stone_" .. stone_type, "unilib:dirt_ordinary"},
            })

        end

        local cobble_def_table = core.registered_nodes["unilib:stone_" .. stone_type .. "_cobble"]
        if cobble_def_table ~= nil then

            local orig_name
            if stone_type == "ordinary" then
                orig_name = "lib_materials:dirt_cobble_stone"
            elseif stone_type == "desert" then
                orig_name = "lib_materials:dirt_desert_cobble_stone"
            end

            unilib.register_node(
                -- From GLEMr4, lib_materials:dirt_cobble_stone
                "unilib:decor_stone_" .. stone_type .. "_cobble_dirty",
                orig_name,
                mode,
                {
                    description = unilib.utils.brackets(cobble_def_table.description, S("Dirty")),
                    tiles = {
                        cobble_def_table.tiles[1] ..
                                "^(unilib_dirt_ordinary.png^[mask:unilib_mask_stone_cobble.png)",
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
                output = "unilib:decor_stone_" .. stone_type .. "_cobble_dirty",
                recipe = {"unilib:stone_" .. stone_type .. "_cobble", "unilib:dirt_ordinary"},
            })

        end

    end

end
