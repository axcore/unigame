---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_stand_bird = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_stand_bird.init()

    return {
        description = "Bird stand",
        notes = "Use by right-clicking the stand with a captured creature (any mob whose" ..
                " \"can_perch_flag\" is true)",
        depends = {"item_stick_ordinary", "mtb_order_stand_here"},
    }

end

function unilib.pkg.misc_stand_bird.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:misc_stand_bird", "petz:bird_stand", mode, {
        -- From petz:bird_stand
        description = S("Bird Stand"),
        tiles = {"unilib_tree_apple_wood.png"},
        groups = {bendy = 2, cracky = 1, snappy = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.0625, -0.5, -0.0625, 0, 0.4375, 0},
                -- N.B. Replaced improbable number in original code
--              {-0.375, 0.4375, -0.0625, 0.3125, 0.5, -2.23517e-08},
                {-0.375, 0.4375, -0.0625, 0.3125, 0.5, 0},
                {-0.125, -0.5, -0.125, 0.0625, -0.4375, 0.0625},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        },
        visual_size = {x = 1.0, y = 1.0},

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            local pname = player:get_player_name()
            local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}

            local bird_in_stand_flag
            -- (Check if already a parrot on the stand)
            for _, obj in ipairs(core.get_objects_inside_radius(pos_above, 1)) do

                local luaent = obj:get_luaentity()
                if luaent and luaent.can_perch_flag then

                    bird_in_stand_flag = true

                    local rotation = obj:get_rotation()
                    local bird_pos = obj:get_pos()

                    local perch_forward_offset =
                            luaent.perch_forward_offset or {x = 0, y = 0, z = 0}
                    local perch_reverse_offset =
                            luaent.perch_reverse_offset or {x = 0, y = 0, z = 0}

                    if rotation.y == 0 then

                        obj:set_rotation({x = 0, y = math.pi, z = 0})
                        obj:set_rotation({x = 0, y = math.pi, z = 0})
                        obj:set_pos({
                            x = bird_pos.x + perch_reverse_offset.x,
                            y = bird_pos.y + perch_reverse_offset.y,
                            z = bird_pos.z + perch_reverse_offset.z,
                        })

                    else

                        obj:set_rotation({x = 0, y = 0, z = 0})
                        obj:set_pos({
                            x = bird_pos.x + perch_forward_offset.x,
                            y = bird_pos.y + perch_forward_offset.y,
                            z = bird_pos.z + perch_forward_offset.z,
                        })

                    end

                end

            end

            -- Convert the spawn egg to the equivalent mob
            local spawnegg_name = itemstack:get_name()
            if spawnegg_name == "" then
                return
            end

            local mob_name
            for k, v in pairs(unimobs.global.spawnegg_lookup_table) do

                if v == spawnegg_name then

                    mob_name = k
                    break

                end

            end

            if not mob_name then
                return
            end

            -- Get the entity prototype, so we can ignore non-perching creatures
            local ent_table = core.registered_entities[mob_name]
            if not ent_table or not ent_table.can_perch_flag then
                return
            end

            -- Place the bird on its stand, if permitted
            if bird_in_stand_flag == true then

                core.chat_send_player(pname, S("There is already something on the bird stand!"))

            elseif core.is_protected(pos, pname) then

                core.chat_send_player(pname, S("This bird stand doesn't belong to you!"))

            else

                local release_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
                if ent_table.perch_forward_offset then

                    release_pos = {
                        x = pos.x + ent_table.perch_forward_offset.x,
                        y = pos.y + ent_table.perch_forward_offset.y,
                        z = pos.z + ent_table.perch_forward_offset.z,
                    }

                end

                local luaent =
                        unimobs.petz_api.release_mob(player, itemstack, mob_name, release_pos)
                if luaent then
                    unilib.pkg.mtb_order_stand_here.do_action(luaent)
                end

            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From petz:bird_stand
        type = "shaped",
        output = "unilib:misc_stand_bird",
        recipe = {
            {c_stick, "group:feather", c_stick},
            {"", c_stick, ""},
            {"", c_stick, ""},
        },
    })

end
