---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.vine_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vine_jungle.init()

    return {
        description = "Vine found on exotic jungle trees",
    }

end

function unilib.pkg.vine_jungle.exec()

    unilib.register_node("unilib:vine_jungle", "mapgen:vine", mode, {
        -- From farlands, mapgen:vine
        description = S("Jungle Vine"),
        tiles = {
            "blank.png",
            "blank.png",
            "blank.png",
            "blank.png",
            "unilib_vine_jungle.png",
            "unilib_vine_jungle.png",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 1},
        -- (no sounds)

        climbable = true,
        drawtype = "nodebox",
        drop = "unilib:vine_jungle",
        inventory_image = "unilib_vine_jungle.png",
        -- N.B. is_ground_content = false not in original code; added to match other vine packages
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 0.5, 0.5, 0.5, 0.48},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = false,
        use_texture_alpha = "clip",
        walkable = false,
    })

end
