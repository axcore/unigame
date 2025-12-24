---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_show_biome = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_show_biome.init()

    return {
        description = "Chat command /show_biome",
        notes = "Shows the biome at the player's location",
    }

end

function unilib.pkg.chat_show_biome.exec()

    core.register_chatcommand("show_biome", {
        params = "",
        description = S("Shows the biome at the player's location"),
        privs = {unilib_tools = true},

        func = function(pname, param)

            local player = core.get_player_by_name(pname)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            -- (Code adapted from the "chat_display_biome" package)
            local ippos = vector.round(player:get_pos())
            local bpos = vector.new(ippos)
            while bpos.y > 0 and core.get_node(bpos).name == "air" do
                bpos.y = bpos.y - 1
            end

            local bdata = core.get_biome_data(bpos)
            local heat = math.floor(bdata.heat + 0.5)
            local humidity = math.floor(bdata.humidity + 0.5)
            local name = core.get_biome_name(bdata.biome)

            -- (Original code)
            return true, S(
                "Current biome is @1 (temp: @2) (humid: @3)  (pos: @4, @5, @6)",
                name,
                heat,
                humidity,
                string.format("%.1f", bpos.x),
                string.format("%.1f", bpos.y),
                string.format("%.1f", bpos.z)
            )

        end,
    })

end
