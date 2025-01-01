---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_milk_round = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_milk_round.init()

    return {
        description = "Milky round glass",
        notes = "Can be coloured using dyes, or with an airbrush (if the unifieddyes mod is" ..
                " available). No pane equivalents exist, because panes and uniffieddyes both try" ..
                " to use .param2",
        mod_optional = "unifieddyes",
        depends = {"dye_basic", "glass_clean_round"},
    }

end

function unilib.pkg.glass_milk_round.exec()

    local hint = S("can be coloured with dyes")
    if unilib.setting.unifieddyes_update_flag then
        hint = S("can be coloured using a dye airbrush")
    end

    unilib.dyes.register_node_with_dye(
        -- From darkage:milk_glass_round
        "unilib:glass_milk_round",
        "darkage:milk_glass_round",
        mode,
        {
            description = unilib.utils.hint(S("Milky Round Glass"), hint),
            tiles = {"unilib_glass_milk_round.png"},
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.glass,

            drawtype = "glasslike",
            -- N.B. is_ground_content = false not in original code; added to match other glass items
            is_ground_content = false,
            paramtype = "light",
            sunlight_propagates = true,
            use_texture_alpha = "blend",
        }
    )
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
        },
    })

end
