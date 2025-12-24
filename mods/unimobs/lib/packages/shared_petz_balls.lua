---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_petz_balls = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_balls.do_register(data_table)

    -- Adapted from petz/api/api_squareball.lua
    -- Registers a square ball for playing fetch with dogs (and other compatbile mobs). See the
    --      "item_ball_square" package for information about how to play the game
    -- The square ball exists as a node or as an entity, depending on what stage of the game is
    --      being played
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "beach"
    --      orig_name (str): e.g. "petz:square_ball"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Beach Ball"
    --      strength (int): e.g. 20, corresponding to how fast the ball can be thrown. 20 is used,
    --          if no value is specified

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Square Ball")
    local strength = data_table.strength or 20

    local full_name = "unilib:item_ball_square_" .. part_name
    local entity_name = "unilib:entity_item_ball_square_" .. part_name
    local img = "unilib_item_ball_square_" .. part_name .. ".png"

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.utils.hint(description, S("press \"use\" key to throw")),
        tiles = {"unilib_item_ball_square_" .. part_name .. ".png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
        sounds = unilib.global.sound_table.wood,

        is_ground_content = false,
        -- N.B. Original value 0.35; changed to prevent the dropped ball being partially submerged,
        --      and also to prevent it being so big, when wielded
        visual_scale = 1,

        on_use = function(itemstack, user, pointed_thing)

            -- "Throw" the ball
            if not unimobs.petz_api.throw_clutchable_item(user, entity_name, strength) then

                -- Something went wrong; don't change the player's inventory
                return

            else

                -- Remove the ball from the player's inventory
                itemstack:take_item()
                return itemstack

            end

        end,
    })

    unilib.register_entity(entity_name, {
        initial_properties = {
            collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
            hp_max = 4,
            -- (Use raycast)
            physical = false,
            -- N.B. List of textures moved here from unimobs.petz_api.attach_clutchable_item() so
            --      that they match "part_name" for this item
            textures = {img, img, img, img, img, img},
            visual = "wielditem",
            -- N.B. y = 0.15 in original code
            visual_size = {x = 0.2, y = 0.2},
            -- N.B. replaced deprecated ".textures = itemname" construction with .wield_item
            wield_item = full_name,
        },

        old_pos = nil,
        parent_entity = nil,
        thrower_name = "",
        waiting_for_removal_flag = false,

        on_activate = function(self)
            self.object:set_acceleration({x = 0, y = unimobs.constant.gravity, z = 0})
        end,

        on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)

            -- N.B. Original code returned false, so when the player left-clicked a ball in the
            --      dog's mouth, the ball vanished (as opposed to right-clicking it to put the ball
            --      in the player's inventory)
            return true

        end,

        on_rightclick = function(self, clicker)
            return unimobs.petz_api.detach_clutchable_item(self, clicker, full_name)
        end,

        on_step = function(self, dtime)
            return unimobs.petz_api.update_clutchable_item(self, full_name)
        end,
    })

    unimobs.petz_api.register_clutchable_item(full_name, entity_name)

end


---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_balls.init()

    return {
        description = "Shared functions for square balls (from petz)",
    }

end
