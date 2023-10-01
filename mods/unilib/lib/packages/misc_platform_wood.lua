---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_platform_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ropes.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_register(data_table)

    -- Adapted from ropes/bridge.lua
    -- Create a wooden platform for the specified tree type
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "apple"
    --      ingredient (str): e.g. "unilib:tree_apple_wood_stair_slab"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Wooden Platform (Apple Tree Wood)"

    local part_name = data_table.part_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wooden Platform")

    local full_name = "unilib:misc_platform_wood_" .. part_name
    local orig_name = ""
    if part_name == "apple" then
        orig_name = "ropes:wood_bridge"
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        -- From ropes:wood_bridge
        description = unilib.hint(
            description, S("right-click the end of a row to place another block")
        ),
        tiles = {
            "unilib_tree_" .. part_name .. "_wood.png",
            "unilib_tree_" .. part_name .. "_wood.png",
            "unilib_tree_" .. part_name .. "_wood.png^[transformR270",
            "unilib_tree_" .. part_name .. "_wood.png^[transformR90",
            "unilib_tree_" .. part_name .. "_wood.png^[transformR270",
            "unilib_tree_" .. part_name .. "_wood.png^[transformR90",
        },
        groups = {
            choppy = 2, fence = 1, flammable = 2, flow_through = 1, oddly_breakable_by_hand = 1,
            wall = 1
        },
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, 0.375, -0.5, 0.5, 0.5, 0.5},
                {-0.375, -0.5, -0.5, 0.375, -0.375, -0.4375},
                {-0.375, -0.5, 0.4375, 0.375, -0.375, 0.5},
                {0.375, -0.5, -0.4375, 0.5, -0.375, 0.4375},
                {-0.5, -0.5, -0.4375, -0.375, -0.375, 0.4375},
                {0.375, -0.5, -0.5, 0.5, 0.375, -0.4375},
                {0.375, -0.5, 0.4375, 0.5, 0.375, 0.5},
                {-0.5, -0.5, -0.5, -0.375, 0.375, -0.4375},
                {-0.5, -0.5, 0.4375, -0.375, 0.375, 0.5},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",

        on_place = function(itemstack, placer, pointed_thing)

            -- Place the item and return the leftover itemstack. The placer may be any ObjectRef or
            --      nil (default: minetest.item_place)
            if placer == nil then
                return minetest.item_place(itemstack, placer, pointed_thing)
            end

            local above = pointed_thing.above
            local under = pointed_thing.under

            if above.x == under.x and above.z == under.z and above.y > under.y then

                -- We're aimed downwards at a buildable node from above
                -- Determine the direction the placer lies relative to this node
                local new_under = vector.new(under)
                local placer_pos = placer:get_pos()
                local diff_x = placer_pos.x - under.x
                local diff_z = placer_pos.z - under.z

                if math.abs(diff_x) > math.abs(diff_z) then

                    -- Placer is displaced along the X axis relative to the target
                    if diff_x > 0 then
                        new_under.x = under.x - 1
                    else
                        new_under.x = under.x + 1
                    end

                else

                    -- Placer is displaced along the Z axis relative to the target
                    if diff_z > 0 then
                        new_under.z = under.z - 1
                    else
                        new_under.z = under.z + 1
                    end

                end

                if minetest.registered_nodes[minetest.get_node(new_under).name].buildable_to then

                    local new_pointed_thing = {
                        type = "node",
                        under = new_under,
                        above = {x = new_under.x, y = new_under.y + 1, z = new_under.z},
                    }

                    return minetest.item_place(itemstack, placer, new_pointed_thing)

                end

            end

            return minetest.item_place(itemstack, placer, pointed_thing)

        end,
    })
    unilib.register_craft({
        -- From ropes:wood_bridge
        output = full_name .. " 6",
        recipe = {
            {"group:stick", ingredient, "group:stick"},
            {"group:stick", "", "group:stick"},
            {"group:stick", "group:stick", "group:stick"},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_platform_wood.init()

    return {
        description = "Wooden platform set",
        notes = "This package creates wooden platforms from the full range of super trees. To" ..
                " place platform segments at the end of a row, stand one block away from the" ..
                " edge block, then right-click it. No platforms are generated if basic stairs" ..
                " are disabled",
    }

end

function unilib.pkg.misc_platform_wood.post()

    if not unilib.add_stairs_basic_flag then
        return
    end

    for tree_type, _ in pairs(unilib.super_tree_table) do

        local data_table = unilib.tree_table[tree_type]
        local ingredient = "unilib:tree_" .. tree_type .. "_wood_stair_slab"

        if unilib.pkg_executed_table["tree_" .. tree_type] ~= nil and
                minetest.registered_nodes[ingredient] ~= nil then

            do_register({
                part_name = tree_type,
                ingredient = ingredient,

                replace_mode = mode,
                description = unilib.brackets(S("Wooden Platform"), data_table.description),
            })

        end

    end

end
