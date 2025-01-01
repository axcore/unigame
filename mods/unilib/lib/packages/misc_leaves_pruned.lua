---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_leaves_pruned = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_leaves_pruned.init()

    return {
        description = "Light decorative hedge",
        notes = "ethereal-ng creates leaves blocks that are taller than normal blocks. It also" ..
                " provides a couple of blocks that use the same textures as leaves, but are the" ..
                " normal size. This package provides a \"pruned\" block for all super-trees." ..
                " If the Minetest setting (unilib.global.leaves_visual_scale) is 1, then you" ..
                " won't notice much of a different between the normal and pruned leaves",
        depends = "tree_aspen",
    }

end

function unilib.pkg.misc_leaves_pruned.post()

    -- N.B. ethereal:bush3 was removed in later versions of ethereal-ng
    local orig_table = {
        aspen = "ethereal:bush2",
        pine = "ethereal:bush3",
    }

    for part_name, _ in pairs(unilib.global.super_tree_table) do

        local pruned_name = "unilib:misc_leaves_pruned_" .. part_name
        local leaves_name = "unilib:tree_" .. part_name .. "_leaves"
        local orig_name = orig_table[part_name]

        local def_table = core.registered_nodes[leaves_name]
        if def_table ~= nil then

            unilib.register_node(pruned_name, orig_name, mode, {
                -- From ethereal:bush2
                description = unilib.utils.brackets(def_table.description, S("pruned")),
                tiles = def_table.tiles,
                groups = {flammable = 2, snappy = 3},
                sounds = unilib.global.sound_table.leaves,

                drawtype = "allfaces_optional",
                -- N.B. is_ground_content = false not in original code; added to match other leaves
                is_ground_content = false,
                paramtype = "light",
                walkable = true,
            })
            unilib.register_craft({
                -- From ethereal:bush2
                output = pruned_name,
                recipe = {
                    {"group:leaves", "group:leaves", "group:leaves"},
                    {"group:leaves", leaves_name, "group:leaves"},
                    {"group:leaves", "group:leaves", "group:leaves"},
                },
            })
            unilib.register_craft({
                -- From ethereal:bush2
                type = "fuel",
                recipe = pruned_name,
                burntime = 1,
            })

        end

    end

end
