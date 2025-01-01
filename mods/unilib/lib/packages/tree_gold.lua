---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_gold.init()

    return {
        description = "Gold-enriched wood",
        notes = "Any wood can be enriched with gold. It does not burn. There is no gold tree",
        depends = "metal_gold",
    }

end

function unilib.pkg.tree_gold.exec()

    unilib.register_tree({
        -- Original to unilib
        part_name = "gold",
        description = S("Gold-Enriched Wood"),

        incomplete_flag = true,
        not_super_flag = true,
        -- This tree does not have its own sapling
        incomplete_flag = true,
    })

    -- (no trunk, leaves or sapling)

    local on_place, place_param2
    if not unilib.setting.auto_rotate_wood_flag then
        on_place = core.rotate_node
    else
        place_param2 = 0
    end

    unilib.register_node("unilib:tree_gold_wood", "mtg_plus:goldwood", mode, {
        -- From mtg_plus:goldwood
        description = S("Gold-Enriched Wood Planks"),
        tiles = {"unilib_tree_gold_wood.png"},
        groups = {choppy = 2, wood = 1},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        -- N.B. no .paramtype2 in original code
        paramtype2 = "facedir",
        -- N.B. no .place_param2 in original code
        place_param2 = place_param2,

        -- N.B. no .on_place in original code
        on_place = on_place,
    })
    unilib.register_craft({
        -- From mtg_plus:goldwood
        type = "shapeless",
        output = "unilib:tree_gold_wood",
        recipe = {"group:wood", "unilib:metal_gold_ingot"},
    })
    -- If the code above is modified to use unilib.trees.register_wood(), then wood must not be used
    --      as furnace fuel (so uncomment the code below)
    --[[
    core.clear_craft({
        type = "fuel",
        recipe = "unilib:tree_gold_wood",
    })
    ]]--
    unilib.register_tree_wood_cuttings("gold")

    unilib.register_fence_quick({
        -- From mtg_plus:fence_goldwood. Creates unilib:tree_gold_wood_fence
        part_name = "gold",
        orig_name = "mtg_plus:fence_goldwood",

        replace_mode = mode,
        burnlevel = 0,
        description = S("Gold-Enriched Wood Fence"),
        group_table = {choppy = 2},
    })

    unilib.register_fence_rail_quick({
        -- From mtg_plus:fence_rail_goldwood. Creates unilib:tree_gold_wood_fence_rail
        part_name = "gold",
        orig_name = "mtg_plus:fence_rail_goldwood",

        replace_mode = mode,
        base_img = "unilib_tree_gold_wood_fence.png",
        burnlevel = 0,
        description = S("Gold-Enriched Wood Fence Rail"),
        group_table = {choppy = 2},
    })

    unilib.register_fence_gate_quick({
        -- From mtg_plus:gate_goldwood_closed, etc. Creates unilib:gate_wood_gold_closed, etc
        part_name = "gold",
        orig_name = {"mtg_plus:gate_goldwood_closed", "mtg_plus:gate_goldwood_open"},

        replace_mode = mode,
        burnlevel = 0,
        common_group = 2,
        description = S("Gold-Enriched Wood Fence Gate"),
        group_table = {choppy = 2},
    })

end
