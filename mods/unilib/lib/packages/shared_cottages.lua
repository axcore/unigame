---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_cottages = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Hatches rotate around their axis
hatch_table = {10, 19, 4, 13, 2, 18, 22, 14, 20, 16, 0, 12, 11, 3, 7, 21, 9, 23, 5, 1, 8, 15, 6, 17}

---------------------------------------------------------------------------------------------------
-- Local functions (sitting/sleeping)
---------------------------------------------------------------------------------------------------

local function allow_sit(player)

    -- No check possible
    if not(player.get_player_velocity) then
        return true
    end

    local velo = player:get_player_velocity()
    if not(velo) then
        return false
    end

    local max_velo = 0.0001
    if math.abs(velo.x) < max_velo and
            math.abs(velo.y) < max_velo and
            math.abs(velo.z) < max_velo then
        return true
    else
        return false
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (register hatches)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cottages.register_hatch(data_table)

    -- Adapted from cottages/nodes_doorlike.lua
    -- Create a hatch (like a trapdoor, but slimmer and with no node variants)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "wood"
    --      orig_name (str): e.g. "cottages:hatch_wood"
    --      img (str): e.g. "unilib_misc_wood_rustic.png"
    --      ingredient (str): "group:plank"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Wooden Hatch"
    --
    -- Return values:
    --      The full_name of the new craftitem

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local img = data_table.img
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Hatch")

    local full_name = "unilib:trapdoor_hatch_" .. part_name

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {img},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.49, -0.55, -0.49, -0.3, -0.45, 0.45},
                {0.3, -0.55, -0.3, 0.49, -0.45, 0.45},
                {0.49, -0.55, -0.49, -0.3, -0.45, -0.3},
                {-0.075, -0.55, -0.3, 0.075, -0.45, 0.3},
                {-0.3, -0.55, -0.075, -0.075, -0.45, 0.075},
                {0.075, -0.55, -0.075, 0.3, -0.45, 0.075},
                {-0.3, -0.55, 0.3, 0.3, -0.45, 0.45},
                -- Hinges
                  {-0.45, -0.530, 0.45, -0.15, -0.470, 0.525},
                  { 0.15, -0.530, 0.45, 0.45, -0.470, 0.525},
                -- Handle
                  {-0.05, -0.60, -0.35, 0.05, -0.40, -0.45},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.55, -0.5, 0.5, -0.45, 0.5},
        },

        on_place = core.rotate_node,

        on_rightclick = function(pos, node, puncher)
            core.swap_node(pos, {name = node.name, param2 = hatch_table[node.param2 + 1]})
        end,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {"", "", ingredient},
            {ingredient, "group:stick", ""},
            {"", "", ""},
        },
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- Shared functions (register rooves)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cottages.register_roof(data_table)

    -- Adapted from cottages/nodes_roof.lua
    -- Create three basic roof parts for each rustic roof type (with some exceptions to avoid
    --      duplicating stair nodes)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "thatch"
    --      orig_part_name (str): e.g. "reet"
    --      description (str): e.g. "Thatch"
    --      ingredient (str): e.g. "unilib:plant_papyrus_ordinary"
    --      tile_table (table): Table used in the .tiles field of the node definition
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      shingles_flag (bool): True for shingles crafted using "ingredient", and a wood rustic
    --          roof node

    local part_name = data_table.part_name
    local orig_part_name = data_table.orig_part_name
    local description = data_table.description
    local ingredient = data_table.ingredient
    local tile_table = data_table.tile_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local shingles_flag = data_table.shingles_flag or false

    -- (Code below requires at least two tiles)
    if tile_table[2] == nil then
        tile_table[2] = tile_table[1]
    end

    -- Create two steps, in opposite corners of the node area
    unilib.register_node(
        "unilib:roof_rustic_" .. part_name,
        "cottages:roof_" .. orig_part_name,
        replace_mode,
        {
            description = unilib.utils.brackets(S("Rustic Roofing"), description),
            tiles = tile_table,
            groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
            -- N.B. no sounds in original code
            sounds = unilib.global.sound_table.wood,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0, 0},
                    {-0.5, 0, 0, 0.5, 0.5, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0, 0},
                    {-0.5, 0, 0, 0.5, 0.5, 0.5},
                },
            },
        }
    )
    if not shingles_flag then

        unilib.register_craft({
            output = "unilib:roof_rustic_" .. part_name .. " 6",
            recipe = {
                {"", "", ingredient},
                {"", ingredient, ""},
                {ingredient, "", ""},
            },
        })

    else

        unilib.register_craft({
            output = "unilib:roof_rustic_" .. part_name .. " 3",
            recipe = {
                {ingredient, "", "unilib:roof_rustic_wood"},
                {"", "unilib:roof_rustic_wood", ""},
                {"unilib:roof_rustic_wood", "", ""},
            },
        })

    end

    -- Create a node identical to a simple stair node (from ../lib/shared/stairs/stairs_basic.lua)
    -- N.B. When part_name is "straw", duplicates of the straw stair nodes are created. However,
    --      the stair nodes are not usually visible in the creative inventory, whereas these roof
    --      nodes are. This is a change from the original code
    unilib.register_node(
        "unilib:roof_rustic_connector_" .. part_name,
        "cottages:roof_connector_" .. orig_part_name,
        replace_mode,
        {
            description = unilib.utils.brackets(S("Rustic Roofing Connector"), description),
            tiles = tile_table,
            groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
            -- N.B. no sounds in original code
            sounds = unilib.global.sound_table.wood,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
                    {-0.5, 0, 0, 0.5, 0.5, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
                    {-0.5, 0, 0, 0.5, 0.5, 0.5},
                },
            },
        }
    )
    unilib.register_craft({
        output = "unilib:roof_rustic_connector_" .. part_name,
        recipe = {
            {"unilib:roof_rustic_" .. part_name},
            {"group:wood"},
        },
    })

    -- Create a node identical to a slab stair node (from ../lib/shared/stairs/stairs_basic.lua)
    unilib.register_node(
        "unilib:roof_rustic_flat_" .. part_name,
        "cottages:roof_flat_" .. orig_part_name,
        replace_mode,
        {
            description = unilib.utils.brackets(S("Flat Rustic Roofing"), description),
            tiles = {
                tile_table[1],
                tile_table[2],
                tile_table[1],
                tile_table[1],
                tile_table[1],
                tile_table[1],
            },
            groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
            -- N.B. no sounds in original code
            sounds = unilib.global.sound_table.wood,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
                },
            },
        }
    )
    unilib.register_craft({
        output = "unilib:roof_rustic_flat_" .. part_name .. " 2",
        recipe = {
            {"unilib:roof_rustic_" .. part_name, "unilib:roof_rustic_" .. part_name},
        },
    })
    unilib.register_craft({
        output = "unilib:roof_rustic_" .. part_name,
        recipe = {
            {"unilib:roof_rustic_flat_" .. part_name, "unilib:roof_rustic_flat_" .. part_name},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- Shared functions (sitting/sleeping)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cottages.sit_on_bench(pos, node, clicker, itemstack, pointed_thing)

    if not clicker or not allow_sit(clicker) then
        return
    end

    local animation = unilib.player_api.get_animation(clicker)
    local pname = clicker:get_player_name()

    if animation and animation.animation == "sit" then

        unilib.player_api.set_player_attached(pname, false)
        clicker:set_pos({x = pos.x, y = pos.y - 0.5, z = pos.z})
        clicker:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
        -- N.B. Fixed deprecated format of set_physics_override(), not yet corrected in original mod
        clicker:set_physics_override({gravity = 1, jump = 1, speed = 1})
        unilib.player_api.set_animation(clicker, "stand", 30)

    else

        -- Notes from cottages:
        -- The bench is not centred, so prevent the player from sitting on air
        local p2 = {x = pos.x, y = pos.y, z = pos.z}
        --[[
        if not(node) or node.param2 == 0 then
            p2.z = p2.z + 0.3
        elseif node.param2 == 1 then
            p2.x = p2.x + 0.3
        elseif node.param2 == 2 then
            p2.z = p2.z - 0.3
        elseif node.param2 == 3 then
            p2.x = p2.x - 0.3
        end
        ]]--
        -- (Incorporate Git #15 fix for getting stuck on benches)
        if not node or node.param2 == 0 then
            p2.z = p2.z + 0.2
        elseif node.param2 == 1 then
            p2.x = p2.x + 0.3
        elseif node.param2 == 2 then
            p2.z = p2.z - 0.3
        elseif node.param2 == 3 then
            p2.x = p2.x - 0.3
        end

        -- N.B. Tweaked the original cottages camera position, so the player isn't looking inside
        --      the bench
--        clicker:set_eye_offset({x = 0, y = -7, z = 2}, {x = 0, y = 0, z = 0})
        clicker:set_eye_offset({x = 0, y = -3, z = 2}, {x = 0, y = 0, z = 0})
        clicker:set_pos(p2)
        unilib.player_api.set_animation(clicker, "sit", 30)
        -- N.B. Fixed deprecated format of set_physics_override(), not yet corrected in original mod
        clicker:set_physics_override({gravity = 0, jump = 0, speed = 0})
        unilib.player_api.set_player_attached(pname, true)

    end
end

function unilib.pkg.shared_cottages.sleep_in_bed(pos, node, clicker, itemstack, pointed_thing)

    -- N.B. Used for "sleeping" on both decorative beds and mats

    if not clicker or not node or not node.name or not pos or not allow_sit(clicker) then
        return
    end

    local animation = unilib.player_api.get_animation(clicker)
    local pname = clicker:get_player_name()

    local p_above = core.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
    if not p_above or not p_above.name or p_above.name ~= "air" then

        core.chat_send_player(pname, S("This place is too narrow for sleeping"))
        return

    end

    local place_name = "place"
    -- Notes from cottages:
    -- If only one node is present, the player can only sit. Sleeping requires a bed head+foot, or
    --      two sleeping mats
    local allow_sleep = false
    local new_animation = "sit"

    -- Let players get back up
    if animation and animation.animation == "lay" then

        unilib.player_api.set_player_attached(pname, false)
        -- N.B. Tweaked the original cottages position, so player isn't standing in the middle of
        --      a bed
--      clicker:set_pos({x = pos.x, y = pos.y - 0.5, z = pos.z})
        clicker:set_pos({x = pos.x, y = pos.y + 0.5, z = pos.z})
        clicker:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
        -- N.B. Fixed deprecated format of set_physics_override(), not yet corrected in original mod
        clicker:set_physics_override({gravity = 1, jump = 1, speed = 1})
        unilib.player_api.set_animation(clicker, "stand", 30)
        core.chat_send_player(pname, S("That's enough sleep for now. You stand up again."))
        return

    end

    local second_node_pos = {x = pos.x, y = pos.y, z = pos.z}
    -- The node that will contain the head of the player
    local p = {x = pos.x, y = pos.y, z = pos.z}
    -- The player's head is pointing in this direction
    local dir = node.param2

    -- It would be odd to sleep in half a bed
    if node.name == "unilib:bed_decorative_head" then

        if node.param2 == 0 then
            second_node_pos.z = pos.z - 1
        elseif node.param2 == 1 then
            second_node_pos.x = pos.x - 1
        elseif node.param2 == 2 then
            second_node_pos.z = pos.z + 1
        elseif node.param2 == 3 then
            second_node_pos.x = pos.x + 1
        end

        local node2 = core.get_node(second_node_pos)
        if not node2 or
                not node2.param2 or
                not node.param2 or
                node2.name ~= "unilib:bed_decorative_foot" or
                node2.param2 ~= node.param2 then
            allow_sleep = false
        else
            allow_sleep = true
        end

        place_name = "bed"

    -- If the player clicked on the foot of the bed, locate the head
    elseif node.name == "unilib:bed_decorative_foot" then

        if node.param2 == 2 then
            second_node_pos.z = pos.z - 1
        elseif node.param2 == 3 then
            second_node_pos.x = pos.x - 1
        elseif node.param2 == 0 then
            second_node_pos.z = pos.z + 1
        elseif node.param2 == 1 then
            second_node_pos.x = pos.x + 1
        end

        local node2 = core.get_node(second_node_pos)
        if not node2 or
                not node2.param2 or
                not node.param2 or
                node2.name ~= "unilib:bed_decorative_head" or
                node2.param2 ~= node.param2 then
            allow_sleep = false
        else
            allow_sleep = true
        end

        if allow_sleep == true then
            p = {x = second_node_pos.x, y = second_node_pos.y, z = second_node_pos.z}
        end

        place_name = 'bed'

    elseif node.name == "unilib:bed_mat_sleeping" or
            node.name == "unilib:bed_mat_straw" or
            node.name == "unilib:bed_mat_sleeping_head" then

        place_name = "mat"
        dir = node.param2
        allow_sleep = false
        -- Search for a second mat right next to this one
        local offset = {{x = 0, z = -1}, {x = -1, z = 0}, {x = 0, z = 1}, {x = 1, z = 0}}
        for i, off in ipairs(offset) do

            node2 = core.get_node({x = pos.x + off.x, y = pos.y, z = pos.z + off.z})
            if node2.name == "unilib:bed_mat_sleeping" or
                    node2.name == "unilib:bed_mat_straw" or
                    node.name == "unilib:bed_mat_sleeping_head" then

                -- If a second mat is found, sleeping is possible
                allow_sleep = true
                dir = i - 1

            end

        end

    end

    -- Set the right height for the bed
    -- N.B. Tweaked the original code so that, when the player clicks either end of the bed, they
    --      move to the sitting position
--  if place_name == "bed" then
    if place_name ~= "mat" then
        p.y = p.y + 0.4
    end

    if allow_sleep == true then

        -- Set the right position (middle of the bed)
        if dir == 0 then
            p.z = p.z - 0.5
        elseif dir == 1 then
            p.x = p.x - 0.5
        elseif dir == 2 then
            p.z = p.z + 0.5
        elseif dir == 3 then
            p.x = p.x + 0.5
        end

    end

    if unilib.player_api.get_player_attached(pname) and animation.animation == "sit" then

        -- Just changing the animation...
        if allow_sleep == true then

            unilib.player_api.set_animation(clicker, "lay", 30)
            -- N.B. Tweaked the original cottages camera position, so the player isn't looking
            --      inside the bed/mat
--          clicker:set_eye_offset({x = 0, y = -14, z = 2}, {x = 0, y = 0, z = 0})
            clicker:set_eye_offset({x = 0, y = 0, z = 2}, {x = 0, y = 0, z = 0})
            core.chat_send_player(pname, S("You lie down and take a nap. Right-click to wake up."))

            return

        -- No sleeping on this place
        else

            unilib.player_api.set_player_attached(pname, false)
            -- N.B. Tweaked the original cottages camera position, so player isn't standing in the
            --      middle of a bed
--          clicker:set_pos({x = pos.x, y = pos.y - 0.5, z = pos.z})
            clicker:set_pos({x = pos.x, y = pos.y + 0.5, z = pos.z})
            clicker:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
            -- N.B. Fixed deprecated format of set_physics_override(), not yet corrected in original
            --      mod
            clicker:set_physics_override({gravity = 1, jump = 1, speed = 1})
            unilib.player_api.set_animation(clicker, "stand", 30)
            core.chat_send_player(pname, S("You stand up again"))
            return

        end

    end

    -- N.B. Tweaked the original cottages camera position, so the player isn't looking inside the
    --      bed/mat
--  clicker:set_eye_offset({x = 0, y = -7, z = 2}, {x = 0, y = 0, z = 0})
    if place_name == "bed" then
        clicker:set_eye_offset({x = 0, y = -3, z = 2}, {x = 0, y = 0, z = 0})
    else
        clicker:set_eye_offset({x = 0, y = 2, z = 2}, {x = 0, y = 0, z = 0})
    end

    clicker:set_pos(p)
    unilib.player_api.set_animation(clicker, new_animation, 30)
    -- N.B. Fixed deprecated format of set_physics_override(), not yet corrected in original mod
    clicker:set_physics_override({gravity = 0, jump = 0, speed = 0})
    unilib.player_api.set_player_attached(pname, true)

    if allow_sleep == true then

        core.chat_send_player(
            pname,
            S("Aaah! What a comfortable place. Right click again to sleep.")
        )

    else

        core.chat_send_player(
            pname,
            S("Comfortable, but not good enough for a nap. Right click again to get back up.")
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (hand mill, threshing machine and well)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cottages.player_can_use(meta, player)

    -- If no owner is set, all players may use the item, otherwise only the owner
    if not player or not meta then
        return false
    end

    local pname = player:get_player_name()
    local owner = meta:get_string("owner")
    local public = meta:get_string("public")
    if not owner or owner == "" or owner == pname or public == "public" then
        return true
    else
        return false
    end

end

function unilib.pkg.shared_cottages.switch_public(pos, formname, fields, sender, description)

    local meta = core.get_meta(pos)
    local public = meta:get_string("public")
    local owner = meta:get_string("owner")

    if sender and sender:get_player_name() == owner and fields.public then

        if public ~= "public" then

            meta:set_string("public", "public")
            meta:set_string(
                "infotext",
                unilib.utils.brackets(description, S("public, owned by %s"):format(owner))
            )
            core.chat_send_player(owner, S("Your machine can now be used by other players as well"))

        else

            meta:set_string("public", "")
            meta:set_string(
                "infotext",
                unilib.utils.brackets(description, S("private, owned by %s"):format(owner))
            )
            core.chat_send_player(owner, S("Your machine can now be used only by you"))

        end

        return true

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cottages.init()

    return {
        description = "Shared functions for beds, benches and hatches (from cottages)",
    }

end
