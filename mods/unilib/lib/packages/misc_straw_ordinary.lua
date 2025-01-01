---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_straw_ordinary = {}

local S = unilib.intllib
local darkage_add_mode = unilib.global.imported_mod_table.darkage.add_mode
local farming_add_mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_straw_ordinary.init()

    return {
        description = "Ordinary straw",
        depends = "crop_wheat",
    }

end

function unilib.pkg.misc_straw_ordinary.exec()

    local c_wheat = "unilib:crop_wheat_harvest"

    unilib.register_node("unilib:misc_straw_ordinary", "farming:straw", farming_add_mode, {
        -- From farming:straw
        description = S("Ordinary Straw"),
        tiles = {"unilib_misc_straw_ordinary.png"},
        -- ("hay" group from the cottages mod)
        groups = {fall_damage_add_percent = -30, flammable = 4, hay = 3, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From farming:straw
        output = "unilib:misc_straw_ordinary 3",
        recipe = {
            {c_wheat, c_wheat, c_wheat},
            {c_wheat, c_wheat, c_wheat},
            {c_wheat, c_wheat, c_wheat},
        },
    })
    unilib.register_craft({
        -- From farming:straw
        output = c_wheat .. " 3",
        recipe = {
            {"unilib:misc_straw_ordinary"},
        },
    })
    -- Notes from default:
    -- Registered before the stairs so the stairs get fuel recipes
    unilib.register_craft({
        -- From farming:straw
        type = "fuel",
        recipe = "unilib:misc_straw_ordinary",
        burntime = 3,
    })
    unilib.register_stairs("unilib:misc_straw_ordinary")

    if unilib.setting.mtgame_tweak_flag then

        unilib.register_node(
            -- From darkage:straw_bale
            "unilib:misc_straw_ordinary_bale",
            "darkage:straw_bale",
            darkage_add_mode,
            {
                description = "Ordinary Straw Bale",
                tiles = {"unilib_misc_straw_ordinary_bale.png"},
                -- ("hay" group from the cottages mod)
                groups = {flammable = 2, hay = 3, snappy = 2},
                sounds = unilib.global.sound_table.leaves,

                drop = "unilib:misc_straw_ordinary 4",
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From darkage:straw_bale
            output = "unilib:misc_straw_ordinary_bale",
            recipe = {
                {"unilib:misc_straw_ordinary", "unilib:misc_straw_ordinary"},
                {"unilib:misc_straw_ordinary", "unilib:misc_straw_ordinary"},
            },
        })
        unilib.register_stairs("unilib:misc_straw_ordinary_bale", {
            drop_name = "unilib:misc_straw_ordinary",
        })

    end

end
