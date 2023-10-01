---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    gravelcraft
-- Code:    MIT
-- Media:   n/a
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.gravel_ordinary = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local mtg_plus_add_mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.gravel_ordinary.init()

    return {
        description = "Ordinary gravel",
        depends = "mineral_flint",
    }

end

function unilib.pkg.gravel_ordinary.exec()

    unilib.register_node("unilib:gravel_ordinary", "default:gravel", default_add_mode, {
        -- From default:gravel
        description = S("Ordinary Gravel"),
        tiles = {"unilib_gravel_ordinary.png"},
        groups = {crumbly = 2, falling_node = 1},
        sounds = unilib.sound_table.gravel,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:mineral_flint_lump"}, rarity = 16},
                {items = {"unilib:gravel_ordinary"}},
            },
        },
    })
    if unilib.mtgame_tweak_flag then

        if unilib.underch_tweak_flag then

            unilib.register_craft({
                -- Adapted from gravelcraft/init.lua
                output = "unilib:gravel_ordinary 5",
                recipe = {
                    {"group:cobble", "","group:cobble"},
                    {"", "group:cobble", ""},
                    {"group:cobble", "","group:cobble"},
                },
            })

        end

        unilib.register_node(
            -- From mtg_plus:gravel_cobble
            "unilib:gravel_ordinary_cobble",
            "mtg_plus:gravel_cobble",
            mtg_plus_add_mode,
            {
                description = S("Cobbled Ordinary Gravel"),
                tiles = {"unilib_gravel_ordinary_cobble.png"},
                groups = {cracky = 3, stone = 1},
                sounds = unilib.sound_table.stone,

                is_ground_content = false,
            }
        )
        -- N.B. Original craft recipe conflicts with recipe in "stone_conglomerate_normal" package
        --[[
        unilib.register_craft({
            -- From mtg_plus:gravel_cobble
            output = "unilib:gravel_ordinary_cobble 2",
            recipe = {
                {"unilib:gravel_ordinary", "unilib:gravel_ordinary"},
                {"unilib:gravel_ordinary", "unilib:gravel_ordinary"},
            },
        })
        ]]--
        unilib.register_craft({
            -- From mtg_plus:gravel_cobble
            output = "unilib:gravel_ordinary_cobble",
            recipe = {
                {"unilib:gravel_ordinary", "unilib:gravel_ordinary"},
            },
        })
        unilib.register_craft({
            -- From mtg_plus:gravel_cobble
            type = "cooking",
            output = "unilib:gravel_ordinary",
            recipe = "unilib:gravel_ordinary_cobble",
        })
        unilib.register_stairs("unilib:gravel_ordinary_cobble")
        unilib.register_wall({
            -- From mtg_plus:wall_gravel_cobble
            orig_name = "mtg_plus:wall_gravel_cobble",
            ingredient = "unilib:gravel_ordinary_cobble",

            replace_mode = mtg_plus_add_mode,
            description = S("Cobbled Ordinary Gravel Wall"),
            sound_name = "stone",
            img_list = {"unilib_gravel_ordinary_cobble.png"},
        })

    end

end
