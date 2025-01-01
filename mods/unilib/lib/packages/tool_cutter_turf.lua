---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_cutter_turf = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_cut(itemstack, user, pointed_thing)

    -- Was turf_cut()

    local player_name = user:get_player_name()

    if pointed_thing.type ~= "node" then
        return
    end

    local pos = pointed_thing.under
    local node = core.get_node(pos)

    if unilib.global.dirt_with_turf_table[node.name] ~= nil then

        local data_table = unilib.global.dirt_with_turf_table[node.name]
        local construction_name = "unilib:dirt_construction_with_" .. data_table.turf_part_name
        local dirt_name = "unilib:" .. data_table.dirt_part_name

        -- Take the turf
        core.sound_play(
            "unilib_tool_dirt",
            {pos = pos, max_hear_distance = 5, loop = false, gain = 0.5}
        )

        local inv = user:get_inventory()
        inv:add_item("main", construction_name)

        -- Chance of destroying dirt
        -- N.B. In original code, was a 1 in 2 chance
        local chance = math.random(1,2)
        if chance == 1 then
            core.set_node(pos, {name = "air"})
        else
            core.set_node(pos, {name = dirt_name})
        end

        if unilib.utils.is_creative(player_name) then

            -- Wear the tool
            local def_table = itemstack:get_definition()
            itemstack:add_wear(700)

            -- Tool break sound
            if itemstack:get_count() == 0 and def_table.sound and def_table.sound.breaks then
                core.sound_play(def_table.sound.breaks, {pos = sound_pos, gain = 0.5})
            end

            return itemstack

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_cutter_turf.init()

    return {
        description = "Turf cutter",
        notes = "When used on compatible dirts, slices off the turf layer to produce a new" ..
                " block, typically used in the constuction of buildings. Leaves behind the bare" ..
                " dirt node, but with a chance of destroying the dirt altogether",
        depends = {"dirt_construction", "tool_shovel_wood"},
    }

end

function unilib.pkg.tool_cutter_turf.exec()

    unilib.register_tool("unilib:tool_cutter_turf", "earthbuild:turf_cutter", mode, {
        -- From earthbuild:turf_cutter
        description = S("Turf Cutter"),
        inventory_image = "unilib_tool_cutter_turf.png",
        groups = {flammable = 2},
        sound = {breaks = "unilib_tool_breaks"},

        on_use = do_cut,
    })
    unilib.register_craft({
        -- From earthbuild:turf_cutter
        output = "unilib:tool_cutter_turf",
        recipe = {
            {"group:stick", "unilib:tool_shovel_wood", ""},
        },
    })

end
