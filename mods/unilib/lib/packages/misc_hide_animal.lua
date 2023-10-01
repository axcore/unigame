---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_farming
-- Code:    MIT
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_hide_animal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_hide_animal.init()

    return {
        description = "Animal hide",
        depends = "wool_basic",
    }

end

function unilib.pkg.misc_hide_animal.exec()

    unilib.register_node("unilib:misc_hide_animal", "castle_farming:hides", mode, {
        -- From castle_farming:hides
        description = S("Animal Hide"),
        tiles = {"unilib_misc_hide_animal.png"},
        groups = {dig_immediate = 2},
        -- (no sounds)

        climbable = true,
        drawtype = "nodebox",
        inventory_image = "unilib_misc_hide_animal.png",
        node_box = {
            type = "wallmounted",
            wall_top    = {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
            wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
            wall_side   = {-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5},
        },
        paramtype = "light",
        paramtype2 = "wallmounted",
        walkable = false,
    })

end

function unilib.pkg.misc_hide_animal.post()

    unilib.register_craft({
        -- From castle_farming:hides
        type = "shapeless",
        output = "unilib:misc_hide_animal 6",
        recipe = {"unilib:wool_white", "group:craftable_bucket"},
        replacements = unilib.craftable_bucket_list,
    })

end
