---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.vine_jungle_knotted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vine_jungle_knotted.init()

    return {
        description = "Knotted jungle vine",
    }

end

function unilib.pkg.vine_jungle_knotted.exec()

    unilib.register_node("unilib:vine_jungle_knotted", "lib_ecology:plant_vine_01", mode, {
        -- From GLEMr4, lib_ecology:plant_vine_01
        description = S("Knotted Jungle Vine"),
        tiles = {"unilib_vine_jungle_knotted.png"},
        groups = {choppy = 3, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.leaves,

        climbable = true,
        -- N.B. drawtype = "signlike" in original code
        drawtype = "nodebox",
        floodable = true,
        inventory_image = "unilib_vine_jungle_knotted.png",
        is_ground_content = false,
        -- N.B. no node_box in original code
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 0.5, 0.5, 0.5, 0.48},
            },
        },
        paramtype = "light",
        -- N.B. paramtype2 = "wallmounted" in original code
        paramtype2 = "facedir",
        -- N.B. removed selection_box from original code
        --[[
        selection_box = {
            type = "wallmounted",
        },
        ]]--
        use_texture_alpha = "clip",
        walkable = false,
        waving = 1,
        wield_image = "unilib_vine_jungle_knotted.png",
    })

end
