---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- trees.lua
--      Set up trees
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.trees = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for trees
local base_file = unilib.core.path_mod .. "/lib/shared/trees/trees_base.lua"

function unilib.register_tree(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_tree(...)

end

function unilib.register_tree_trunk(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_trunk(...)

end

function unilib.register_tree_trunk_stripped(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_trunk_stripped(...)

end

function unilib.register_tree_wood(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_wood(...)

end

function unilib.register_tree_leaves(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_leaves(...)

end

function unilib.register_tree_leaves_compacted(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_leaves_compacted(...)

end

function unilib.register_tree_sapling(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_sapling(...)

end

function unilib.register_tree_sapling_custom(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_sapling_custom(...)

end

function unilib.register_tree_panel(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_panel(...)

end

function unilib.register_tree_wood_cuttings(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_wood_cuttings(...)

end

function unilib.register_tree_panel_cuttings(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.trees._register_panel_cuttings(...)

end

-- Grow tree saplings
local grow_file = unilib.core.path_mod .. "/lib/shared/trees/trees_grow.lua"

function unilib.trees.grow_sapling(...)

    if not t[grow_file] then t[grow_file] = true; dofile(grow_file) end
    return unilib.trees._grow_sapling(...)

end

-- Generate treelog schematics
local gen_file = unilib.core.path_mod .. "/lib/shared/trees/trees_generate_log.lua"

function unilib.trees.generate_treelog_schematic(...)

    if not t[gen_file] then t[gen_file] = true; dofile(gen_file) end
    return unilib.trees._generate_treelog_schematic(...)

end

-- Registry functions for fences
local fen_file = unilib.core.path_mod .. "/lib/shared/trees/trees_fence.lua"

function unilib.register_fence(...)

    if not t[fen_file] then t[fen_file] = true; dofile(fen_file) end
    return unilib.trees._register_fence(...)

end

function unilib.register_fence_rail(...)

    if not t[fen_file] then t[fen_file] = true; dofile(fen_file) end
    return unilib.trees._register_fence_rail(...)

end

-- Quick registry functions for fences
local qfen_file = unilib.core.path_mod .. "/lib/shared/trees/trees_fence_quick.lua"

function unilib.register_fence_all(...)

    if not t[qfen_file] then t[qfen_file] = true; dofile(qfen_file) end
    return unilib.trees._register_fence_all(...)

end

function unilib.register_fence_quick(...)

    if not t[qfen_file] then t[qfen_file] = true; dofile(qfen_file) end
    return unilib.trees._register_fence_quick(...)

end

function unilib.register_fence_rail_quick(...)

    if not t[qfen_file] then t[qfen_file] = true; dofile(qfen_file) end
    return unilib.trees._register_fence_rail_quick(...)

end

function unilib.register_fence_gate_quick(...)

    if not t[qfen_file] then t[qfen_file] = true; dofile(qfen_file) end
    return unilib.trees._register_fence_gate_quick(...)

end

-- Registry functions for bookshelves
local book_file = unilib.core.path_mod .. "/lib/shared/trees/trees_shelf_book.lua"

function unilib.register_bookshelf(...)

    if not t[book_file] then t[book_file] = true; dofile(book_file) end
    return unilib.trees._register_bookshelf(...)

end

-- Registry functions for vessel shelves
local ves_file = unilib.core.path_mod .. "/lib/shared/trees/trees_shelf_vessel.lua"

function unilib.register_vessels_shelf(...)

    if not t[ves_file] then t[ves_file] = true; dofile(ves_file) end
    return unilib.trees._register_vessels_shelf(...)

end

-- Registry functions for utility shelves
local util_file = unilib.core.path_mod .. "/lib/shared/trees/trees_shelf_utility.lua"

function unilib.register_utility_shelf(...)

    if not t[util_file] then t[util_file] = true; dofile(util_file) end
    return unilib.trees._register_utility_shelf(...)

end

function unilib.register_empty_utility_shelf(...)

    if not t[util_file] then t[util_file] = true; dofile(util_file) end
    return unilib.trees._register_empty_utility_shelf(...)

end
