---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nextgen_compass
-- Code:    GPLv3
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_compass_spawn = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nextgen_compass.add_mode

-- Number of textures, one for each compass needle direction
local frame_count = 32
-- Compass spinning
local random_frame = math.random(0, frame_count - 1)
-- Timer for random compass spinning
local random_timer = 0
-- Random compass spinning tick in seconds. Increase if there are performance problems
local random_timer_trigger = 0.5

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_compass_img(pos, dir)

    -- Use the spawn specified by minetest.conf, e.g.
    --      static_spawnpoint = 100, 5, 100
    -- If minetest.conf doesn't specify a spawn, use the world origin instead

    local spawn = {x = 0, y = 0, z = 0}
    local ssp = minetest.setting_get_pos("static_spawnpoint")

    if ssp and
            type(ssp) == "table" and
            type(ssp.x) == "number" and
            type(ssp.y) == "number" and
            type(ssp.z) == "number" then
        spawn = ssp
    end

    local angle_north = math.deg(math.atan2(spawn.x - pos.x, spawn.z - pos.z))
    if angle_north < 0 then
        angle_north = angle_north + 360
    end

    local angle_dir = -math.deg(dir)
    local angle_relative = (angle_north - angle_dir + 180) % 360

    return math.floor((angle_relative / 11.25) + 0.5) % frame_count

end

local function has_compass(player)

    for _,stack in pairs(player:get_inventory():get_list("main")) do

        if minetest.get_item_group(stack:get_name(), "spawn_compass") ~= 0 then
            return true
        end

    end

    return false

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_compass_spawn.init()

    return {
        description = "A compass that points towards spawn",
        notes = "spawn must be specified in minetest.conf. If not, this compass points towards" ..
                " the world origin, behaving exactly like an origin compass",
        depends = {"metal_steel", "mineral_diamond"},
    }

end

function unilib.pkg.item_compass_spawn.exec()

    minetest.register_globalstep(function(dtime)

        random_timer = random_timer + dtime

        if random_timer >= random_timer_trigger then

            random_frame = (random_frame + math.random(-1, 1)) % frame_count
            random_timer = 0

        end

        for i, player in pairs(minetest.get_connected_players()) do

            if has_compass(player) then

                local pos = player:get_pos()
                local compass_img = get_compass_img(pos, player:get_look_horizontal())

                for j, stack in pairs(player:get_inventory():get_list("main")) do

                    if minetest.get_item_group(stack:get_name(), "spawn_compass") ~= 0 and
                            minetest.get_item_group(stack:get_name(), "spawn_compass") - 1 ~=
                                    compass_img then

                        local itemname = "unilib:item_compass_spawn_" .. compass_img
                        stack:set_name(itemname)
                        player:get_inventory():set_stack("main", j, stack)

                    end

                end

            end

        end

    end)

    local img_list = {}
    for frame = 0, frame_count - 1 do
        table.insert(img_list, "unilib_item_compass_spawn_" .. frame .. ".png")
    end

    -- N.B. Tweaked original code so that the needles points upwards in the compass shown in the
    --      player's inventory
    local default_frame = 17
    for i, img in ipairs(img_list) do

        local inv = 1
        if i == default_frame then
            inv = 0
        end

        local full_name = "unilib:item_compass_spawn_" .. (i - 1)

        unilib.register_craftitem(full_name, nil, mode, {
            -- From nextgen_compass:0, etc, but with modified code and textures
            description = S("Spawn Compass"),
            inventory_image = img,
            groups = {
                disable_repair = 1, not_in_creative_inventory = inv, spawn_compass = i, tool = 1,
            },

            stack_max = 1,
            wield_image = img,
        })

    end

    unilib.register_craft({
        -- From nextgen_compass:18
        output = "unilib:item_compass_spawn_" .. default_frame,
        recipe = {
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_ingot", "unilib:mineral_diamond_gem", "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_ingot", ""}
        }
    })

end
