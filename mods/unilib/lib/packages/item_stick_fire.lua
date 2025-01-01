---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.item_stick_fire = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_stick_fire.init()

    return {
        description = "Fire sticks",
        notes = "Can be used to ignite a fire, just like flint and steel",
        depends = "fire_ordinary",
        optional = "plant_shrub_dry",
    }

end

function unilib.pkg.item_stick_fire.exec()

    unilib.register_tool("unilib:item_stick_fire", "earthbuild:fire_sticks", mode, {
        -- From earthbuild:fire_sticks
        description = S("Fire Sticks"),
        inventory_image = "unilib_item_stick_fire.png",
        -- (no groups)
        sound = {breaks = "unilib_tool_breaks"},

        on_use = function(itemstack, user, pointed_thing)

            local sound_pos = pointed_thing.above or user:get_pos()
            core.sound_play(
                "unilib_item_stick_fire",
                {pos = sound_pos, gain = 0.5, max_hear_distance = 8}
            )

            local player_name = user:get_player_name()
            if pointed_thing.type == "node" then

                local node_under = core.get_node(pointed_thing.under).name
                local nodedef = core.registered_nodes[node_under]
                if not nodedef then
                    return
                end

                if core.is_protected(pointed_thing.under, player_name) then

                    core.chat_send_player(player_name, S("This area is protected"))
                    return

                end

                if nodedef.on_ignite then

                    nodedef.on_ignite(pointed_thing.under, user)

                elseif core.get_item_group(node_under, "flammable") >= 1 and
                        core.get_node(pointed_thing.above).name == "air" then
                    core.set_node(pointed_thing.above, {name = "unilib:fire_ordinary"})
                end

            end

            if unilib.utils.is_creative(player_name) then

                -- Wear the tool
                local def_table = itemstack:get_definition()
                itemstack:add_wear(2000)
                if itemstack:get_count() == 0 then
                    core.sound_play("unilib_tool_breaks", {pos = sound_pos, gain = 0.5})
                end

                return itemstack

            end

        end,
    })
    unilib.register_craft({
        -- From earthbuild:fire_sticks
        output = "unilib:item_stick_fire",
        recipe = {
            {"group:stick"},
            {"group:stick"},
            {"group:leaves"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:fire_sticks
        output = "unilib:item_stick_fire",
        recipe = {
            {"group:stick"},
            {"group:stick"},
            {"group:grass"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:fire_sticks
        output = "unilib:item_stick_fire",
        recipe = {
            {"group:stick"},
            {"group:stick"},
            {"group:dry_grass"},
        },
    })
    if unilib.global.pkg_executed_table["plant_shrub_dry"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:fire_sticks
            output = "unilib:item_stick_fire",
            recipe = {
                {"group:stick"},
                {"group:stick"},
                {"unilib:plant_shrub_dry"},
            },
        })

    end

end
