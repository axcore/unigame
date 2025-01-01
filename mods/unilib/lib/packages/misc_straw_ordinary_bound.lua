---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_farming
-- Code:    MIT
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_straw_ordinary_bound = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_straw_ordinary_bound.init()

    return {
        description = "Bound ordinary straw",
        depends = "misc_straw_ordinary",
        at_least_one = {"crop_cotton", "rope_mining"},
    }

end

function unilib.pkg.misc_straw_ordinary_bound.exec()

    unilib.register_node("unilib:misc_straw_ordinary_bound", "castle_farming:bound_straw", mode, {
        -- From castle_farming:bound_straw
        description = S("Bound Ordinary Straw"),
        tiles = {"unilib_misc_straw_ordinary_bound.png"},
        groups = {choppy = 4, flammable = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "normal",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
    })
    if unilib.global.pkg_executed_table["rope_mining"] ~= nil then

        unilib.register_craft({
            -- From castle_farming:bound_straw
            type = "shapeless",
            output = "unilib:misc_straw_ordinary_bound 6",
            recipe = {
                "unilib:misc_straw_ordinary",
                "unilib:misc_straw_ordinary",
                "unilib:misc_straw_ordinary",
                "unilib:misc_straw_ordinary",
                "unilib:misc_straw_ordinary",
                "unilib:misc_straw_ordinary",
                "unilib:rope_mining_segment",
            },
        })

    end
    if unilib.global.pkg_executed_table["crop_cotton"] ~= nil then

        unilib.register_craft({
            -- From castle_farming:bound_straw
            type = "shapeless",
            output = "unilib:misc_straw_ordinary_bound",
            recipe = {"unilib:misc_straw_ordinary", "unilib:crop_cotton_harvest"},
        })

    end
    unilib.register_craft({
        -- From castle_farming:bound_straw
        type = "fuel",
        recipe = "unilib:misc_straw_ordinary_bound",
        burntime = 10,
    })

end
