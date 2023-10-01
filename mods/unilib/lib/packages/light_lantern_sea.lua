---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_sea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_sea.init()

    return {
        description = "Sea Lantern",
        depends = {"glass_ordinary", "torch_ordinary"},
    }

end

function unilib.pkg.light_lantern_sea.exec()

    unilib.register_node("unilib:light_lantern_sea", "xocean:sea_lantern", mode, {
        -- From xocean:sea_lantern
        description = S("Sea Lantern"),
        tiles = {"unilib_light_lantern_sea.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        light_source = 14,
        paramtype = "light",
        sunlight_propagates = true,
    })

end

function unilib.pkg.light_lantern_sea.post()

    -- N.B. This is a sea lantern, so only use ordinary water in the craft recipe

    for bucket_type, _ in pairs(unilib.generic_bucket_table) do

        local c_water_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        unilib.register_craft({
            -- From xocean:sea_lantern
            output = "unilib:light_lantern_sea 4",
            recipe = {
                {"unilib:torch_ordinary", "unilib:glass_ordinary", "unilib:torch_ordinary"},
                {"unilib:glass_ordinary", c_water_bucket, "unilib:glass_ordinary"},
                {"unilib:torch_ordinary", "unilib:glass_ordinary", "unilib:torch_ordinary"},
            },
            replacements = {
                {c_water_bucket, c_empty_bucket},
            },
        })

    end

end
