---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_underground = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_underground.init()

    return {
        description = "Underground moss",
    }

end

function unilib.pkg.moss_underground.exec()

    local img = "unilib_moss_underground.png"

    unilib.register_node("unilib:moss_underground", "underch:moss", mode, {
        -- From underch:moss
        description = S("Underground Moss"),
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
        selection_box = {
            type = "wallmounted",
        },
        walkable = false,
        wield_image = img,
    })
    unilib.register_craft({
        -- From underch:moss
        type = "fuel",
        recipe = "unilib:moss_underground",
        burntime = 2,
    })

end
