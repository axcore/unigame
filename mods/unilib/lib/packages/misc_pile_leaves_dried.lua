---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_pile_leaves_dried = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_pile_leaves_dried.init()

    return {
        description = "Pile of dried leaves",
    }

end

function unilib.pkg.misc_pile_leaves_dried.exec()

    local inv_img = unilib.flora.filter_leaves_img("unilib_misc_pile_leaves_dried.png")
    unilib.register_node("unilib:misc_pile_leaves_dried", "darkage:dry_leaves", mode, {
        -- From darkage:dry_leaves
        description = S("Pile of Dried Leaves"),
        tiles = {"unilib_misc_pile_leaves_dried.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        inventory_image = inv_img,
        is_ground_content = false,
        paramtype = "light",
        wield_img = inv_img,
    })
    -- (In the original code, "default:leaves" was used as the recipe)
    unilib.register_craft({
        -- From darkage:dry_leaves
        type = "cooking",
        output = "unilib:misc_pile_leaves_dried",
        recipe = "group:leaves",
    })

    -- This package provides deliberate craft recipe conflicts
    unilib.register_craft_conflicts({
        {"unilib:misc_pile_leaves_dried", "unilib:food_shoots_cabbage_cooked"},
        {"unilib:misc_pile_leaves_dried", "unilib:food_fiddlehead_cooked"},
    })

end
