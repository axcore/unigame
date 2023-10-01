---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ice_hard = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ice_hard.init()

    return {
        description = "Hard ice bricks",
        -- "shared_snow" package provides the craft recipe
        depends = "shared_snow",
        optional = "ice_ordinary",
    }

end

function unilib.pkg.ice_hard.exec()

    unilib.register_node("unilib:ice_hard_brick", "snow:ice_brick", mode, {
        -- From snow:ice_brick
        description = S("Hard Ice Bricks"),
        tiles = {"unilib_ice_hard_brick.png"},
        -- N.B. puts_out_fire not in original code
        groups = {
            choppy = 1, cracky = 1, crumbly = 1, cools_lava = 1, melts = 1, puts_out_fire = 1,
            slippery = 3,
        },
        sounds = unilib.sound_table.ice,

        drawtype = "glasslike",
        liquidtype = "none",
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",

        on_construct = unilib.pkg.shared_snow.snow_onto_dirt,
    })
    unilib.register_stairs("unilib:ice_hard_brick")
    unilib.set_auto_rotate("unilib:ice_hard_brick", unilib.auto_rotate_brick_flag)

end

function unilib.pkg.ice_hard.post()

    if unilib.pkg_executed_table["ice_ordinary"] ~= nil then

        -- N.B. The original craft recipes clash with ones in the "ice_ordinary" package
        --[[
        unilib.register_craft({
            -- From snow:ice_brick
            output = "unilib:ice_hard_brick",
            recipe = {
                {"unilib:ice_ordinary", "unilib:ice_ordinary"},
                {"unilib:ice_ordinary", "unilib:ice_ordinary"},
            },
        })
        ]]--
        unilib.register_craft({
            -- From snow:ice_brick
            output = "unilib:ice_hard_brick",
            recipe = {
                {"unilib:ice_ordinary", "", "unilib:ice_ordinary"},
                {"", "group:craftable_bucket", ""},
                {"unilib:ice_ordinary", "", "unilib:ice_ordinary"},
            },
            replacements = unilib.craftable_bucket_list,
        })

    end

end
