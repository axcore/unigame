---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_wagon_pony = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

local scale_factor = 3.3
local visual_size = {
    x = unimobs.petz_const.visual_size.x * scale_factor,
    y = unimobs.petz_const.visual_size.y * scale_factor,
}

-- Table of wagon entity IDs whose animation is currently "roll"; in order to make the animation
--      much smoother than in the original code, we only call :set_animation() when the animation
--      changes
wagon_roll_table = {}

-- N.B. Several parts of this package are commented out, because the code does not work (for
--      unknown reasons). Specifically, when the game restarts, a wagon attached to a pony is
--      automatically detached (as expected), but the wagon entity cannot be punched
-- The workaround creates two entities, an "attached" wagon and a "standing" wagon. The "standing"
--      wagon can be placed in the world directly by the player, without involving a pony. The
--      "attached" wagon is created when the wagon is attached to a pony. Shortly after the game
--      restarts, the entity is converted to a "standing" wagon
-- Unfortunately, this means that a wagon can't be attached to a pony during the first few seconds
--      after a restart, but that should be acceptable
-- If a solution to the original problem can be found, the commented-out sections can be restored
--      (and the variables below can be removed)
local game_started_flag = false
local game_check_time = 3

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_punch_callback(
    self, puncher, time_from_last_punch, tool_capabilities, dir, damage
)
    if (self.object:get_hp() - damage) <= 0 then

        -- N.B. Modified original code so that the wagon can be moved to the player's inventory,
        --      instead of being dropped in the world
        local inv = puncher:get_inventory()
        local stack = ItemStack("unilib:misc_wagon_pony")
        if not inv:room_for_item("main", stack) then
            unimobs.kitz_api.make_mob_drop_single_item(self, ItemStack("unilib:misc_wagon_pony"))
        else
            inv:add_item("main", stack)
        end

    end

end

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.put_wagon()
    -- Attach a wagon to the right-clicked pony

    if self.mob_type ~= "pony_normal" or
            self.owner ~= clicker:get_player_name() or
            self.is_baby_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    if self.wagon then

        core.chat_send_player(clicker:get_player_name(), S("This pony is already pulling a wagon"))
        -- Do not apply the standard behaviour
        return true

    end

    local pos = self.object:get_pos()
    local wagon_obj = core.add_entity(pos, "unilib:entity_misc_wagon_pony_attached", nil)
    if not wagon_obj then

        -- N.B. In original code, no chat message; here, we display a cryptic one
        core.chat_send_player(
            clicker:get_player_name(), S("This pony does not want to pull a wagon")
        )

        -- Do not apply the standard behaviour
        return true

    end

    -- Attach the wagon
    local rotation = self.object:get_rotation()
    wagon_obj:set_attach(self.object, "", {x = 0, y = 0, z = 0}, rotation)
    unimobs.kitz_api.make_sound(
        "object", self.object, "unilib_pop_petz", unimobs.petz_setting.max_hear_distance
    )

    wagon_obj:set_properties({visual_size = {x = 1, y = 1}})
    self.wagon = wagon_obj

    local wielded_item = clicker:get_wielded_item()
    wielded_item:take_item()
    clicker:set_wielded_item(wielded_item)

    -- Do not apply the standard behaviour
    return true

end

local function wagon_animation_callback(self, anim_type)

    -- Was petz.animate_wagon()
    -- Animate the wagon

    -- N.B. In order to make the animation much smoother than in the original code, we only call
    --      :set_animation() when the animation changes
    if anim_type == "stand" and wagon_roll_table[self._id] ~= nil then

        wagon_roll_table[self._id] = nil
        self.wagon:set_animation({x = 1, y = 1}, 25, 0, true)

    elseif anim_type == "roll" and wagon_roll_table[self._id] == nil then

        wagon_roll_table[self._id] = true
        self.wagon:set_animation({x = 1, y = 11}, 20, 0, true)

    else

        return

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_wagon_pony.init()

    return {
        description = "Pony wagon",
        notes = "Right-click a normal pony with the wagon to attach it. To disconnect the wagon," ..
                " use shears (or kill the pony). Right-click the pony to mount/dismount from an" ..
                " attached wagon. Left-click while wielding the wagon to place it in the world," ..
                " unattached to a pony",
        depends = "metal_iron",
    }

end

function unilib.pkg.misc_wagon_pony.exec()

    -- N.B. The original code provides a single wagon entity. If attached to a pony, the wagon can't
    --      be punched after a game restart
    -- Here, we provide two entities - a "standing" wagon (which the user can place in the world
    --      directly as a decorative item), and an "attached" wagon (which is attached to a pony);
    --      on a game restart, the "attached" wagon is automatically detached from its pony, and
    --      converted into a "standing" wagon

    unilib.register_entity("unilib:entity_misc_wagon_pony_standing", {
        -- From petz:wagon
        initial_properties = {
            collide_with_objects = true,
            collisionbox = {-0.5, -1.5, -1.75, 0.5, -0.25, -3.0},
            mesh = "unilib_misc_wagon_pony.b3d",
            physical = true,
            selectionbox = {-0.5, -1.5, -1.75, 0.5, -0.25, -3.0, rotate = true},
            textures = {"unilib_misc_wagon_pony.png"},
            visual = "mesh",
            visual_size = visual_size,
        },

        -- N.B. Removed the .hitbox and .hp properties, as they seem to have no effect
--      hitbox = {-0.5, -1.5, -1.5, 0.5, -0.25, -3.0},
--      hp = 10,

        on_punch = on_punch_callback,
    })

    unilib.register_entity("unilib:entity_misc_wagon_pony_attached", {
        -- From petz:wagon
        initial_properties = {
            collide_with_objects = true,
            collisionbox = {-0.5, -1.5, -1.75, 0.5, -0.25, -3.0},
            mesh = "unilib_misc_wagon_pony.b3d",
            physical = true,
            selectionbox = {-0.5, -1.5, -1.75, 0.5, -0.25, -3.0, rotate = true},
            textures = {"unilib_misc_wagon_pony.png"},
            visual = "mesh",
            visual_size = visual_size,
        },

        on_activate = function(self, staticdata, dtime_s)

            if not game_started_flag then

                local replace_obj = core.add_entity(
                    self.object:get_pos(), "unilib:entity_misc_wagon_pony_standing", nil
                )
                if replace_obj then
                    self.object:remove()
                end

            end

        end,

        on_punch = on_punch_callback,
    })

    core.after(game_check_time, function()
        game_started_flag = true
    end)

    unilib.register_craftitem("unilib:misc_wagon_pony", "petz:wagon", mode, {
        -- From petz:wagon
        description = S("One-Pony Open Wagon"),
        inventory_image = "unilib_misc_wagon_pony_inv.png",
        groups = {wagon = 1},

        stack_max = 1,

        on_use = function (itemstack, user, pointed_thing)

            if pointed_thing.type ~= "node" then
                return
            end

            local pt_above = pointed_thing.above
            local pos2 = {x = pt_above.x, y = pt_above.y + 1, z = pt_above.z}

            core.add_entity(pos2, "unilib:entity_misc_wagon_pony_standing", nil)
            itemstack:take_item()
            return itemstack

        end,
    })
    unilib.register_craft({
        -- From petz:wagon
        type = "shaped",
        output = "unilib:misc_wagon_pony",
        recipe = {
            {"", "group:stair", ""},
            {"group:wood", "group:wood", "group:wood"},
            {"unilib:misc_wagon_pony_wheel", "", "unilib:misc_wagon_pony_wheel"},
        },
    })

    unilib.register_craftitem("unilib:misc_wagon_pony_wheel", "petz:wagon_wheel", mode, {
        -- From petz:wagon_wheel
        description = S("Wagon Wheel"),
        inventory_image = "unilib_misc_wagon_pony_wheel.png",
        groups = {wagon = 1, wheel = 1},
    })
    unilib.register_craft({
        -- From petz:wagon_wheel
        type = "shaped",
        output = "unilib:misc_wagon_pony_wheel",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"group:wood", "unilib:metal_iron_lump", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:misc_wagon_pony", on_rightclick_mob_callback
    )

    -- Register the wagon entity's craftitem and animation function, so that code in the Petz API
    --      can retrieve them
    unimobs.petz_api.register_wagon(
        "unilib:entity_misc_wagon_pony_attached", "unilib:misc_wagon_pony", wagon_animation_callback
    )

end
