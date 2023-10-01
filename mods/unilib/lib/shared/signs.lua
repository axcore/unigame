---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- signs.lua
--      Set up shared functions for signs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register signs
---------------------------------------------------------------------------------------------------

function unilib.register_wall_sign(data_table)

    -- Adapted from default/nodes.lua
    -- Creates a wall sign node
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "wood"
    --      orig_name (str): e.g. "default:sign_wall_wood"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Wooden Wall Sign"
    --      group_table (table): e.g. {attached_node = 1, coddly_breakable_by_hand = 3},
    --      sound_name (str): e.g. "wood", a key in unilib.sound_table
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wall Sign")
    local group_table = data_table.group_table or {attached_node = 1}
    local sound_name = data_table.sounds or "node"

    local full_name = "unilib:sign_wall_" .. part_name
    local img = "unilib_sign_wall_" .. part_name .. "_inv.png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_sign_wall_" .. part_name .. ".png"},
        groups = group_table,
        sounds = unilib.sound_table[sound_name],

        drawtype = "nodebox",
        inventory_image = img,
        is_ground_content = false,
        node_box = {
            type = "wallmounted",
            wall_top = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
            wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
            wall_side = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
        },
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        use_texture_alpha = "opaque",
        walkable = false,
        wield_image = img,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", "field[text;;${text}]")

        end,

        on_receive_fields = function(pos, formname, fields, sender)

            local player_name = sender:get_player_name()
            if minetest.is_protected(pos, player_name) then

                minetest.record_protection_violation(pos, player_name)
                return

            end

            local text = fields.text
            if not text then
                return
            end

            if string.len(text) > 512 then

                minetest.chat_send_player(player_name, S("Text too long"))
                return

            end

            unilib.log(
                "action",
                player_name .. " wrote \"" .. text .. "\" to the sign at " ..
                        minetest.pos_to_string(pos)
            )

            local meta = minetest.get_meta(pos)
            meta:set_string("text", text)

            if #text > 0 then
                meta:set_string("infotext", S('"@1"', text))
            else
                meta:set_string("infotext", '')
            end

        end,
    })

    return full_name

end
