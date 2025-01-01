---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_trough_clay = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

local potable_water_table = {}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_trough_clay.init()

    return {
        description = "Clay trough",
        notes = "The trough is open at the bottom. Place it over any water source, then" ..
                " right-click it to \"wash\" yourself",
        depends = "clay_ordinary",
    }

end

function unilib.pkg.furniture_trough_clay.exec()

    unilib.register_node("unilib:furniture_trough_clay", "cottages:washing", mode, {
        -- From cottages:washing
        description = S("Clay Trough"),
        tiles = {"unilib_clay_ordinary.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.stone,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.2, -0.2},
                {-0.5, -0.5, -0.2, -0.4, 0.2, 0.5},
                {0.4, -0.5, -0.2, 0.5, 0.2, 0.5},
                {-0.4, -0.5, 0.4, 0.4, 0.2, 0.5},
                {-0.4, -0.5, -0.2, 0.4, 0.2, -0.1},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.2, 0.5},
            },
        },

        on_rightclick = function(pos, node, player)

            local node_under = core.get_node({x = pos.x, y = (pos.y - 1), z = pos.z})
            --[[
            if not(node_under) or
                    node_under.name == "ignore" or
                    (
                        node_under.name ~= "unilib:liquid_water_ordinary_source" and
                        node_under.name ~= "unilib:liquid_water_ordinary_flowing"
                    ) then
            ]]--
            if not(node_under) or
                    node_under.name == "ignore" or
                    potable_water_table[node_under.name] == nil then

                core.chat_send_player(
                    player:get_player_name(),
                    S("Sorry, this trough is out of water. Please place it above water!")
                )

           else

                core.chat_send_player(
                    player:get_player_name(),
                    S("You feel much cleaner after washing yourself!")
                )

           end

        end,
    })
    unilib.register_craft({
        -- From cottages:washing
        output = "unilib:furniture_trough_clay 2",
        recipe = {
            {"group:stick"},
            {"unilib:clay_ordinary"},
        },
    })

end

function unilib.pkg.furniture_trough_clay.post()

    -- Original code only works with ordinary water; unilib code works with all potable waters

    for part_name, data_table in pairs(unilib.global.generic_liquid_table) do

        if data_table.potable_flag and data_table.water_flag then

            potable_water_table[data_table.source_name] = true
            potable_water_table[data_table.flowing_name] = true

        end

    end

end
