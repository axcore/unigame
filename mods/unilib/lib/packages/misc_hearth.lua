---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_hearth = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function after_destruct(pos, oldnode)

    -- Was no_hearth()
    -- Remove the hearth node, making sure to remove the invisible node too

    local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
    local node_above = minetest.get_node(pos_above)

    if node_above.name == "unilib:misc_hearth_air" then
        minetest.set_node(pos_above, {name = "air"})
    end

end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)

    -- Was hearth_allow_metadata_inventory_put()

    if listname == "fuel" then

        if minetest.get_craft_result({method = "fuel", width = 1, items = {stack}}).time ~= 0 then
            return stack:get_count()
        else
            return 0
        end

    end

    return 0

end

local function can_dig(pos, player)

    -- Was hearth_can_dig()

    local inv = minetest.get_meta(pos):get_inventory()
    return inv:is_empty("fuel")

end

local function produce_particles(pos, time)

    -- Was hearth_fire_on()
    -- Add particle effects

    local meta = minetest.get_meta(pos)

    -- Flames
    minetest.add_particlespawner({
        amount = 4,
        time = time,

        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 1
        },
        collisiondetection = false,
        glow = 13,
        maxacc = {x = 0.001, y = 0.001, z = 0.001},
        minacc = {x = 0, y = 0, z = 0},
        maxexptime = 5,
        minexptime = 3,
        maxpos = {x = pos.x + 0.1, y = pos.y + 1, z = pos.z + 0.1},
        minpos = {x = pos.x - 0.1, y = pos.y + 0.6, z = pos.z - 0.1},
        maxsize = 8,
        minsize = 4,
        maxvel = {x = 0.001, y = 0.001, z = 0.001},
        minvel = {x = 0, y = 0, z = 0},
        texture = "unilib_fire_ordinary_animated.png",
        vertical = true,

    })

    -- Smoke
    minetest.add_particlespawner({
        amount = 4,
        time = time,

        collisiondetection = true,
        maxacc = {x = 0.01, y = 0.2, z = 0.01},
        minacc = {x = 0, y = 0, z = 0},
        maxexptime = 20,
        minexptime = 5,
        maxpos = {x = pos.x + 0.1, y = pos.y + 1, z = pos.z + 0.1},
        minpos = {x = pos.x - 0.1, y = pos.y + 0.8, z = pos.z - 0.1},
        maxsize = 8,
        minsize = 1,
        maxvel = {x = 0.01, y = 0.07, z = 0.01},
        minvel = {x = 0, y = 0, z = 0},
        texture = "unilib_misc_smoke.png",
        vertical = true,
    })

end

local function do_burn(pos, elapsed)

    -- Was hearth_burn()
    -- Add flames and burn fuel

    local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
    local node_above = minetest.get_node(pos_above)
    local timer = minetest.get_node_timer(pos)

    local inv = minetest.get_inventory({type = "node", pos = pos})
    local item = inv:get_stack("fuel", 1)
    local fuel_burned = minetest.get_craft_result(
        {method = "fuel", width = 1, items = {item:peek_item(1)}}
    ).time

    -- Remove the invisible node, so it doesn't keep glowing
    if inv:is_empty("fuel") and node_above.name == "unilib:misc_hearth_air" then
        minetest.set_node(pos_above, {name = "air"})
    end

    -- Burn the inventory item, and add smoke and flames
    if fuel_burned > 0 and (
        node_above.name == "air" or
        node_above.name == "unilib:misc_hearth_air"
    ) then
        -- Randomly remove an item of fuel based on its burn time, so it can consume its fuel
        --      slowly, but still produce flames frequently, i.e. every x seconds it will have a
        --      1/x chance of burning
        local burn_time = fuel_burned * 30
        local burn_it = math.random(1, burn_time)
        if burn_it == 1 then

            item:set_count(item:get_count() - 1)
            inv:set_stack("fuel", 1, item)

        end

        -- Place the invisible node
        if node_above.name == "air" then
            minetest.set_node(pos_above, {name = "unilib:misc_hearth_air"})
        end

        -- Do fire effects, and restart the timer
        timer:start(5)
        produce_particles(pos, 5)
        minetest.sound_play(
            "unilib_misc_hearth",
            {pos = pos, max_hear_distance = 15, loop = false, gain = 0.2}
        )

    end

end

local function on_construct(pos)

    -- Was hearth_on_construct()

    local inv = minetest.get_meta(pos):get_inventory()
    inv:set_size("fuel", 1)

    local meta = minetest.get_meta(pos)
    meta:set_string("formspec",
        "size[8,5.3]" ..
        "list[current_name;fuel;3.5,0;1,1;]" ..
        "list[current_player;main;0,1.15;8,1;]" ..
        "list[current_player;main;0,2.38;8,3;8]" ..
        "listring[current_name;main]" ..
        "listring[current_player;main]" ..
        unilib.get_hotbar_bg(0,1.15)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_hearth.init()

    return {
        description = "Hearth",
        at_least_one = {"dirt_ordinary", "dirt_rammed", "material_cob"},
    }

end

function unilib.pkg.misc_hearth.exec()

    unilib.register_node("unilib:misc_hearth", "earthbuild:hearth", mode, {
        -- From earthbuild:hearth
        description = S("Hearth"),
        tiles = {
            "unilib_misc_hearth_top.png",
            "unilib_material_cob.png",
            "unilib_misc_hearth_side.png",
            "unilib_misc_hearth_side.png",
            "unilib_misc_hearth_side.png",
            "unilib_misc_hearth_side.png"
        },
        groups = {cracky = 1, crumbly = 1, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.dirt,

        damage_per_second = 1,
        drawtype = "normal",
        paramtype = "light",

        after_destruct = after_destruct,

        allow_metadata_inventory_put = allow_metadata_inventory_put,

        can_dig = can_dig,

        on_construct = on_construct,

        on_metadata_inventory_put = do_burn,

        on_timer = do_burn,
    })
    if unilib.pkg_executed_table["dirt_rammed"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:hearth
            output = "unilib:misc_hearth",
            recipe = {
                {"", "group:tree", ""},
                {"group:stick", "group:stick", "group:stick"},
                {"", "unilib:dirt_rammed", ""},
            }
        })

    end
    if unilib.pkg_executed_table["material_cob"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:hearth
            output = "unilib:misc_hearth",
            recipe = {
                {"", "group:tree", ""},
                {"group:stick", "group:stick", "group:stick"},
                {"", "unilib:material_cob", ""},
            }
        })

    end
    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:hearth
            output = "unilib:misc_hearth",
            recipe = {
                {"", "group:tree", ""},
                {"group:stick", "group:stick", "group:stick"},
                {"unilib:dirt_ordinary", "unilib:dirt_ordinary", "unilib:dirt_ordinary"},
            }
        })

    end

    -- Above the fire (when burning), we add an invisible glowing block as a light source
    unilib.register_node("unilib:misc_hearth_air", "earthbuild:hearth_air", mode, {
        -- From earthbuild:hearth_air
        description = S("Hearth Air"),
        -- N.B. Original code uses a texture, but the node is invisible
        -- (no tiles)
        groups = {igniter = 2, not_in_creative_inventory = 1},
        -- (no sounds)

        buildable_to = true,
        diggable = false,
        drawtype = "airlike",
        light_source = 9,
        paramtype = "light",
        pointable = false,
        protected = true,
        sunlight_propagates = true,
        walkable = false,

        on_blast = function(pos) end
    })

end
