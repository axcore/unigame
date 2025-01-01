---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ice_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.caverealms.add_mode

local falling_icicles_flag = true
local fall_chance = 0.33

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ice_blue.init()

    return {
        description = "Blue ice",
        notes = "Named as \"blue\" ice, because ethereal-ng already provides a \"thin\" ice",
        depends = "liquid_water_ordinary",
    }

end

function unilib.pkg.ice_blue.exec()

    unilib.register_node("unilib:ice_blue", "caverealms:thin_ice", mode, {
        -- From caverealms:thin_ice
        description = S("Blue Ice"),
        tiles = {"unilib_ice_blue.png"},
        -- N.B. cools_lava = 1, melts = 1, puts_out_fire = 1 and slippery = 3 not in original code
        groups = {cools_lava = 1, cracky = 3, melts = 1, puts_out_fire = 1, slippery = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike",
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
    })
    unilib.register_craft({
        -- From caverealms:thin_ice
        type = "shapeless",
        output = "unilib:liquid_water_ordinary_source",
        recipe = {"unilib:ice_blue"},
    })
    unilib.register_stairs("unilib:ice_blue")
    unilib.register_carvings("unilib:ice_blue", {
        millwork_flag = true,
    })

end
