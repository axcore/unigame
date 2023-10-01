---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_milk_rhombus = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_milk_rhombus.init()

    return {
        description = "Milky rhombus glass",
        notes = "Requires the unifieddyes mod so that it can be dyed with an airbrush. No pane" ..
                " equivalents exist,because panes and uniffieddyes both try to use .param2",
        mod_optional = "unifieddyes",
        depends = {"dye_basic", "glass_clean_rhombus"},
    }

end

function unilib.pkg.glass_milk_rhombus.exec()

    if unilib.unifieddyes_update_flag then

        unilib.register_node_with_dye("unilib:glass_milk_rhombus", "darkage:milk_glass", mode, {
            -- From darkage:milk_glass
            description = unilib.hint(
                S("Milky Rhombus Glass"), S("can be used with a dye airbrush")
            ),
            tiles = {"unilib_glass_milk_rhombus.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.sound_table.glass,

            drawtype = "glasslike",
            paramtype = "light",
            sunlight_propagates = true,
            use_texture_alpha = "blend",
        })
        unilib.register_craft({
            -- From darkage:milk_glass
            type = "shapeless",
            output = "unilib:glass_milk_rhombus",
            recipe = {"unilib:glass_clean_rhombus", "unilib:dye_white"}
        })
        unilib.register_craft({
            -- From darkage:milk_glass
            output = "unilib:glass_clean_rhombus",
            recipe = {
                {"unilib:glass_milk_rhombus"},
            }
        })

    end

end
