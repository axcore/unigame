---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.rope_sturdy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rope_sturdy.init()

    return {
        description = "Sturdy rope",
        notes = "Can only be dug from the bottom of the whole rope",
        depends = "crop_cotton",
    }

end

function unilib.pkg.rope_sturdy.exec()

    local c_cotton = "unilib:crop_cotton_harvest"

    unilib.register_node("unilib:rope_sturdy", "cottages:rope", mode, {
        -- From cottages:rope
        description = S("Sturdy Rope"),
        tiles = {"unilib_rope_sturdy.png"},
        -- N.B. removed the "connect_to_raillike" group in original code, as it doesn't seem to work
        groups = {choppy = 3, oddly_breakable_by_hand = 3, rail = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        climbable = true,
        drawtype = "plantlike",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,

        can_dig = function(pos, player)

            local below = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
            if below and below.name and below.name == "unilib:rope_sturdy" then

                if player then

                    minetest.chat_send_player(
                        player:get_player_name(),
                        S("The entire rope would be too heavy. Start digging at its lowest end!")
                    )

                end

                return false

            else

                return true

            end

        end
    })
    -- N.B. Original craft recipe conflicts with recipe in "misc_walkway" package
    --[[
    unilib.register_craft({
        -- From cottages:rope
        output = "unilib:rope_sturdy",
        recipe = {
            {
                "unilib:crop_cotton_harvest",
                "unilib:crop_cotton_harvest",
                "unilib:crop_cotton_harvest",
            },
        },
    })
    ]]--
    unilib.register_craft({
        -- From cottages:rope
        output = "unilib:rope_sturdy",
        recipe = {
            {"", c_cotton, ""},
            {"", c_cotton, ""},
            {"", c_cotton, ""},
        },
    })

end
