---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_ethereal_crafting = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_ethereal_crafting.init()

    return {
        description = "Adds additional x-shaped craft recipes to common minetest_game nodes",
        optional = {
            "dirt_dried",
            "dirt_ordinary",
            "gravel_ordinary",
            "ice_ordinary",
            "sand_desert",
            "sand_ordinary",
            "snow_ordinary",
            "stone_ordinary",
            "stone_sandstone_silver",
        },
    }

end

function unilib.pkg.override_ethereal_crafting.exec()

    if unilib.setting.mtgame_tweak_flag then

        -- N.B. The same craft recipe is already provided by "gravel_ordinary", but only when
        --      unilib.setting.underch_tweak_flag is set
        if unilib.global.pkg_executed_table["gravel_ordinary"] ~= nil and
                unilib.global.pkg_executed_table["stone_ordinary"] ~= nil and
                not unilib.setting.underch_tweak_flag then

            unilib.register_craft( {
                -- Adapted from ethereal-ng/extra.lua
                output = "unilib:gravel_ordinary 5",
                recipe = {
                    {"unilib:stone_ordinary_cobble", "", "unilib:stone_ordinary_cobble"},
                    {"", "unilib:stone_ordinary_cobble", ""},
                    {"unilib:stone_ordinary_cobble", "", "unilib:stone_ordinary_cobble"},
                },
            })

         end

        if unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil and
                unilib.global.pkg_executed_table["gravel_ordinary"] ~= nil then

            unilib.register_craft( {
                -- Adapted from ethereal-ng/extra.lua
                output = "unilib:dirt_ordinary 5",
                recipe = {
                    {"unilib:gravel_ordinary", "", "unilib:gravel_ordinary"},
                    {"", "unilib:gravel_ordinary", ""},
                    {"unilib:gravel_ordinary", "", "unilib:gravel_ordinary"},
                },
            })

        end

        if unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil and
                unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then

            unilib.register_craft( {
                -- Adapted from ethereal-ng/extra.lua
                output = "unilib:sand_ordinary 5",
                recipe = {
                    {"unilib:dirt_ordinary", "", "unilib:dirt_ordinary"},
                    {"", "unilib:dirt_ordinary", ""},
                    {"unilib:dirt_ordinary", "", "unilib:dirt_ordinary"},
                },
            })

        end

        if unilib.global.pkg_executed_table["ice_ordinary"] ~= nil and
                unilib.global.pkg_executed_table["snow_ordinary"] ~= nil then

            unilib.register_craft( {
                -- Adapted from ethereal-ng/extra.lua
                output = "unilib:snow_ordinary 20",
                recipe = {
                    {"unilib:ice_ordinary", "", "unilib:ice_ordinary"},
                    {"", "unilib:ice_ordinary", ""},
                    {"unilib:ice_ordinary", "", "unilib:ice_ordinary"},
                },
            })

        end

        if unilib.global.pkg_executed_table["dirt_dried"] ~= nil and
                unilib.global.pkg_executed_table["sand_desert"] ~= nil then

            unilib.register_craft( {
                -- Adapted from ethereal-ng/extra.lua
                output = "unilib:sand_desert 5",
                recipe = {
                    {"unilib:dirt_dried", "", "unilib:dirt_dried"},
                    {"", "unilib:dirt_dried", ""},
                    {"unilib:dirt_dried", "", "unilib:dirt_dried"},
                },
            })

        end

        if unilib.global.pkg_executed_table["stone_ordinary"] ~= nil and
                unilib.global.pkg_executed_table["stone_sandstone_silver"] ~= nil then

            unilib.register_craft( {
                -- Adapted from ethereal-ng/extra.lua
                output = "unilib:stone_sandstone_silver 5",
                recipe = {
                    {"unilib:stone_ordinary", "", "unilib:stone_ordinary"},
                    {"", "unilib:stone_ordinary", ""},
                    {"unilib:stone_ordinary", "", "unilib:stone_ordinary"},
                },
            })

        end

    end

end
