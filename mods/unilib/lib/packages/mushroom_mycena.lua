---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_mycena = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.caverealms.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_mycena.init()

    return {
        description = "Mycena mushroom",
    }

end

function unilib.pkg.mushroom_mycena.exec()

    unilib.register_node("unilib:mushroom_mycena", "caverealms:mycena", mode, {
        -- From caverealms:mycena
        description = S("Mycena Mushroom"),
        tiles = {"unilib_mushroom_mycena.png"},
        -- N.B. attached_node = 1, mushroom = 1 not in original code
        groups = {attached_node = 1, mushroom = 1, oddly_breakable_by_hand = 3},
        -- (no sounds)

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_mycena.png",
        is_ground_content = true,
        light_source = 6,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        visual_scale = 1.0,
        walkable = false,
        wield_image = "unilib_mushroom_mycena.png",
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_mycena", "caverealms:mycena")

    unilib.register_craftitem("unilib:mushroom_mycena_powder", "caverealms:mycena_powder", mode, {
        -- From caverealms:mycena_powder
        description = S("Mycena Mushroom Powder"),
        inventory_image = "unilib_mushroom_mycena_powder.png",
    })
    unilib.register_craft({
        -- From caverealms:mycena_powder
        type = "shapeless",
        output = "unilib:mushroom_mycena_powder",
        recipe = {"unilib:mushroom_mycena"},
    })

end
