---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_petz_lantern = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_petz_lantern.init()

    return {
        description = "Adds additional craft recipes for various Jack-o'-lanterns",
        depends = "candle_beeswax",
        optional = {
            "light_lantern_jack_yellow",
            "light_lantern_jack_green",
            "light_lantern_jack_red",
            "plant_pumpkin_red_wild",
            "plant_watermelon_wild",
            "produce_pumpkin_yellow",
        },
    }

end

function unilib.pkg.override_petz_lantern.exec()

    if unilib.global.pkg_executed_table["light_lantern_jack_yellow"] ~= nil and
            unilib.global.pkg_executed_table["produce_pumpkin_yellow"] ~= nil then

        unilib.register_craft({
            -- Adapted from petz/petz/misc/nodes.lua
            output = "unilib:light_lantern_jack_yellow_off",
            recipe = {
                {"unilib:candle_beeswax"},
                {"unilib:produce_pumpkin_yellow_harvest"},
            },
        })

    end

    if unilib.global.pkg_executed_table["light_lantern_jack_green"] ~= nil and
            unilib.global.pkg_executed_table["plant_watermelon_wild"] ~= nil then

        unilib.register_craft({
            -- Original to unimobs
            output = "unilib:light_lantern_jack_green_off",
            recipe = {
                {"unilib:candle_beeswax"},
                {"unilib:plant_watermelon_wild"},
            },
        })

    end

    if unilib.global.pkg_executed_table["light_lantern_jack_red"] ~= nil and
            unilib.global.pkg_executed_table["plant_pumpkin_red_wild"] ~= nil then

        unilib.register_craft({
            -- Original to unimobs
            output = "unilib:light_lantern_jack_red_off",
            recipe = {
                {"unilib:candle_beeswax"},
                {"unilib:plant_pumpkin_red_wild"},
            },
        })

    end

end
