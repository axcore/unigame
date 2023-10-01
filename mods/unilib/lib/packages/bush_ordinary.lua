---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_ordinary.init()

    return {
        description = "Ordinary bush",
        notes = "Code in this package can be used as a basis for all other bush packages. For" ..
                " comparison, the package includes both calls to shared functions (used by" ..
                " most bush packages), as well as the equivalent code from default (but" ..
                " simplified a little)",
        -- (Allow crafting bush stem into apple tree wood)
        optional = "tree_apple",
    }

end

function unilib.pkg.bush_ordinary.exec()

    local burnlevel = 2
    -- (no sci_name)

    --[[
    minetest.register_node("default:bush_stem", {
        -- From default:bush_stem
        description = S("Bush Stem"),
        tiles = {"default_bush_stem.png"},
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = default.node_sound_wood_defaults(),

        drawtype = "plantlike",
        inventory_image = "default_bush_stem.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
        },
        sunlight_propagates = true,
        visual_scale = 1.41,
        wield_image = "default_bush_stem.png",
    })
    minetest.register_craft({
        -- From default:bush_stem
        output = "default:wood",
        recipe = {
            {"default:bush_stem"},
        }
    })
    minetest.register_craft({
        -- From default:bush_stem
        type = "fuel",
        recipe = "default:bush_stem",
        burntime = 7,
    })
    ]]--
    unilib.register_bush_stem({
        -- From default:bush_stem. Creates unilib:bush_ordinary_stem
        part_name = "ordinary",
        orig_name = "default:bush_stem",

        replace_mode = mode,
        common_group = 2,
        description = S("Ordinary Bush Stem"),
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
    })
    if unilib.pkg_executed_table["tree_apple"] ~= nil then

        unilib.register_craft({
            -- From default:wood
            output = "unilib:tree_apple_wood",
            recipe = {
                {"unilib:bush_ordinary_stem"},
            }
        })

    end
    unilib.register_craft({
        -- From default:bush_stem
        type = "fuel",
        recipe = "unilib:bush_ordinary_stem",
        burntime = unilib.bush_burn_table.stem[burnlevel],
    })

    --[[
    minetest.register_node("default:bush_leaves", {
        -- From default:bush_leaves
        description = S("Bush Leaves"),
        tiles = {"default_leaves_simple.png"},
        groups = {flammable = 2, leaves = 1, snappy = 3},
        sounds = default.node_sound_leaves_defaults(),

        drawtype = "allfaces_optional",
        drop = {
            max_items = 1,
            items = {
                {items = {"default:bush_sapling"}, rarity = 5},
                {items = {"default:bush_leaves"}}
            }
        },
        paramtype = "light",

        after_place_node = after_place_leaves,
    })
    default.register_leafdecay({
        -- From default:bush_leaves
        trunks = {"default:bush_stem"},
        leaves = {"default:bush_leaves"},
        radius = 1,
    })
    ]]--
    unilib.register_bush_leaves({
        -- From default:bush_leaves. Creates unilib:bush_ordinary_leaves
        part_name = "ordinary",
        orig_name = "default:bush_leaves",

        replace_mode = mode,
        description = S("Ordinary Bush Leaves"),
        img_list = {"unilib_tree_apple_leaves_simple.png"},
    })
    unilib.register_quick_bush_leafdecay("ordinary")

    --[[
    local function grow_sapling(pos)

        -- Adapted from default/trees.lua

        if not unilib.can_grow_sapling(pos) then

            -- Try again 5 min later
            minetest.get_node_timer(pos):start(300)
            return

        end

        minetest.log(
            "action",
            "An ordinary bush sapling grows into a bush at "..minetest.pos_to_string(pos)
        )
    --
        minetest.place_schematic(
            {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
            unilib.path_mod .. "/schematics/bush_ordinary.mts",
            "0",
            nil,
            false
        )

    end

    minetest.register_node("default:bush_sapling", {
        -- From default:bush_sapling
        description = S("Bush Sapling"),
        tiles = {"default_bush_sapling.png"},
        groups = {
            attached_node = 1, dig_immediate = 3, flammable = 2, sapling = 1, snappy = 2,
        },
        sounds = default.node_sound_leaves_defaults(),

        drawtype = "plantlike",
        inventory_image = "default_bush_sapling.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "default_bush_sapling.png",

        on_construct = function(pos)
            minetest.get_node_timer(pos):start(math.random(300, 1500))
        end,

        on_place = function(itemstack, placer, pointed_thing)
            itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
                "default:bush_sapling",
                -- minp, maxp to be checked, relative to sapling pos
                {x = -1, y = 0, z = -1},
                {x = 1, y = 1, z = 1},
                -- maximum interval of interior volume check
                2)

            return itemstack
        end,

        on_timer = grow_sapling,
    })
    minetest.register_craft({
        type = "fuel",
        recipe = "default:bush_sapling",
        burntime = 3,
    })
    ]]--
    unilib.register_bush_sapling({
        -- From default:bush_sapling. Creates unilib:bush_ordinary_sapling
        part_name = "ordinary",
        orig_name = "default:bush_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Ordinary Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 1, y = 1, z = 1},
        minp_table = {x = -1, y = 0, z = -1},
        offset_list = {1, 1, 1},
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16},
    })
    unilib.register_craft({
        -- From default:bush_sapling
        type = "fuel",
        recipe = "unilib:bush_ordinary_sapling",
        burntime = unilib.bush_burn_table.sapling[burnlevel],
    })

    --[[
    minetest.register_decoration({
        -- From default/mapgen.lua
        name = "default:bush",
        deco_type = "schematic",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.01,
            seed = 137,
            spread = {x = 100, y = 100, z = 100},
        },
        schematic = minetest.get_modpath("default") .. "/schematics/bush.mts",
        sidelen = 16,

        biomes = {"grassland", "deciduous_forest"},
        place_on = {"default:dirt_with_grass"},
        y_max = 31000,
        y_min = 1,
    })
    ]]--
    unilib.register_decoration("default_bush_ordinary", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_bush_ordinary.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.01,
            seed = 137,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
