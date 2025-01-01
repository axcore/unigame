---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- fire_generic.lua
--      Get generic fire definition
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function flood_flame(pos, _, newnode)

    -- Adapted from fire/init.lua
    -- Play flame extinguish sound if liquid is not an 'igniter'

    if core.get_item_group(newnode.name, "igniter") == 0 then

        core.sound_play(
            "unilib_extinguish_flame",
            {pos = pos, max_hear_distance = 16, gain = 0.15},
            true
        )

    end

    -- Remove the flame
    return false

end

---------------------------------------------------------------------------------------------------
-- Get generic fire definition
---------------------------------------------------------------------------------------------------

function unilib.fire._get_generic_definition()

    -- Adapted from fire/init.lua
    -- Returns a definition table, which the calling code can then customise before calling
    --      unilib.register_node()
    --
    -- Return values:
    --      The definition table described above

    return {
        -- (no description)
        tiles = {{
            name = "unilib_fire_ordinary_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1
            }}
        },
        groups = {dig_immediate = 3, fire = 1, igniter = 2},
        -- (no sounds)

        buildable_to = true,
        damage_per_second = 4,
        drawtype = "firelike",
        drop = "",
        floodable = true,
        inventory_image = "unilib_fire_ordinary.png",
        light_source = 13,
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,

        on_flood = flood_flame
    }

end
