---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    fire
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_flint = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local fire_add_mode = unilib.global.imported_mod_table.fire.add_mode
local mtg_plus_add_mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_flint.init()

    return {
        description = "Flint (as a mineral)",
        notes = "Dropped randomly when digging gravel. Left-click flammable nodes with flint and" ..
                " steel to start an (ordinary) fire",
        -- Craft flint and steel to start an ordinary fire (by punching a flammable node), or a
        --      permanent flame (by punching a coalblock)
        optional = {"fire_ordinary", "fire_permanent", "mineral_coal", "metal_steel"},
    }

end

function unilib.pkg.mineral_flint.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "flint",
        description = S("Flint"),

        hardness = 2,
    })

    unilib.register_craftitem("unilib:mineral_flint_lump", "default:flint", default_add_mode, {
        -- From default:flint
        description = S("Piece of Flint"),
        inventory_image = "unilib_mineral_flint_lump.png"
    })

    if unilib.setting.mtgame_tweak_flag then

        unilib.register_node(
            -- From mtg_plus:flint_block
            "unilib:mineral_flint_block",
            "mtg_plus:flint_block",
            mtg_plus_add_mode,
            {
                description = S("Flint Block"),
                tiles = {"unilib_mineral_flint_block.png"},
                groups = {cracky = 2},
                sounds = unilib.global.sound_table.stone,

                is_ground_content = false,
            }
        )
        unilib.register_craft_3x3({
            -- From mtg_plus:flint_block
            output = "unilib:mineral_flint_block",
            ingredient = "unilib:mineral_flint_lump",
        })
        unilib.register_craft({
            -- From mtg_plus:flint_block
            output = "unilib:mineral_flint_lump 9",
            recipe = {
                {"unilib:mineral_flint_block"},
            },
        })
        unilib.register_stairs("unilib:mineral_flint_block")
        unilib.register_carvings("unilib:mineral_flint_block", {
            millwork_flag = true,
        })

    end

end

function unilib.pkg.mineral_flint.post()

    if fire_add_mode == "defer" then
        return
    end

    if unilib.global.pkg_executed_table["fire_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["metal_steel"] ~= nil then

        unilib.register_tool(
            -- From fire:flint_and_steel
            "unilib:mineral_flint_lump_with_steel",
            "fire:flint_and_steel",
            fire_add_mode,
            {
                description = S("Flint and Steel"),
                inventory_image = "unilib_mineral_flint_lump_with_steel.png",
                -- (no groups)
                sound = {breaks = "unilib_tool_breaks"},

                on_use = function(itemstack, user, pointed_thing)

                    local sound_pos = pointed_thing.above or user:get_pos()
                    core.sound_play(
                        "unilib_flint_with_steel",
                        {pos = sound_pos, gain = 0.2, max_hear_distance = 8},
                        true
                    )

                    local player_name = user:get_player_name()
                    if pointed_thing.type == "node" then

                        local node_under = core.get_node(pointed_thing.under).name
                        local nodedef = core.registered_nodes[node_under]
                        if not nodedef then
                            return
                        end

                        if core.is_protected(pointed_thing.under, player_name) then

                            core.record_protection_violation(pointed_thing.under, player_name)
                            return

                        end

                        -- (Special handling for artisanal glass nodes, which ignite tinted flames)
                        if unilib.global.pkg_executed_table["fire_permanent_tinted"] ~= nil and
                                string.find(node_under, "^unilib:glass_artisanal_dyed_") then

                            -- (Assuming "unilib:glass_artisanal_dyed_X")
                            local flame_name = "unilib:fire_permanent_tinted_" ..
                                    string.sub(node_under, 29)

                            if core.registered_nodes[flame_name] ~= nil then

                                core.set_node(
                                    {
                                        x = pointed_thing.under.x,
                                        y = pointed_thing.under.y + 1,
                                        z = pointed_thing.under.z,
                                    },
                                    {name = flame_name}
                                )

                            end

                        -- (Back to original code)
                        elseif nodedef.on_ignite then

                            nodedef.on_ignite(pointed_thing.under, user)

                        elseif core.get_item_group(node_under, "flammable") >= 1
                                and core.get_node(pointed_thing.above).name == "air" then

                            if core.is_protected(pointed_thing.above, player_name) then

                                core.record_protection_violation(pointed_thing.above, player_name)
                                return

                            end

                            core.set_node(pointed_thing.above, {name = "unilib:fire_ordinary"})

                        end

                    end

                    if not unilib.utils.is_creative(player_name) then

                        -- Wear tool
                        local wdef = itemstack:get_definition()
                        itemstack:add_wear_by_uses(66)

                        -- Tool break sound
                        if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then

                            core.sound_play(
                                wdef.sound.breaks,
                                {pos = sound_pos, gain = 0.5},
                                true
                            )

                        end

                        return itemstack

                    end

                end
            }
        )
        unilib.register_craft({
            -- From fire:flint_and_steel
            output = "unilib:mineral_flint_lump_with_steel",
            recipe = {
                {"unilib:mineral_flint_lump", "unilib:metal_steel_ingot"},
            },
        })

    end

    if unilib.global.pkg_executed_table["fire_permanent"] ~= nil and
            unilib.global.pkg_executed_table["mineral_coal"] ~= nil then

        -- Notes from fire:
        -- Override coalblock to enable permanent flame
        -- Coalblock is non-flammable to avoid unwanted ordinary fire nodes
        unilib.override_item("unilib:mineral_coal_block", {

            after_destruct = function(pos)

                pos.y = pos.y + 1
                if core.get_node(pos).name == "unilib:fire_permanent" then
                    core.remove_node(pos)
                end

            end,

            on_ignite = function(pos)

                local flame_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
                if core.get_node(flame_pos).name == "air" then
                    core.set_node(flame_pos, {name = "unilib:fire_permanent"})
                end

            end

        })

    end

end
