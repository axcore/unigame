---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.rope_flax = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rope_flax.init()

    return {
        description = "Flax rope",
        depends = "plant_flax_antipodean",
    }

end

function unilib.pkg.rope_flax.exec()

    unilib.register_node("unilib:rope_flax", "aotearoa:flax_rope", mode, {
        -- From aotearoa:flax_rope
        description = S("Flax Rope"),
        tiles = {"unilib_rope_flax.png"},
        groups = {flammable = 2, oddly_breakable_by_hand = 3, snappy = 3},
        sounds = unilib.sound_table.leaves,

        climbable = true,
        drawtype = "signlike",
        inventory_image = "unilib_rope_flax.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_rope_flax.png",
    })
    unilib.register_craft({
        -- From aotearoa:flax_rope
        output = "unilib:rope_flax 3",
        recipe = {
            {"unilib:plant_flax_antipodean"},
            {"unilib:plant_flax_antipodean"},
            {"unilib:plant_flax_antipodean"},
        },
    })

end
