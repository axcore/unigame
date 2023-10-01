---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.trapdoor_ice = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.trapdoor_ice.init()

    return {
        description = "Ice trapdoor",
        depends = {"ice_ordinary", "snow_ordinary"},
    }

end

function unilib.pkg.trapdoor_ice.exec()

    unilib.register_trapdoor({
        -- From mtg_plus:trapdoor_ice. Creates unilib:trapdoor_ice
        part_name = "ice",
        orig_name = {"mtg_plus:trapdoor_ice", "mtg_plus:trapdoor_ice_open"},
        def_table = {
            description = S("Ice Trapdoor"),
            -- (no tiles)
            groups = {cracky = 3, door = 1, slippery = 3},
            sounds = unilib.sound_table.glass,

            inventory_image = "unilib_trapdoor_ice.png",
            sound_close = "unilib_ice_door_close",
            sound_open = "unilib_ice_door_open",
            tile_front = "unilib_trapdoor_ice.png",
            tile_side = "unilib_trapdoor_ice_side.png",
            wield_image = "unilib_trapdoor_ice.png",
        },

        replace_mode = mode,
    })
    -- N.B. Original craft recipe conflicts with recipe in "pane_ice_ordinary" package
    --[[
    unilib.register_craft({
        -- From mtg_plus:trapdoor_ice
        output = "unilib:trapdoor_ice 2",
        recipe = {
            {"unilib:ice_ordinary", "unilib:ice_ordinary", "unilib:ice_ordinary"},
            {"unilib:ice_ordinary", "unilib:ice_ordinary", "unilib:ice_ordinary"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From mtg_plus:trapdoor_ice
        output = "unilib:trapdoor_ice 2",
        recipe = {
            {"unilib:ice_ordinary", "unilib:ice_ordinary", "unilib:ice_ordinary"},
            {"unilib:ice_ordinary", "unilib:snow_ordinary", "unilib:ice_ordinary"},
        },
    })

end
