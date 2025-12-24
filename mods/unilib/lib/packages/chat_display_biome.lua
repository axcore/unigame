---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    display_biome
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_display_biome = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.display_biome.add_mode

-- Yellow text; the original code used red, 0xFF0000
local hud_colour = 0xFFFF00

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function open_hud(player)

    unilib.hud.add_section(player, "chat_display_biome", 3)
    unilib.hud.update_line(player, "chat_display_biome", 1, "-", hud_colour)

end

local function close_hud(player)

    unilib.hud.remove_section(player, "chat_display_biome")

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_display_biome.init()

    return {
        description = "Chat command /display_biome",
        notes = "Toggles displaying the current biome",
    }

end

function unilib.pkg.chat_display_biome.exec()

    -- Table of connected player names (as keys) and their current position data (table as a value)
    local display_player_table = {}
    -- Global callbacks are expected every 0.1 seconds, but don't update the display more often than
    --      every 0.5 seconds
    local display_timer = 0

    core.register_on_joinplayer(function(player)

        -- When the player connects, add an entry to "display_player_table"

        local pname = player:get_player_name()

        -- N.B. Prior to v1.0.062, this command was called /show_biome (and used a different mod
        --      attribute)
        -- It's unlikely to inconvenience the player if we just reset the old attribute, so we'll
        --      do that (in one line of code) rather than renaming the old attribute (in several
        --      lines of code)
        unilib.utils.set_mod_attribute("biomes_show_" .. pname, nil)

        -- Now continue as before
        local storage_key = "biomes_display_" .. pname
        if tonumber(unilib.utils.get_mod_attribute(storage_key)) == 1 then

            -- Display enabled
            --[[
            display_player_table[pname] = {
                last_ippos = {x = 0, y = 0, z = 0},
                id = player:hud_add({
                    name = "unilib:hud_chat_display_biome",
                    type = "text",

                    number = hud_colour,
                    position = {x = 0.5, y = 0.1},
                    text = "-",
                }),
                enable = true,
            }
            ]]--
            display_player_table[pname] = {
                last_ippos = {x = 0, y = 0, z = 0},
                enable = true,
                visible = false,
            }

        else

            -- Display not enabled
            --[[
            display_player_table[pname] = {
                last_ippos = {x = 0,y = 0, z = 0},
                id = player:hud_add({
                    name = "unilib:hud_chat_display_biome",
                    type = "text",

                    number = hud_colour,
                    position = {x = 0.5, y = 0.1},
                    text = "",
                }),
                enable = false,
            }
            ]]--
            close_hud(player)
            display_player_table[pname] = {
                last_ippos = {x = 0,y = 0, z = 0},
                enable = false,
                visible = false,
            }

        end

    end)

    core.register_on_leaveplayer(function(player)

        -- When the player disconnects, remove the entry to "display_player_table"

        local pname = player:get_player_name()
        if display_player_table[pname] then

            close_hud(player)
            display_player_table[pname] = nil

        end

    end)

    core.register_globalstep(function(dtime)

        -- Global callback to update the biome displayed

        -- Global callbacks are expected every 0.1 seconds, but don't update the display more often
        --      than every 0.5 seconds
        display_timer = display_timer + dtime
        if display_timer < 0.5 then
            return
        end
        display_timer = 0

        -- Update each player's display in turn
        for _, player in ipairs(core.get_connected_players()) do

            local pname = player:get_player_name()
            if display_player_table[pname].enable == true then

                if display_player_table[pname].visible == false then

                    open_hud(player)
                    display_player_table[pname].visible = true

                end

                -- Integer position
                local ippos = vector.round(player:get_pos())
                -- Surface position at which to calculate biome
                local bpos = vector.new(ippos)

                -- If the position has changed...
                if not vector.equals(ippos, display_player_table[pname].last_ippos) then

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

                    local rc = player:hud_change(display_player_table[pname].id, "text", msg)
                    -- Check return code, seems to fix occasional startup glitches
                    if rc == 1 then

                        -- Update player's position
                        display_player_table[pname].last_ippos = vector.new(ippos)

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
                        unilib.hud.update_line(player, "chat_display_biome", i, msg, hud_colour)
                    end

                end

            elseif display_player_table[pname].visible == true then

                close_hud(player)
                display_player_table[pname].visible = false

            end

        end

    end)

    core.register_chatcommand("display_biome", {
        params = "",
        description = S("Toggles displaying the current biome"),
        privs = {unilib_tools = true},

        func = function(pname, param)

            local player = core.get_player_by_name(pname)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            local storage_key = "biomes_display_" .. pname
            if display_player_table[pname].enable == true then

                --[[
                player:hud_change(display_player_table[pname].id, "text", "")
                display_player_table[pname].enable = false
                unilib.utils.set_mod_attribute(storage_key, "0")
                ]]--
                close_hud(player)
                display_player_table[pname].enable = false
                display_player_table[pname].visible = false
                unilib.utils.set_mod_attribute(storage_key, "0")

            else

                --[[
                player:hud_change(display_player_table[pname].id, "text", "-")
                -- Reset position
                display_player_table[pname].last_ippos = {x = 0, y = 0, z = 0}
                display_player_table[pname].enable = true
                unilib.utils.set_mod_attribute(storage_key, "1")
                ]]--
                open_hud(player)
                display_player_table[pname].enable = true
                display_player_table[pname].visible = false
                -- Reset position
                display_player_table[pname].last_ippos = {x = 0, y = 0, z = 0}
                unilib.utils.set_mod_attribute(storage_key, "1")

            end

        end,
    })

end
