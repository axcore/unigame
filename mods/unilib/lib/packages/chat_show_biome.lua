---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    display_biome
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_biome = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.display_biome.add_mode

-- Yellow text; the original code used red, 0xFF0000
local hud_colour = 0xFFFF00

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function open_hud(player)

    unilib.hud.add_section(player, "chat_show_biome", 3)
    unilib.hud.update_line(player, "chat_show_biome", 1, "-", hud_colour)

end

local function close_hud(player)

    unilib.hud.remove_section(player, "chat_show_biome")

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_biome.init()

    return {
        description = "Chat command /show_biome",
        notes = "Toggles showing the current biome (adapted from display_biome/init.lua)",
    }

end

function unilib.pkg.chat_show_biome.exec()

    -- Table of connected player names (as keys) and their current position data (table as a value)
    local show_player_table = {}
    -- Global callbacks are expected every 0.1 seconds, but don't update the display more often than
    --      every 0.5 seconds
    local show_timer = 0

    core.register_on_joinplayer(function(player)

        -- When the player connects, add an entry to "show_player_table"

        local pname = player:get_player_name()
        local storage_key = "biomes_show_" .. pname

        if tonumber(unilib.utils.get_mod_attribute(storage_key)) == 1 then

            -- Display enabled
            --[[
            show_player_table[pname] = {
                last_ippos = {x = 0, y = 0, z = 0},
                id = player:hud_add({
                    name = "show_biomes",
                    type = "text",

                    number = hud_colour,
                    position = {x = 0.5, y = 0.1},
                    text = "-",
                }),
                enable = true,
            }
            ]]--
            show_player_table[pname] = {
                last_ippos = {x = 0, y = 0, z = 0},
                enable = true,
                visible = false,
            }

        else

            -- Display not enabled
            --[[
            show_player_table[pname] = {
                last_ippos = {x = 0,y = 0, z = 0},
                id = player:hud_add({
                    name = "show_biomes",
                    type = "text",

                    number = hud_colour,
                    position = {x = 0.5, y = 0.1},
                    text = "",
                }),
                enable = false,
            }
            ]]--
            close_hud(player)
            show_player_table[pname] = {
                last_ippos = {x = 0,y = 0, z = 0},
                enable = false,
                visible = false,
            }

        end

    end)

    core.register_on_leaveplayer(function(player)

        -- When the player disconnects, remove the entry to "show_player_table"

        local pname = player:get_player_name()
        if show_player_table[pname] then

            close_hud(player)
            show_player_table[pname] = nil

        end

    end)

    core.register_globalstep(function(dtime)

        -- Global callback to update the biome displayed

        -- Global callbacks are expected every 0.1 seconds, but don't update the display more often
        --      than every 0.5 seconds
        show_timer = show_timer + dtime
        if show_timer < 0.5 then
            return
        end
        show_timer = 0

        -- Update each player's display in turn
        for _, player in ipairs(core.get_connected_players()) do

            local pname = player:get_player_name()
            if show_player_table[pname].enable == true then

                if show_player_table[pname].visible == false then

                    open_hud(player)
                    show_player_table[pname].visible = true

                end

                -- Integer position
                local ippos = vector.round(player:get_pos())
                -- Surface position at which to calculate biome
                local bpos = vector.new(ippos)

                -- If the position has changed...
                if not vector.equals(ippos, show_player_table[pname].last_ippos) then

                    -- Simple search for ground elevation
                    while bpos.y > 0 and core.get_node(bpos).name == "air" do
                        bpos.y = bpos.y - 1
                    end

                    local heat, humidity, name
                    local bdata = core.get_biome_data(bpos)
                    heat = math.floor(bdata.heat + 0.5)
                    humidity = math.floor(bdata.humidity + 0.5)
                    name = core.get_biome_name(bdata.biome)

                    --[[
                    local msg = S("Temperature: @1\nHumidity: @2", heat, humidity)
                    -- (Default value of the .description field, is the same as the value of the
                    --      .name field)
                    if unilib.global.biome_info_table[name] ~= nil and
                            unilib.global.biome_info_table[name]["description"] ~= name then
                        msg = msg .. "\n" .. unilib.global.biome_info_table[name]["description"]
                    end

                    msg = msg .. "\n" .. name

                    local rc = player:hud_change(show_player_table[pname].id, "text", msg)
                    -- Check return code, seems to fix occasional startup glitches
                    if rc == 1 then

                        -- Update player's position
                        show_player_table[pname].last_ippos = vector.new(ippos)

                    end
                    ]]--

                    local description = "-"
                    if unilib.global.biome_info_table[name] ~= nil and
                            unilib.global.biome_info_table[name]["description"] ~= name then
                        description = unilib.global.biome_info_table[name]["description"]
                    end

                    local msg_list = {
                        S("Temp: @1   Humid: @2", heat, humidity),
                        description,
                        name,
                    }

                    for i, msg in ipairs(msg_list) do
                        unilib.hud.update_line(player, "chat_show_biome", i, msg, hud_colour)
                    end

                end

            elseif show_player_table[pname].visible == true then

                close_hud(player)
                show_player_table[pname].visible = false

            end

        end

    end)

    core.register_chatcommand("show_biome", {
        params = "",
        description = S("Toggles showing the current biome"),
        privs = {unilib_tools = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            local storage_key = "biomes_show_" .. name
            if show_player_table[name].enable == true then

                --[[
                player:hud_change(show_player_table[name].id, "text", "")
                show_player_table[name].enable = false
                unilib.utils.set_mod_attribute(storage_key, "0")
                ]]--
                close_hud(player)
                show_player_table[name].enable = false
                show_player_table[name].visible = false
                unilib.utils.set_mod_attribute(storage_key, "0")

            else

                --[[
                player:hud_change(show_player_table[name].id, "text", "-")
                -- Reset position
                show_player_table[name].last_ippos = {x = 0, y = 0, z = 0}
                show_player_table[name].enable = true
                unilib.utils.set_mod_attribute(storage_key, "1")
                ]]--
                open_hud(player)
                show_player_table[name].enable = true
                show_player_table[name].visible = false
                -- Reset position
                show_player_table[name].last_ippos = {x = 0, y = 0, z = 0}
                unilib.utils.set_mod_attribute(storage_key, "1")

            end

        end,
    })

end
