---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_snow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_uneven(pos)

    -- From snow/init.lua, was uneven()
    -- Checks if the snow level is even at any given pos

    local num = core.get_node_level(pos)
    local get_node = core.get_node
    local add_node = core.add_node
    local foundx, foundz

    for z = -1, 1 do

        for x = -1, 1 do

            local p = {x = pos.x + x, y = pos.y, z = pos.z + z}
            local node = get_node(p)
            p.y = p.y - 1
            local bnode = get_node(p)

            if node and
                    core.registered_nodes[node.name] and
                    core.registered_nodes[node.name].drawtype == "plantlike" and
                    bnode.name == "unilib:dirt_ordinary_with_turf" then

                add_node(p, {name = "unilib:dirt_ordinary_with_cover_snow"})
                return true

            end

            p.y = p.y + 1
            if not (x == 0 and z == 0) and
                    node.name == "unilib:snow_ordinary" and
                    core.get_node_level(p) < num then

                foundx = x
                foundz = z

            elseif node.name == "air" and
                    bnode.name ~= "air" and
                    bnode.name ~= "unilib:snow_ordinary" then

                p.y = p.y - 1
                unilib.pkg.shared_snow.place(p)
                return true

            end

        end

    end

    if foundx then

        local p = {x = pos.x + foundx, y = pos.y, z = pos.z + foundz}
        if not is_uneven(p) then
            core.add_node_level(p, 7)
        end

        return true

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_snow.snow_onto_dirt(pos)

    pos.y = pos.y - 1
    local node = core.get_node(pos)
    if node.name == "unilib:dirt_ordinary_with_turf" or node.name == "unilib:dirt_ordinary" then
        core.set_node(pos, {name = "unilib:dirt_ordinary_with_cover_snow"})
    end

end

function unilib.pkg.shared_snow.place(pos, disablesound)

    -- From snow/init.lua, was snow.place()
    -- This function places snow checking at the same time for snow level and increasing as needed
    -- This also takes into account sourrounding snow and makes snow even

    local node = core.get_node_or_nil(pos)
    if not node or not core.registered_nodes[node.name] then
        return
    end

    if node.name == "unilib:snow_ordinary" then

        local level = core.get_node_level(pos)
        if level < 63 then

            if core.get_item_group(
                core.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name, "leafdecay"
            ) == 0 and not is_uneven(pos) then

                core.sound_play("unilib_snow_footstep", {pos = pos})
                core.add_node_level(pos, 7)

            end

        elseif level == 63 then

            local p = core.find_node_near(pos, 10, "unilib:dirt_ordinary_with_turf")
            if p and core.get_node_light(p, 0.5) == 15 then

                core.sound_play("unilib_grass_footstep", {pos = pos})
                core.place_node(
                    {x = pos.x, y = pos.y + 1, z = pos.z}, {name = "unilib:snow_ordinary"}
                )

            else

                core.sound_play("unilib_snow_footstep", {pos = pos})
                core.add_node(pos, {name = "unilib:snow_ordinary_block"})

            end

        end

    elseif node.name ~= "unilib:ice_ordinary" and
            core.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name ~= "air" then

        local data = core.registered_nodes[node.name]
        local drawtype = data.drawtype
        if drawtype == "normal" or drawtype == "allfaces_optional" then

            pos.y = pos.y + 1
            local sound = data.sounds
            if sound then

                sound = sound.footstep
                if sound then
                    core.sound_play(sound.name, {pos = pos, gain = sound.gain})
                end

            end

            core.place_node(pos, {name = "unilib:snow_ordinary"})

        elseif drawtype == "plantlike" then

            pos.y = pos.y - 1
            if core.get_node(pos).name == "unilib:dirt_ordinary_with_turf" then

                core.sound_play("unilib_grass_footstep", {pos = pos})
                core.add_node(pos, {name = "unilib:dirt_ordinary_with_cover_snow"})

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_snow.init()

    return {
        description = "Shared functions for customised snow effects and items (from snow mod)",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.shared_snow.exec()

    -- Shared craft recipes

    unilib.register_craft({
        -- From snow/crafting.lua
        type = "cooking",
        output = "unilib:ice_ordinary",
        recipe = "group:cooks_into_ice",
        cooktime = 12,
    })

end
