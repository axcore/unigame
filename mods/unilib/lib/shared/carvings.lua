---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- carvings.lua
--      Set up shared functions for carvings (from mods "columnia", "facade" and "mymillwork")
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local c_blueprint = "unilib:misc_blueprint_column"

-- Node shape tables for all carving types
local node_shape_table = {
    column_centre = {
        {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
    },
    column_top = {
        {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
        {-0.375, 0, -0.375, 0.375, 0.5, 0.375},
    },
    column_bottom = {
        {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
        {-0.375, -0.5, -0.375, 0.375, 0, 0.375},
    },
    column_crosslink = {
        {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        {-0.5, 0, -0.25, 0.5, 0.5, 0.25},
        {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
        {-0.4375, 0.0625, -0.4375, 0.4375, 0.4375, 0.4375},
    },
    column_link = {
        {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
    },
    column_downlink = {
        {-0.25, 0, -0.5, 0.25, 0.5, 0.5},
        {-0.125, -0.5, -0.125, 0.125, 0, 0.125},
        {-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875},
        {-0.1875, -0.125, -0.1875, 0.1875, 0, 0.1875},
    },
    facade_bannerstone = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-0.5, 0.25, -0.5625, 0.5, 0.375, -0.5},
        {-0.5, -0.375, -0.5625, 0.5, -0.25, -0.5},
    },
    facade_bannerstone_corner = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        {-0.5625, 0.25, -0.5625, 0.5625, 0.375, 0.5625},
        {-0.5625, -0.375, -0.5625, 0.5625, -0.25, 0.5625},
    },
    facade_centrestone = {
        {-0.4375, -0.4375, -0.4375, 0.4375, 0.4375, 0.4375},
        {-0.5, -0.25, 0.0625, 0.5, 0.25, 0.25},
        {-0.5, -0.25, -0.25, 0.5, 0.25, -0.0625},
        {-0.25, -0.25, -0.5, -0.0625, 0.25, 0.5},
        {0.0625, -0.25, -0.5, 0.25, 0.25, 0.5},
        {-0.5, 0.0625, -0.25, 0.5, 0.25, 0.25},
        {-0.5, -0.25, -0.25, 0.5, -0.0625, 0.25},
        {-0.25, -0.25, -0.5, 0.25, -0.0625, 0.5},
        {-0.25, 0.0625, -0.5, 0.25, 0.25, 0.5},
        {-0.25, -0.5, -0.25, 0.25, 0.5, -0.0625},
        {-0.25, -0.5, 0.0625, 0.25, 0.5, 0.25},
        {0.0625, -0.5, -0.1875, 0.25, 0.5, 0.1875},
        {-0.25, -0.5, -0.1875, -0.0625, 0.5, 0.1875},
        {-0.5, 0.3125, 0.3125, 0.5, 0.5, 0.5},
        {-0.5, 0.3125, -0.5, 0.5, 0.5, -0.3125},
        {0.3125, 0.3125, -0.5, 0.5, 0.5, 0.5},
        {-0.5, 0.3125, -0.5, -0.3125, 0.5, 0.5},
        {-0.5, -0.5, -0.5, -0.3125, -0.3125, 0.5},
        {0.3125, -0.5, -0.5, 0.5, -0.3125, 0.5},
        {-0.5, -0.5, -0.5, 0.5, -0.3125, -0.3125},
        {-0.5, -0.5, 0.3125, 0.5, -0.3125, 0.5},
        {0.3125, -0.5, -0.5, 0.5, 0.5, -0.3125},
        {0.3125, -0.5, 0.3125, 0.5, 0.5, 0.5},
        {-0.5, -0.5, 0.3125, -0.3125, 0.5, 0.5},
        {-0.5, -0.5, -0.5, -0.3125, 0.5, -0.3125},
    },
    facade_column = {
        {-0.5, -0.5, -0.4375, 0.5, 0.5, 0.4375},
        {-0.5, -0.5, -0.5, -0.3125, 0.5, 0.5},
        {0.3125, -0.5, -0.5, 0.5, 0.5, 0.5},
        {0.0625, -0.5, -0.5, 0.1875, 0.5, 0.5},
        {-0.1875, -0.5, -0.5, -0.0625, 0.5, 0.5},
    },
    facade_column_corner = {
        {-0.4375, -0.5, -0.4375, 0.4375, 0.5, 0.4375},
        {-0.5, -0.5, 0.3125, -0.3125, 0.5, 0.5},
        {0.3125, -0.5, -0.5, 0.5, 0.5, -0.3125},
        {0.0625, -0.5, -0.5, 0.1875, 0.5, 0.5},
        {-0.1875, -0.5, -0.5, -0.0625, 0.5, 0.5},
        {0.3125, -0.5, 0.3125, 0.5, 0.5, 0.5},
        {-0.5, -0.5, -0.5, -0.3125, 0.5, -0.3125},
        {-0.5, -0.5, 0.0625, 0.5, 0.5, 0.1875},
        {-0.5, -0.5, -0.1875, 0.5, 0.5, -0.0625},
    },
    facade_corbel = {
        {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
        {-0.1875, -0.3125, -0.3125, 0.1875, 0.5, 0},
    },
    facade_corbel_corner = {
        {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.5, 0, 0, 0.5, 0.5},
        {0, -0.3125, -0.3125, 0.3125, 0.5, 0},
    },
    facade_corbel_corner_inner = {
        {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
        {0, -0.3125, -0.3125, 0.3125, 0.5, 0},
        {-0.5, -0.5, -0.5, 0, 0.5, 0.5},
    },
    facade_swirl = {
        {-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},
        {-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
        {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        {-0.4375, -0.375, -0.5, -0.3125, 0.375, -0.4375},
        {-0.5, -0.375, -0.5, -0.3125, -0.25, 0.5},
        {-0.4375, 0.25, -0.5, 0.4375, 0.375, 0.5},
        {0.3125, -0.125, -0.5, 0.4375, 0.25, 0.5},
        {-0.1875, -0.375, -0.5, 0.5, -0.25, 0.5},
        {-0.1875, -0.25, -0.5, -0.0625, 0.125, 0.5},
        {0.0625, -0.125, -0.5, 0.3125, 0, 0.5},
        {-0.0625, 0, -0.5, 0.1875, 0.125, 0.5},
    },
    facade_swirl_corner = {
        {-0.4375, -0.5, -0.4375, 0.5, 0.5, 0.5},
        {-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
        {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        {-0.4375, -0.375, -0.5, -0.3125, 0.375, -0.4375},
        {-0.5, -0.375, -0.5, -0.3125, -0.25, 0.1875},
        {-0.4375, 0.25, -0.5, 0.4375, 0.375, 0.5},
        {0.3125, -0.125, -0.5, 0.4375, 0.25, 0.5},
        {-0.1875, -0.375, -0.5, 0.5, -0.25, 0.5},
        {-0.1875, -0.25, -0.5, -0.0625, 0.125, 0.5},
        {0.0625, -0.125, -0.5, 0.3125, 0, 0.5},
        {-0.0625, 0, -0.5, 0.1875, 0.125, 0.5},
        {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
        {-0.5, -0.125, -0.4375, 0.5, 0.375, -0.3125},
        {-0.5, 0.25, -0.3125, 0.5, 0.375, 0.4375},
        {-0.5, -0.375, 0.3125, 0.4375, 0.375, 0.4375},
        {-0.5, -0.375, 0.3125, 0.4375, -0.25, 0.5},
        {-0.5, -0.125, -0.3125, 0.4375, 0, -0.0625},
        {-0.5, 0, -0.1875, 0.4375, 0.125, 0.1875},
        {-0.5, -0.25, 0.0625, 0.4375, 0.125, 0.1875},
    },
    facade_fascia = {
        {-0.5, -0.5, 0.375, 0.5, -0.3125, 0.5},
        {-0.5, -0.3125, 0.25, 0.5, -0.125, 0.5},
        {-0.5, -0.125, 0.125, 0.5, 0.5, 0.5},
    },
    facade_fascia_corner_inner = {
        {-0.5, -0.5, 0.375, 0.5, -0.3125, 0.5},
        {-0.5, -0.3125, 0.25, 0.5, -0.125, 0.5},
        {-0.5, -0.125, 0.125, 0.5, 0.5, 0.5},
        {0.375, -0.5, -0.5, 0.5, -0.3125, 0.375},
        {0.25, -0.3125, -0.5, 0.5, -0.0625, 0.25},
        {0.125, -0.125, -0.5, 0.5, 0.5, 0.125},
    },
    facade_fascia_corner_outer = {
        {-0.5, -0.5, 0.375, 0.5, -0.3125, 0.5},
        {-0.5, -0.3125, 0.25, 0.5, -0.0625, 0.5},
        {-0.5, -0.125, 0.125, 0.5, 0.5, 0.5},
        {-0.625, -0.5, 0.375, -0.5, -0.3125, 1.5},
        {-0.75, -0.3125, 0.25, -0.5, -0.125, 1.5},
        {-0.875, -0.125, 0.125, -0.5, 0.5, 1.5},
    },
    facade_bricks_corner = {
        {-0.5625, -0.5, 0.4375, -0.5, 0, 1},
        {-0.5, -0.5, 0.4375, 0, 0, 0.5},
        {-0.5625, 0, 0.5, -0.5, 0.5, 1.5},
        {-0.5625, 0, 0.4375, 0.5, 0.5, 0.5},
    },
    mill_crownmould = {
        {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
        {-0.5, -0.375, 0.125, 0.5, -0.125, 0.375},
        {-0.5, -0.375, 0.375, 0.5, 0.5, 0.5},
    },
    mill_crownmould_corner_inner = {
        {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
        {-0.5, -0.375, 0.125, 0.375, -0.125, 0.375},
        {0.125, -0.375, -0.5, 0.375, -0.125, 0.125},
        {-0.5, -0.375, 0.375, 0.5, 0.5, 0.5},
        {0.375, -0.375, -0.5, 0.5, 0.5, 0.375},
    },
    mill_crownmould_corner_outer = {
        {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
        {-0.5, -0.375, 0.125, -0.125, -0.125, 0.5},
        {-0.5, -0.125, 0.375, -0.375, 0.5, 0.5},
    },
    mill_crownmould_beam = {
        {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
        {-0.5, -0.375, 0.125, 0.5, -0.125, 0.375},
        {-0.25, -0.375, -0.5, 0.25, -0.1875, 0.125},
        {-0.5, -0.375, 0.375, 0.5, 0.5, 0.5},
    },
    mill_column = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    mill_column_base = {
        {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
    },
    mill_column_half = {
        {-0.5, -0.5, 0.0, 0.5, 0.5, 0.5},
    },
    mill_column_half_base = {
        {-0.5, -0.5, 0.0, 0.5, 0.5, 0.5},
    },
    mill_column_half_base_beam = {
        {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
        {-0.5, -0.375, 0.0, 0.5, 0.5, 0.5},
        {-0.25, -0.375, -0.5, 0.25, -0.1875, 0.0},
    },
    mill_column_quarter = {
        {-0.5, -0.5, 0, 0, 0.5, 0.5},
    },
    mill_column_quarter_base = {
        {-0.5, -0.5, 0, 0, 0.5, 0.5},
    },
    mill_column_quarter_base_board = {
        {-0.5, -0.5, 0, 0, 0.5, 0.5},
        {0.0, -0.5, 0.4375, 0.5, -0.1875, 0.5},
        {-0.5, -0.5, -0.5, -0.4375, -0.1875, 0.0},
    },
    mill_column_quarter_base_fancy = {
        {-0.5, -0.5, 0, 0, 0.5, 0.5},
        {0.0, -0.5, 0.3125, 0.5, 0.1875, 0.5},
        {-0.5, -0.5, -0.5, -0.3125, 0.1875, 0.0},
    },
    mill_ceiling = {
        {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
    },
    mill_ceiling_post = {
        {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        {-0.125, -0.4375, -0.125, 0.125, 0.5, 0.125},
    },
    mill_beam = {
        {-0.25, -0.5, -0.5, 0.25, -0.1875, 0.5},
    },
    mill_beam_t = {
        {-0.5, -0.5, -0.25, -0.25, -0.1875, 0.25},
        {-0.25, -0.5, -0.5, 0.25, -0.1875, 0.5},
        {0.25, -0.5, -0.25, 0.5, -0.1875, 0.25},
    },
    mill_ceiling_beam_t = {
        {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        {-0.5, -0.4375, -0.25, -0.25, -0.1875, 0.25},
        {-0.25, -0.4375, -0.5, 0.25, -0.1875, 0.5},
        {0.25, -0.4375, -0.25, 0.5, -0.1875, 0.25},
    },
    mill_base = {
        {-0.5, -0.5, 0.4375, 0.5, -0.1875, 0.5},
    },
    mill_base_corner_inner = {
        {-0.5, -0.5, 0.4375, 0.5, -0.1875, 0.5},
        {-0.5, -0.5, -0.5, -0.4375, -0.1875, 0.4375},
    },
    mill_base_corner_outer = {
        {0.4375, -0.5, 0.4375, 0.5, -0.1875, 0.5},
    },
    mill_base_fancy = {
        {-0.5, -0.5, 0.3125, 0.5, 0.1875, 0.5},
    },
    mill_base_fancy_corner_inner = {
        {-0.5, -0.5, 0.3125, 0.5, 0.1875, 0.5},
        {-0.5, -0.5, -0.5, -0.3125, 0.1875, 0.3125},
    },
    mill_base_fancy_corner_outer = {
        {0.3125, -0.5, 0.3125, 0.5, 0.1875, 0.5},
    }
}

-- Extra shape tables for a couple of carving types
local extra_shape_table = {
    mill_base_corner_inner = {
        {-0.5, -0.5, 0.4375, 0.5, -0.1875, 0.5},
    },
    mill_base_corner_outer = {
        {-0.5, -0.5, 0.4375, 0.5, -0.1875, 0.5},
    }
}

---------------------------------------------------------------------------------------------------
-- Populate global variables
---------------------------------------------------------------------------------------------------

-- Table used by various machines to calculate ingredients consumed
unilib.carving_output_table = {
    -- From columnia
    _column_centre = 4,
    _column_top = 1,
    _column_bottom = 1,
    _column_crosslink = 1,
    _column_link = 4,
    _column_downlink = 4,
    -- From facade
    _facade_bannerstone = 1,
    _facade_bannerstone_corner = 1,
    _facade_centrestone = 1,
    _facade_column = 1,
    _facade_column_corner = 1,
    _facade_corbel = 1,
    _facade_corbel_corner = 1,
    _facade_corbel_corner_inner = 1,
    _facade_swirl = 1,
    _facade_swirl_corner = 1,
    _facade_fascia = 2,
    _facade_fascia_corner_inner = 1,
    _facade_fascia_corner_outer = 1,
    _facade_bricks_corner = 2,
    -- From mymillwork
    _mill_crownmould = 1,
    _mill_crownmould_corner_inner = 1,
    _mill_crownmould_corner_outer = 1,
    _mill_crownmould_beam = 1,
    _mill_column = 1,
    _mill_column_base = 1,
    _mill_column_half = 2,
    _mill_column_half_base = 2,
    _mill_column_half_base_beam = 1,
    _mill_column_quarter = 4,
    _mill_column_quarter_base = 4,
    _mill_column_quarter_base_board = 2,
    _mill_column_quarter_base_fancy = 2,
    _mill_ceiling = 6,
    _mill_ceiling_post = 4,
    _mill_beam = 2,
    _mill_beam_t = 2,
    _mill_ceiling_beam_t = 2,
    _mill_base = 8,
    _mill_base_corner_inner = 4,
    _mill_base_corner_outer = 10,
    _mill_base_fancy = 6,
    _mill_base_fancy_corner_inner = 3,
    _mill_base_fancy_corner_outer = 8,
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function warn_if_exists(adj_full_name)

    -- Adapted from stairs/init.lua

    if minetest.registered_nodes[adj_full_name] then
        unilib.show_warning("../lib/shared/carvings.lua: Overwriting carving node", adj_full_name)
    end

end

local function prepare_column(full_name, def_table, adj_full_name, adj_desc, show_flag, shape_table)

    -- Adapted from columnia/init.lua

    -- Update the original node's groups field
    local adj_group_table = table.copy(def_table.groups)
    if not show_flag then
        adj_group_table.not_in_creative_inventory = 1
    else
        adj_group_table.not_in_creative_inventory = nil
    end

    -- columnia groups did not match the original node's groups very closely (perhaps they were
    --      copied from an ancient version of minetest_game)
    -- This algorithm makes the two sets of groups match more closely, while preserving the
    --      integrity of groups for any node not carved by columnia
    adj_group_table.stone = nil
    adj_group_table.level = nil
    if adj_group_table.wood ~= nil then

        adj_group_table.wood = nil
        if adj_group_table.snappy == nil then
            adj_group_table.snappy = 2
        end

    end

    -- Basic check
    warn_if_exists(adj_full_name)

    -- Prepare to register the node (the function is a simplified version of
    --      unilib.register_node() )
    local adj_def_table = {
        description = adj_desc,
        tiles = {def_table.tiles[1]},
        groups = adj_group_table,
        sounds = def_table.sounds,

        drawtype = "nodebox",
        -- (is_ground_content was true in original columnia code)
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = shape_table,
        },
        paramtype = "light",
        paramtype2 = "facedir",
        -- Packages "glass_ordinary" and "glass_obsidian", and presumably others too, generate
        --      warnings about textures unless this line is included
        use_texture_alpha = "clip",

        on_place = function(itemstack, placer, pointed_thing)

            if pointed_thing.type ~= "node" then
                return itemstack
            end

            local p0 = pointed_thing.under
            local p1 = pointed_thing.above
            local param2 = 0

            local placer_pos = placer:get_pos()
            if placer_pos then

                local dir = {
                    x = p1.x - placer_pos.x,
                    y = p1.y - placer_pos.y,
                    z = p1.z - placer_pos.z
                }
                param2 = minetest.dir_to_facedir(dir)

            end

            if p0.y-1 == p1.y then

                param2 = param2 + 20
                if param2 == 21 then
                    param2 = 23
                elseif param2 == 23 then
                    param2 = 21
                end

            end

            return minetest.item_place(itemstack, placer, pointed_thing, param2)

        end,
    }

    -- Light from light sources is reduced by a third (not in original columnia code, but done to be
    --      consistent with reduced-light stairs)
    if def_table.light_source ~= nil and def_table.light_source > 0 then

        if not unilib.reduce_carvings_light_flag then
            adj_def_table.light_source = def_table.light_source
        else
            adj_def_table.light_source = math.ceil(def_table.light_source * 0.66)
        end

    end

    if def_table.sunlight_propagates ~= nil then
        adj_def_table.sunlight_propagates = def_table.sunlight_propogates
    end

    -- Register the node
    unilib.register_node_carving_variant(adj_full_name, adj_def_table)
    -- Update global variables
    unilib.carving_deconvert_table[adj_full_name] = full_name
    if unilib.carving_convert_table[full_name] == nil then
        unilib.carving_convert_table[full_name] = {adj_full_name}
    else
        table.insert(unilib.carving_convert_table[full_name], adj_full_name)
    end

end

local function prepare_facade(
    full_name, def_table, adj_full_name, adj_desc, show_flag, img_list, shape_table, select_flag
)
    -- Adapted from facade/init.lua

    -- Update the original node's groups field (which was the same for everything)
    -- The original facade code was only applied to stone, but unilib code is less strict, so we
    --      have to be prepared for woods and other node types
    local group_table = table.copy(def_table.groups)
    local adj_group_table = {cracky = 3, oddly_breakable_by_hand = 2}
    if group_table.stone ~= nil then
        adj_group_table.stone = 1
    end

    if not show_flag then
        adj_group_table.not_in_creative_inventory = 1
    else
        adj_group_table.not_in_creative_inventory = nil
    end

    -- Basic check
    warn_if_exists(adj_full_name)

    -- Prepare to register the node (the function is a simplified version of
    --      unilib.register_node() )
    local adj_def_table = {
        description = adj_desc,
        tiles = img_list,
        groups = adj_group_table,
        sounds = def_table.sounds,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = shape_table,
        },
        paramtype = "light",
        paramtype2 = "facedir",
        -- Packages "glass_ordinary" and "glass_obsidian", and presumably others too, generate
        --      warnings about textures unless this line is included
        use_texture_alpha = "clip",
    }

    if select_flag ~= nil then

        adj_def_table.selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        }

    end

    -- Light from light sources is reduced by a third (not in original facade code, but done to be
    --      consistent with reduced-light stairs)
    if def_table.light_source ~= nil and def_table.light_source > 0 then

        if not unilib.reduce_carvings_light_flag then
            adj_def_table.light_source = def_table.light_source
        else
            adj_def_table.light_source = math.ceil(def_table.light_source * 0.66)
        end

    end

    if def_table.sunlight_propagates ~= nil then
        adj_def_table.sunlight_propagates = def_table.sunlight_propogates
    end

    -- Register the node
    unilib.register_node_carving_variant(adj_full_name, adj_def_table)
    -- Update global variables
    unilib.carving_deconvert_table[adj_full_name] = full_name
    if unilib.carving_convert_table[full_name] == nil then
        unilib.carving_convert_table[full_name] = {adj_full_name}
    else
        table.insert(unilib.carving_convert_table[full_name], adj_full_name)
    end

end

local function prepare_millwork(
    full_name, def_table, adj_full_name, adj_desc, show_flag, model, select_table, collide_table
)
    -- Adapted from mymillwork/nodes.lua

    -- Most (but not all) millwork nodes have identical collision/selection tables
    if collide_table == nil then
        collide_table = select_table
    end

    -- Update the original node's groups field
    local adj_group_table = table.copy(def_table.groups)
    if not show_flag then
        adj_group_table.not_in_creative_inventory = 1
    else
        adj_group_table.not_in_creative_inventory = nil
    end

    -- Basic check
    warn_if_exists(adj_full_name)

    -- Prepare to register the node (the function is a simplified version of
    --      unilib.register_node() )
    local adj_def_table = {
        description = adj_desc,
        tiles = {def_table.tiles[1]},
        groups = adj_group_table,
        sounds = def_table.sounds,

        collision_box = {
            type = "fixed",
            fixed = collide_table,
        },
        drawtype = "mesh",
        -- is_ground_content not in original mymillwork code, but used to be consistent with other
        --      carvings
        is_ground_content = false,
        mesh = model,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = select_table,
        },
        -- Packages "glass_ordinary" and "glass_obsidian", and presumably others too, generate
        --      warnings about textures unless this line is included
        use_texture_alpha = "clip",

        on_place = minetest.rotate_node,
    }

    -- Light from light sources is reduced by a third (not in original mymillwork code, but done to
    --      be consistent with reduced-light stairs)
    if def_table.light_source ~= nil and def_table.light_source > 0 then

        if not unilib.reduce_carvings_light_flag then
            adj_def_table.light_source = def_table.light_source
        else
            adj_def_table.light_source = math.ceil(def_table.light_source * 0.66)
        end

    end

    if def_table.sunlight_propagates ~= nil then
        adj_def_table.sunlight_propagates = def_table.sunlight_propogates
    end

    -- Register the node
    unilib.register_node_carving_variant(adj_full_name, adj_def_table)
    -- Update global variables
    unilib.carving_deconvert_table[adj_full_name] = full_name
    if unilib.carving_convert_table[full_name] == nil then
        unilib.carving_convert_table[full_name] = {adj_full_name}
    else
        table.insert(unilib.carving_convert_table[full_name], adj_full_name)
    end

end

local function create_fuel_recipe(full_name, adj_full_name, factor)

    -- Adapted from stairs/init.lua

    local base_burn_time = minetest.get_craft_result({
        method = "fuel",
        width = 1,
        items = {full_name}
    }).time

    if base_burn_time > 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = adj_full_name,
            burntime = math.floor(base_burn_time * factor),
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (functions to register multiple types of carving)
---------------------------------------------------------------------------------------------------

function unilib.register_carvings(full_name, data_table)

    -- Original to unilib
    -- Most code will call this function to create all available carving types for a node
    --
    -- Other functions below are the direct equivalents of functions in columnia, facade and
    --      mymillwork, and can be called directly, if needed. None of them check Minetest settings,
    --      so the calling code must do that
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Optional args:
    --      data_table (table or nil): If specified, contains any of the fields:
    --          .all_flag (bool): If true, all column/facade/millwork nodes are created as if
    --              .column_flag, .facade_flag and .millwork_flag were all true (but not as if
    --              .brick_flag is true; that is something separate)
    --          .column_flag (bool): If true, all column nodes are created. If false or not
    --              specified, or if Minetest settings prohibit them, they are NOT created
    --          .facade_flag (bool): If true, all facade nodes (except corner bricks) are created.
    --              If false or not specified, or if Minetest settings prohibit them, they are NOT
    --              created. Facades look best on smooth stones, hard clays, etc)
    --          .brick_flag (bool): If true, then the corner bricks facade node is created. If false
    --              or not specified, it is NOT created
    --          .millwork_flag (bool): If true, all millwork nodes are created. If false or not
    --              specified, or if Minetest settings prohibit them, millwork nodes are NOT created

    -- (Any of unilib.add_carvings_column_flag, add_carvings_facade_flag or
    --      .add_carvings_millwork_flag are true)
    if unilib.add_carvings_any_flag then

        local def_table = minetest.registered_nodes[full_name]
        if def_table == nil then

            return unilib.show_error(
                "../lib/shared/carvings.lua: cannot add carvings because \"@1\" is not a" ..
                        " registered node",
                full_name
            )

        elseif def_table.groups ~= nil then

            -- Carvings made from soils must not be used to grow crops, etc
            def_table.groups.soil = nil

        end

        if data_table == nil then
            data_table = {}
        end

        unilib.register_carvings_all(
            full_name,
            unilib.get_item_name(full_name),
            def_table,
            data_table
        )

    end

end

function unilib.register_carvings_all(full_name, item_name, def_table, data_table)

    -- Original to unilib
    -- This function and unilib.register_carvings() are separate, in order to preserve the structure
    --      of code in ../lib/shared/stairs.lua. There is probably no need to call this function
    --      from anywhere else in the code
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      item_name (str): e.g. "stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_carvings()

    -- Create carving nodes derived from "full_name"
    if unilib.add_carvings_column_flag and
            (data_table.all_flag or data_table.column_flag) then

        unilib.register_carvings_column_centre(full_name, def_table)
        unilib.register_carvings_column_top(full_name, def_table)
        unilib.register_carvings_column_bottom(full_name, def_table)
        unilib.register_carvings_column_crosslink(full_name, def_table)
        unilib.register_carvings_column_link(full_name, def_table)
        unilib.register_carvings_column_downlink(full_name, def_table)

    end

    if unilib.add_carvings_facade_flag then

        if data_table.all_flag or data_table.facade_flag == true then

            unilib.register_carvings_facade_bannerstone(full_name, def_table)
            unilib.register_carvings_facade_bannerstone_corner(full_name, def_table)
            unilib.register_carvings_facade_centrestone(full_name, def_table)
            unilib.register_carvings_facade_column(full_name, def_table)
            unilib.register_carvings_facade_column_corner(full_name, def_table)
            unilib.register_carvings_facade_corbel(full_name, def_table)
            unilib.register_carvings_facade_corbel_corner(full_name, def_table)
            unilib.register_carvings_facade_corbel_corner_inner(full_name, def_table)
            unilib.register_carvings_facade_swirl(full_name, def_table)
            unilib.register_carvings_facade_swirl_corner(full_name, def_table)
            unilib.register_carvings_facade_fascia(full_name, def_table)
            unilib.register_carvings_facade_fascia_corner_inner(full_name, def_table)
            unilib.register_carvings_facade_fascia_corner_outer(full_name, def_table)

        end

        if data_table.brick_flag == true then
            unilib.register_carvings_facade_bricks_corner(full_name, def_table)
        end

    end

    if unilib.add_carvings_millwork_flag and
            (data_table.all_flag or data_table.millwork_flag) then

        unilib.register_carvings_mill_crownmould(full_name, def_table)
        unilib.register_carvings_mill_crownmould_corner_inner(full_name, def_table)
        unilib.register_carvings_mill_crownmould_corner_outer(full_name, def_table)
        unilib.register_carvings_mill_crownmould_beam(full_name, def_table)
        unilib.register_carvings_mill_column(full_name, def_table)
        unilib.register_carvings_mill_column_base(full_name, def_table)
        unilib.register_carvings_mill_column_half(full_name, def_table)
        unilib.register_carvings_mill_column_half_base(full_name, def_table)
        unilib.register_carvings_mill_column_half_base_beam(full_name, def_table)
        unilib.register_carvings_mill_column_quarter(full_name, def_table)
        unilib.register_carvings_mill_column_quarter_base(full_name, def_table)
        unilib.register_carvings_mill_column_quarter_base_board(full_name, def_table)
        unilib.register_carvings_mill_column_quarter_base_fancy(full_name, def_table)
        unilib.register_carvings_mill_ceiling(full_name, def_table)
        unilib.register_carvings_mill_ceiling_post(full_name, def_table)
        unilib.register_carvings_mill_beam(full_name, def_table)
        unilib.register_carvings_mill_beam_t(full_name, def_table)
        unilib.register_carvings_mill_ceiling_beam_t(full_name, def_table)
        unilib.register_carvings_mill_base(full_name, def_table)
        unilib.register_carvings_mill_base_corner_inner(full_name, def_table)
        unilib.register_carvings_mill_base_corner_outer(full_name, def_table)
        unilib.register_carvings_mill_base_fancy(full_name, def_table)
        unilib.register_carvings_mill_base_fancy_corner_inner(full_name, def_table)
        unilib.register_carvings_mill_base_fancy_corner_outer(full_name, def_table)

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (imported from various carving mods, and optimised)
---------------------------------------------------------------------------------------------------

function unilib.register_carvings_column_centre(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_mid_XXX
    -- Creates a centred column node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_centre"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Centred column"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_column_flag or unilib.show_carvings_facade_flag,
        node_shape_table.column_centre
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/2)

    -- (From columnia. We disable these craft recipes if carvings from facade are enabled, but
    --      carvings from columnia are not)
    if unilib.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 2",
            recipe = {
                {"", full_name, ""},
                {"", c_blueprint, ""},
                {"", full_name, ""},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.register_carvings_column_top(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_top_XXX
    -- Creates a column top node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_top"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Column top"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_column_flag or unilib.show_carvings_facade_flag,
        node_shape_table.column_top
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/4)

    -- (From columnia)
    if unilib.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 4",
            recipe = {
                {full_name, full_name, full_name},
                {"", full_name, ""},
                {"", c_blueprint, ""},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.register_carvings_column_bottom(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_bottom_XXX
    -- Creates a column bottom node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_bottom"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Column bottom"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_column_flag or unilib.show_carvings_facade_flag,
        node_shape_table.column_bottom
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/4)

    -- (From columnia)
    if unilib.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 4",
            recipe = {
                {"", c_blueprint, ""},
                {"", full_name, ""},
                {full_name, full_name, full_name},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.register_carvings_column_crosslink(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_crosslink_XXX
    -- Creates a column crosslink node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_crosslink"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Column crosslink"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_column_flag or unilib.show_carvings_facade_flag,
        node_shape_table.column_crosslink
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/4)

    -- (From columnia)
    if unilib.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 4",
            recipe = {
                {"", full_name, ""},
                {full_name, c_blueprint, full_name},
                {"", full_name, ""},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.register_carvings_column_link(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_link_XXX
    -- Creates a centred column node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_link"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Column link"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_column_flag or unilib.show_carvings_facade_flag,
        node_shape_table.column_link
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/2)

    -- (From columnia)
    if unilib.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 2",
            recipe = {
                {full_name, c_blueprint, full_name},
                {"", "", ""},
                {"", "", ""},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.register_carvings_column_downlink(full_name, def_table)

    -- Adapted from columnia/init.lua, columnia:column_linkdown_XXX
    -- Creates a centred column node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_column_downlink"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Column downlink"))

    -- Register the node
    prepare_column(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_column_flag or unilib.show_carvings_facade_flag,
        node_shape_table.column_downlink
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 3/3)

    -- (From columnia)
    if unilib.add_carvings_column_flag then

        unilib.register_craft({
            output = adj_full_name .. " 3",
            recipe = {
                {full_name, c_blueprint, full_name},
                {"", full_name, ""},
                {"", "", ""},
            },
            replacements = {
                {c_blueprint, c_blueprint},
            },
        })

    end

    return adj_full_name

end

function unilib.register_carvings_facade_bannerstone(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_bannerstone
    -- Creates a bannerstone facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_bannerstone"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Bannerstone"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_bannerstone_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img, top_img, top_img, top_img, top_img, overlay_img},
        node_shape_table.facade_bannerstone,
        true
    )

    return adj_full_name

end

function unilib.register_carvings_facade_bannerstone_corner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_bannerstone_corner
    -- Creates a bannerstone corner facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_bannerstone_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Bannerstone corner"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_bannerstone_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img, top_img, overlay_img, overlay_img, overlay_img, overlay_img},
        node_shape_table.facade_bannerstone_corner,
        true
    )

    return adj_full_name

end

function unilib.register_carvings_facade_centrestone(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_centrestone
    -- Creates a centrestone facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_centrestone"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Centerstone"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_centrestone_overlay.png"

    -- (N.B. the original facade code omitted param2 for this node, but unilib includes it)

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {overlay_img},
        node_shape_table.facade_centrestone,
        true
    )

    return adj_full_name

end

function unilib.register_carvings_facade_column(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_column
    -- Creates a column facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_column"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Column facade"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_column_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img, top_img, top_img, top_img, overlay_img, overlay_img},
        node_shape_table.facade_column,
        true
    )

    return adj_full_name

end

function unilib.register_carvings_facade_column_corner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_column_corner
    -- Creates a column corner facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_column_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Column facade corner"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_column_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img, top_img, overlay_img, overlay_img, overlay_img, overlay_img},
        node_shape_table.facade_column_corner,
        true
    )

    return adj_full_name

end

function unilib.register_carvings_facade_corbel(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_corbel
    -- Creates a corbel facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_corbel"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Corbel"))

    local top_img = def_table.tiles[1]

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img},
        node_shape_table.facade_corbel,
        false
    )

    return adj_full_name

end

function unilib.register_carvings_facade_corbel_corner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_corbel_corner
    -- Creates a corbel corner facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_corbel_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Corbel corner"))

    local top_img = def_table.tiles[1]

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img},
        node_shape_table.facade_corbel_corner,
        false
    )

    return adj_full_name

end

function unilib.register_carvings_facade_corbel_corner_inner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_corbel_corner_inner
    -- Creates an inner corbel corner facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_corbel_corner_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inner corbel corner"))

    local top_img = def_table.tiles[1]

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img},
        node_shape_table.facade_corbel_corner_inner,
        false
    )

    return adj_full_name

end

function unilib.register_carvings_facade_swirl(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_carved_stone_a
    -- Creates a swirl facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_swirl"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Swirl"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_swirl_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img, top_img, top_img, top_img, top_img, overlay_img},
        node_shape_table.facade_swirl,
        true
    )

    return adj_full_name

end

function unilib.register_carvings_facade_swirl_corner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_carved_stone_a_corner
    -- Creates a swirl corner facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_swirl_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Swirl corner"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_swirl_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img, top_img, top_img, overlay_img, top_img, overlay_img},
        node_shape_table.facade_swirl_corner,
        true
    )

    return adj_full_name

end

function unilib.register_carvings_facade_fascia(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_rgspro
    -- Creates a fascia facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_fascia"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Fascia"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_fascia_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img, top_img, overlay_img, overlay_img, overlay_img, overlay_img},
        node_shape_table.facade_fascia,
        false
    )

    return adj_full_name

end

function unilib.register_carvings_facade_fascia_corner_inner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_rgspro_inner_corner
    -- Creates an inner corner fascia facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_fascia_corner_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inner corner fascia"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_fascia_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img, top_img, overlay_img, overlay_img, overlay_img, overlay_img},
        node_shape_table.facade_fascia_corner_inner,
        false
    )

    return adj_full_name

end

function unilib.register_carvings_facade_fascia_corner_outer(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_rgspro_outer_corner
    -- Creates an outer corner fascia facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_fascia_corner_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Outer corner fascia"))

    local top_img = def_table.tiles[1]
    local overlay_img = top_img .. "^unilib_facade_fascia_overlay.png"

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img, top_img, overlay_img, overlay_img, overlay_img, overlay_img},
        node_shape_table.facade_fascia_corner_outer,
        false
    )

    return adj_full_name

end

function unilib.register_carvings_facade_bricks_corner(full_name, def_table)

    -- Adapted from facade/shapes.lua, facade:XXX_corner_bricks
    -- Creates a corner bricks facade node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_facade_bricks_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Corner bricks"))

    local top_img = def_table.tiles[1]

    -- Register the node
    prepare_facade(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_facade_flag,
        {top_img},
        node_shape_table.facade_bricks_corner,
        false
    )

    return adj_full_name

end

function unilib.register_carvings_mill_crownmould(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:crownmould_XXX
    -- Creates a crown mould millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_crownmould"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Crown mould"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_crownmould.obj",
        node_shape_table.mill_crownmould
    )

    return adj_full_name

end

function unilib.register_carvings_mill_crownmould_corner_inner(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:crownmould_ic_XXX
    -- Creates an inner corner crown mould millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_crownmould_corner_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inner corner crown mould"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_crownmould_corner_inner.obj",
        node_shape_table.mill_crownmould_corner_inner
    )

    return adj_full_name

end

function unilib.register_carvings_mill_crownmould_corner_outer(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:crownmould_oc_XXX
    -- Creates an outer corner crown mould millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_crownmould_corner_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Outer corner crown mould"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_crownmould_corner_outer.obj",
        node_shape_table.mill_crownmould_corner_outer
    )

    return adj_full_name

end

function unilib.register_carvings_mill_crownmould_beam(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:crownmould_beam_XXX
    -- Creates a crown mould with beam millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_crownmould_beam"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Crown mould with beam"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_crownmould_beam.obj",
        node_shape_table.mill_crownmould_beam
    )

    return adj_full_name

end

function unilib.register_carvings_mill_column(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:crownmould_XXX
    -- Creates a milled column millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled column"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_column.obj",
        node_shape_table.mill_column
    )

    return adj_full_name

end

function unilib.register_carvings_mill_column_base(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_base_XXX
    -- Creates a milled column base millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_base"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled column base"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_column_base.obj",
        node_shape_table.mill_column_base
    )

    return adj_full_name

end

function unilib.register_carvings_mill_column_half(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_half_XXX
    -- Creates a milled half column millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled half column"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_column_half.obj",
        node_shape_table.mill_column_half
    )

    return adj_full_name

end

function unilib.register_carvings_mill_column_half_base(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_half_base_XXX
    -- Creates a milled half column base millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_half_base"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled half column base"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_column_half_base.obj",
        node_shape_table.mill_column_half_base
    )

    return adj_full_name

end

function unilib.register_carvings_mill_column_half_base_beam(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_half_wbeam_XXX
    -- Creates a milled half column base with beam millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_half_base_beam"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled half column base with beam"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_column_half_base_beam.obj",
        node_shape_table.mill_column_half_base_beam
    )

    return adj_full_name

end

function unilib.register_carvings_mill_column_quarter(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_quarter_XXX
    -- Creates a milled quarter column millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled quarter column"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_column_quarter.obj",
        node_shape_table.mill_column_quarter
    )

    return adj_full_name

end

function unilib.register_carvings_mill_column_quarter_base(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_quarter_base_XXX
    -- Creates a milled quarter column base millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_quarter_base"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Quarter column base"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_column_quarter_base.obj",
        node_shape_table.mill_column_quarter_base
    )

    return adj_full_name

end

function unilib.register_carvings_mill_column_quarter_base_board(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_quarter_wbase_XXX
    -- Creates a milled quarter column with baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_quarter_base_board"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled quarter column baseboard"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_column_quarter_base_board.obj",
        node_shape_table.mill_column_quarter_base_board
    )

    return adj_full_name

end

function unilib.register_carvings_mill_column_quarter_base_fancy(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:column_quarter_fancybase_XXX
    -- Creates a milled quarter column with fancy baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_column_quarter_base_fancy"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(
        def_table.description, S("Milled quarter column fancy baseboard")
    )

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_column_quarter_bace_fancy.obj",
        node_shape_table.mill_column_quarter_base_fancy
    )

    return adj_full_name

end

function unilib.register_carvings_mill_ceiling(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:ceiling_XXX
    -- Creates a milled ceiling millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_ceiling"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled ceiling"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_ceiling.obj",
        node_shape_table.mill_ceiling
    )

    return adj_full_name

end

function unilib.register_carvings_mill_ceiling_post(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:ceiling_post_XXX
    -- Creates a milled ceiling post millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_ceiling_post"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled ceiling post"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_ceiling_post.obj",
        node_shape_table.mill_ceiling_post
    )

    return adj_full_name

end

function unilib.register_carvings_mill_beam(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:beam_XXX
    -- Creates a milled beam millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_beam"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled beam"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_beam.obj",
        node_shape_table.mill_beam
    )

    return adj_full_name

end

function unilib.register_carvings_mill_beam_t(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:beam_t_XXX
    -- Creates a milled T-beam millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_beam_t"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled T-beam"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_beam_t.obj",
        node_shape_table.mill_beam_t
    )

    return adj_full_name

end

function unilib.register_carvings_mill_ceiling_beam_t(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:beam_ceiling_t_XXX
    -- Creates a milled ceiling with T-beam millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_ceiling_beam_t"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Milled ceiling with T-beam"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_ceiling_beam_t.obj",
        node_shape_table.mill_ceiling_beam_t
    )

    return adj_full_name

end

function unilib.register_carvings_mill_base(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_XXX
    -- Creates a baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Baseboard"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_base.obj",
        node_shape_table.mill_base
    )

    return adj_full_name

end

function unilib.register_carvings_mill_base_corner_inner(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_ic_XXX
    -- Creates an inner corner baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base_corner_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inner corner baseboard"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_base_corner_inner.obj",
        node_shape_table.mill_base_corner_inner,
        extra_shape_table.mill_base_corner_inner
    )

    return adj_full_name

end

function unilib.register_carvings_mill_base_corner_outer(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_oc_XXX
    -- Creates an outer corner baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base_corner_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Outer corner baseboard"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_base_corner_outer.obj",
        node_shape_table.mill_base_corner_outer,
        extra_shape_table.mill_base_corner_outer
    )

    return adj_full_name

end

function unilib.register_carvings_mill_base_fancy(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_fancy_XXX
    -- Creates a fancy baseboard millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base_fancy"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Fancy baseboard"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_base_fancy.obj",
        node_shape_table.mill_base_fancy
    )

    return adj_full_name

end

function unilib.register_carvings_mill_base_fancy_corner_inner(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_fancy_ic_XXX
    -- Creates an fancy baseboard inner corner millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base_fancy_corner_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Fancy baseboard inner corner"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_base_fancy_corner_inner.obj",
        node_shape_table.mill_base_fancy_corner_inner
    )

    return adj_full_name

end

function unilib.register_carvings_mill_base_fancy_corner_outer(full_name, def_table)

    -- Adapted from mymillwork/nodes.lua, mymillwork:base_fancy_oc_XXX
    -- Creates an fancy baseboard outer corner millwork node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Return values:
    --      The full_name of the new carving node

    local adj_part_name = "_mill_base_fancy_corner_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Fancy baseboard outer corner"))

    -- Register the node
    prepare_millwork(
        full_name, def_table, adj_full_name, adj_desc,
        unilib.show_carvings_millwork_flag,
        "unilib_mill_base_fancy_corner_outer.obj",
        node_shape_table.mill_base_fancy_corner_outer
    )

    return adj_full_name

end
