---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_sledge = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.snow.add_mode

local timer = 0

local entity_table = {
    collisionbox = {-0.6, -0.25, -0.6, 0.6, 0.3, 0.6},
    mesh = "unilib_item_sledge.x",
    physical = true,
    textures = {"unilib_item_sledge.png"},
    visual = "mesh",
}

local mounted_player_table = {}
--[[
local driveable_list = {
    "unilib:snow_ordinary",
    "unilib:snow_ordinary_block",
    "unilib:ice_ordinary",
    "unilib:dirt_ordinary_with_cover_snow",
    "group:icemaker",
}
]]--
local driveable_list = {"group:icemaker", "group:slippery", "group:snowy"}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function table_find(t, v)

    for i = 1, #t do

        if t[i] == v then
            return true
        end

    end

    return false

end

local function is_water(pos)

    return minetest.get_item_group(minetest.get_node(pos).name, "water") ~= 0

end

local function mount_sledge(self, player)

    -- Was join_sled()

    local pos = self.object:get_pos()
    player:setpos(pos)
    local name = player:get_player_name()
    mounted_player_table[name] = true

    unilib.player_api.set_player_attached(name, true)
    unilib.player_api.set_animation(player, "sit" , 30)
    self.driver = name
    self.object:set_attach(player, "", {x = 0, y = -9, z = 0}, {x = 0, y = 90, z = 0})
    self.object:set_yaw(player:get_look_yaw())

end

local function dismount_sledge(self, player)

    -- Was leave_sled()

    local name = player:get_player_name()
    mounted_player_table[name] = false
    self.driver = nil
    self.object:set_detach()

    unilib.player_api.set_player_attached(name, false)
    unilib.player_api.set_animation(player, "stand" , 30)

    player:set_physics_override({jump = 1, speed = 1})
    player:hud_remove(self.hud)
    self.object:remove()

    -- Return the sledge back to the player
    player:get_inventory():add_item("main", "unilib:item_sledge")

end

local function sledge_on_rightclick(self, player)

    -- Was sled_rightclick(), on_sled_click(), sled:on_rightclick()

    if self.driver then
        return
    end

    mount_sledge(self, player)
    player:set_physics_override({
        speed = 2,  -- multiplier to default value
        jump = 0,   -- multiplier to default value
    })

    self.hud = player:hud_add({
        name = "sledge",
        hud_elem_type = "text",

        direction = 0,
        -- N.B. Tweaked y position to avoid conlicts with other HUDs, was originally 0.89
        position = {x = 0.5, y = 0.85},
        scale = {x = 2, y = 2},
        text = S("You are on the sledge! Hold the sneak key to get off."),
    })

end

local function can_accelerate(pos)

    -- Was accelerating_possible()

    if is_water(pos) then
        return false
    end
    if table_find(driveable_list, minetest.get_node({x = pos.x, y = pos.y-1, z = pos.z}).name) then
        return true
    end

    return false

end

---------------------------------------------------------------------------------------------------
-- Entity functions
---------------------------------------------------------------------------------------------------

function entity_table:on_rightclick(player)

    sledge_on_rightclick(self, player)

end

function entity_table:on_activate(staticdata)

    self.object:set_armor_groups({immortal = 1})
    self.object:set_acceleration({x = 0, y = -10, z = 0})
    if staticdata then
        self.v = tonumber(staticdata)
    end

end

function entity_table:get_staticdata()

    return tostring(self.v)

end

function entity_table:on_punch(puncher)

    self.object:remove()
    if puncher
    and puncher:is_player() then
        puncher:get_inventory():add_item("main", "unilib:item_sledge")
    end

end

function entity_table:on_step(dtime)

    if not self.driver then
        return
    end

    timer = timer + dtime
    if timer < 1 then
        return
    end

    timer = 0
    local player = minetest.get_player_by_name(self.driver)
    if not player then
        return
    end

    if player:get_player_control().sneak or
            not can_accelerate(vector.round(self.object:get_pos())) then
        dismount_sledge(self, player)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_sledge.init()

    return {
        description = "Sledge",
        notes = "When mounted, allows the player to walk quickly on snow and ice. Mounted" ..
                " players see a message, not an animation",
    }

end

function unilib.pkg.item_sledge.exec()

    -- Sledges require code imported from minetest_game/player_api, if not already loaded
    unilib.load_player_api()

    unilib.register_entity("unilib:entity_item_sledge", entity_table)

    unilib.register_craftitem("unilib:item_sledge", "snow:sled", mode, {
        -- From snow:sled
        description = S("Sledge"),
        inventory_image = "unilib_item_sledge_inv.png",

        liquids_pointable = true,
        stack_max = 1,
        wield_image = "unilib_item_sledge_inv.png",
        wield_scale = {x = 2, y = 2, z = 1},

        on_use = function(itemstack, placer)

            if mounted_player_table[placer:get_player_name()] then
                return
            end

            local pos = placer:get_pos()
            if can_accelerate(vector.round(pos)) then

                pos.y = pos.y + 0.5

                -- Get on the sledge and remove it from inventory
                minetest.add_entity(pos, "unilib:entity_item_sledge"):right_click(placer)
                itemstack:take_item()
                return itemstack

            end

        end,
    })
    unilib.register_craft({
        -- From snow:sled
        output = "unilib:item_sledge",
        recipe = {
            {"", "", ""},
            {"group:stick", "", ""},
            {"group:wood", "group:wood", "group:wood"},
        },
    })
    unilib.register_craft({
        -- From snow:sled
        output = "unilib:item_sledge",
        recipe = {
            {"", "", ""},
            {"", "", "group:stick"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })

end
