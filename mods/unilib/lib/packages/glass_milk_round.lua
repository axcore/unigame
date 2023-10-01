---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_milk_round = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_milk_round.init()

    return {
        description = "Milky round glass",
        notes = "Requires the unifieddyes mod so that it can be dyed with an airbrush. No pane" ..
                " equivalents exist,because panes and uniffieddyes both try to use .param2",
        mod_optional = "unifieddyes",
        depends = {"dye_basic", "glass_clean_round"},
    }

end

function unilib.pkg.glass_milk_round.exec()

    if unilib.unifieddyes_update_flag then

        unilib.register_node_with_dye("unilib:glass_milk_round", "darkage:milk_glass_round", mode, {
            -- From darkage:milk_glass_round
            description = unilib.hint(
                S("Milky Round Glass"), S("can be used with a dye airbrush")
            ),
            tiles = {"unilib_glass_milk_round.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.sound_table.glass,

            drawtype = "glasslike",
            paramtype = "light",
            sunlight_propagates = true,
            use_texture_alpha = "blend",
        })
        unilib.register_craft({
            -- From darkage:milk_glass_round
            type = "shapeless",
            output = "unilib:glass_milk_round",
            recipe = {"unilib:glass_clean_round", "unilib:dye_white"},
        })
        unilib.register_craft({
            -- From darkage:milk_glass_round
            output = "unilib:glass_clean_round",
            recipe = {
                {"unilib:glass_milk_round"},
            }
        })

    end

end
