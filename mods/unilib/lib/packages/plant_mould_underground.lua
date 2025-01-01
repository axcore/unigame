---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_mould_underground = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_mould_underground.init()

    return {
        description = "Underground mould",
    }

end

function unilib.pkg.plant_mould_underground.exec()

    local img = "unilib_plant_mould_underground.png"

    unilib.register_node("unilib:plant_mould_underground", "underch:mould", mode, {
        -- From underch:mould
        description = S("Underground Mould"),
        tiles = {img},
        -- N.B. moss = 1 not in original code
        groups = {moss = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "signlike",
        inventory_image = img,
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        walkable = false,
        selection_box = {
            type = "wallmounted",
        },
        wield_image = img,
    })
    unilib.register_craft({
        -- From underch:mould
        type = "fuel",
        recipe = "unilib:plant_mould_underground",
        burntime = 1,
    })

    unilib.register_decoration_spare("unilib:plant_mould_underground")

end
