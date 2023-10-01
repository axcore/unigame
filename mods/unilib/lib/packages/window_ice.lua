---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.window_ice = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.window_ice.init()

    return {
        description = "Ice window",
        depends = "ice_ordinary",
        optional = "item_sweeper",
    }

end

function unilib.pkg.window_ice.exec()

    unilib.register_node("unilib:window_ice", "mtg_plus:ice_window", mode, {
        -- From mtg_plus:ice_window
        description = S("Ice Window"),
        tiles = {"unilib_window_ice.png"},
        groups = {cools_lava = 1, cracky = 3, slippery = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From mtg_plus:ice_window
        type = "cooking",
        output = "unilib:window_ice",
        recipe = "unilib:ice_ordinary_tile",
        cooktime = 1,
    })

    if unilib.mtgame_tweak_flag and
            unilib.pkg_executed_table["item_sweeper"] ~= nil then

        unilib.register_craft({
            -- From mtg_plus:ice_window
            type = "shapeless",
            output = "unilib:window_ice",
            recipe = {"unilib:ice_ordinary_tile", "unilib:item_sweeper"},
        })

    end

end
