---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    hangglider
-- Code:    LGPL 3.0+
-- Media:   CC-BY-SA 3.0 UNPORTED/CC-BY-SA 3.0/CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_hangglider = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.hangglider.add_mode

-- Show glider struts as overlay on HUD
local hud_overlay_flag = true
local id_table = {}
local move_model_up_flag = true
local use_table = {}
local no_fly_zone_flag = false
local physics_table = {"jump", "speed", "gravity"}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function can_fly(pname, pos)

    -- Checks if the player will get shot down at the position

    if areas and
            minetest.is_protected(vector.round(pos), pname) and
            no_fly_zone_flag then

        for id, area in pairs(areas:getAreasAtPos(pos)) do

            if area.no_fly then
                return false
            end

        end

    end

    return true

end

local function shot_sound(pos)

    minetest.sound_play("unilib_item_hangglider_warning", {
        pos = pos,
        max_hear_distance = 30,
        gain = 10.0,
    })

end

local function apply_physics_override(player, overrides)

    player:set_physics_override(overrides)

end

local function remove_physics_override(player, overrides)

    for _, attr in pairs(physics_table) do

        if overrides[attr] then
            player:set_physics_override({[attr] = 1})
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_hangglider.init()

    return {
        description = "Hangglider",
        notes = "Left-click to equip or unequip the hangglider while falling. Use the" ..
                " /no_fly_zone command to disable flying in your protected areas",
        mod_optional = "areas",
        depends = {"item_stick_ordinary", "wool_basic"},
        optional = "item_paper_ordinary",
    }

end

function unilib.pkg.item_hangglider.exec()

    local c_paper = "unilib:item_paper_ordinary"

    if core.global_exists("areas") then

        no_fly_zone_flag = true

        -- chat command definition adapted from "areas" mod
        minetest.register_chatcommand("no_fly_zone",{
            params = "<ID>",
            description = "Toggle airspace restrictions for area <ID>",

            func = function(name, param)

                local id = tonumber(param)
                if not id then
                    return false, "Invalid usage, see /help no_fly_zone."
                end

                if not areas:isAreaOwner(id, name) then
                    return false, "Area " .. id .. " does not exist or is not owned by you."
                end

                local open = not areas.areas[id].no_fly

                -- Save false as nil to avoid inflating the DB
                areas.areas[id].no_fly = open or nil
                areas:save()
                if open then
                    return true, ("No-fly-zone enabled in the area.")
                else
                    return true, ("No-fly-zone disabled in the area.")
                end

            end,
        })

    end

    local step_v
    minetest.register_entity("unilib:entity_hangglider", {
        -- From hangglider:glider
        collisionbox = {0, 0, 0, 0, 0, 0},
        immortal = true,
        mesh = "unilib_item_hangglider.obj",
        static_save = false,
        textures = {"unilib_wool_white.png", "unilib_tree_apple_wood.png"},
        visual = "mesh",
        visual_size = {x = 12, y = 12},

        on_step = function(self, dtime)

            local can_exist_flag = false
            if self.object:get_attach() then

                local player = self.object:get_attach("parent")
                if player then

                    local pos = player:get_pos()
                    local pname = player:get_player_name()
                    if use_table[pname] then

                        local mrn_name = minetest.registered_nodes[minetest.get_node(
                            vector.new(pos.x, pos.y - 0.5, pos.z)
                        ).name]

                        if mrn_name then

                            if not (mrn_name.walkable or mrn_name.liquidtype ~= "none") then

                                can_exist_flag = true
--                              step_v = player:get_player_velocity().y
                                step_v = player:get_velocity().y
                                if step_v < 0 and step_v > -3 then

                                    apply_physics_override(
                                        player, {speed = math.abs(step_v / 2) + 0.75}
                                    )

                                elseif step_v <= -3 then

                                    --Cap our gliding movement speed.
                                    apply_physics_override(player, {speed = 2.25})

                                else

                                    remove_physics_override(player, {speed = 1})

                                end

                                apply_physics_override(player, {gravity = ((step_v + 3) / 20)})

                            end
                        end

                    end

                    if not can_fly(pname, pos) then

                        -- Warning shot
                        if not self.warned then

                            self.warned = 0
                            shot_sound(pos)
                            minetest.chat_send_player(
                                pname,
                                S(
                                    "No fly zone! You will be shot down in @1 seconds!",
                                    unilib.hangglider_no_fly_time
                                )
                            )

                        end

                        -- Shoot down
                        self.warned = self.warned + dtime
                        if self.warned > unilib.hangglider_no_fly_time then

                            player:set_hp(1)
                            player:get_inventory():remove_item(
                                "main", ItemStack("unilib:item_hangglider")
                            )

                            shot_sound(pos)
                            can_exist_flag = false

                        end

                    end

                    if not can_exist_flag then

                        remove_physics_override(player, {gravity = 1, jump = 1, speed = 1})
                        use_table[pname] = false
                        if hud_overlay_flag then
                            player:hud_change(id_table[pname], "text", "blank.png")
                        end

                    end

                end

            end

            if not can_exist_flag then

                self.object:set_detach()
                self.object:remove()

            end

        end,
    })

    minetest.register_on_dieplayer(function(player)

        remove_physics_override(player, {gravity = 1, jump = 1})
        use_table[player:get_player_name()] = false

    end)


    minetest.register_on_joinplayer(function(player)

        local pname = player:get_player_name()
        remove_physics_override(player, {gravity = 1, jump = 1})
        use_table[pname] = false

        if hud_overlay_flag then

            id_table[pname] = player:hud_add({
                name = "hangglider",
                hud_elem_type = "image",

                alignment = {x = 1, y = 1},
                offset = {x = 0, y = 0},
                position = {x = 0, y = 0},
                scale = {x = -100, y = -100},
                text = "blank.png",
            })

        end

    end)

    minetest.register_on_leaveplayer(function(player)

        local pname = player:get_player_name()
        use_table[pname] = nil
        if hud_overlay_flag then
            id_table[pname] = nil
        end

    end)

    unilib.register_tool("unilib:item_hangglider", "hangglider:hangglider", mode, {
        -- From hangglider:hangglider
        description = S("Hangglider"),
        inventory_image = "unilib_item_hangglider_inv.png",
        sound = {breaks = "unilib_tool_breaks"},

        stack_max = 1,

        on_use = function(itemstack, player, pointed_thing)

            if not player then
                return
            end

            local pos = player:get_pos()
            local pname = player:get_player_name()

            -- Equip
            if not use_table[pname] then

                minetest.sound_play(
                    "unilib_item_hangglider_equip",
                    {pos = pos, max_hear_distance = 8, gain = 1.0}
                )

                if hud_overlay_flag then
                    player:hud_change(id_table[pname], "text", "unilib_item_hangglider_struts.png")
                end

                local airbreak = false
--              local vel = player:get_player_velocity().y
                local vel = player:get_velocity().y
                if not airbreak then

                    if move_model_up_flag then

                        minetest.add_entity(pos, "unilib:entity_hangglider"):set_attach(
                            player, "", {x = 0, y = 10, z = 0}, {x = 0, y = 0, z = 0}
                        )

                    else

                        minetest.add_entity(pos, "unilib:entity_hangglider"):set_attach(
                            player, "", {x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0}
                        )

                    end

                end

                use_table[pname] = true
                apply_physics_override(player, {jump = 0})
                itemstack:set_wear(itemstack:get_wear() + 255)
                return itemstack

            -- Unequip
            elseif use_table[pname] then

                if hud_overlay_flag then

                    player:hud_change(
                        id_table[pname],
                        "text",
                        "unilib_tree_apple_wood.png^[colorize:#0000:255"
                    )

                end

                use_table[pname] = false

            end

        end,
    })
    unilib.register_craft({
        -- From hangglider:hangglider
        output = "unilib:item_hangglider",
        recipe = {
            {"unilib:wool_white", "unilib:wool_white", "unilib:wool_white"},
            {"unilib:item_stick_ordinary", "", "unilib:item_stick_ordinary"},
            {"", "unilib:item_stick_ordinary", ""},
        }
    })
    if unilib.pkg_executed_table["item_paper_ordinary"] ~= nil then

        unilib.register_craft({
            -- From hangglider:hangglider
            type = "shapeless",
            output = "unilib:item_hangglider",
            recipe = {
                c_paper, c_paper, c_paper,
                c_paper, "unilib:item_hangglider", c_paper,
                c_paper, c_paper, c_paper,
            },
        })

    end
    unilib.register_tool_no_repair(
        "unilib:item_hangglider", S("This hangglider cannot be repaired")
    )

end
