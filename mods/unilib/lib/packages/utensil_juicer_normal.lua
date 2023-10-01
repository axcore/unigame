---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_juicer_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_juicer_normal.init()

    return {
        description = "Normal juicer",
    }

end

function unilib.pkg.utensil_juicer_normal.exec()

    unilib.register_craftitem("unilib:utensil_juicer_normal", "farming:juicer", mode, {
        -- From farming:juicer
        description = S("Normal Juicer"),
        inventory_image = "unilib_utensil_juicer_normal.png",
        groups = {flammable = 2, food_juicer = 1}
    })
    unilib.register_craft({
        -- From farming:juicer
        output = "unilib:utensil_juicer_normal",
        -- N.B. original code used "default:stone"
        recipe = {
            {"", "group:stone", ""},
            {"group:stone", "", "group:stone"}
        },
    })

end
