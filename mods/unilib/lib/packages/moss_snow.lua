---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_snow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_snow.init()

    return {
        description = "Snow moss",
        notes = "Produced when digging ordinary snow (as long as the override in the" ..
                " \"override_snow\" package has been applied). Can also be crafted from frozen" ..
                " pine leaves",
        optional = {"stone_ordinary", "tree_pine_frozen"},
    }

end

function unilib.pkg.moss_snow.exec()

    unilib.register_node("unilib:moss_snow", "snow:moss", mode, {
        -- From snow:moss
        description = S("Snow Moss"),
        tiles = {"unilib_moss_snow.png"},
        -- N.B. moss = 1 not in original code
        groups = {attached_node = 1, crumbly = 3, moss = 1},
        -- (no sounds)

        drawtype = "signlike",
        furnace_burntime = 3,
        inventory_image = "unilib_moss_snow.png",
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        walkable = false,
    })
    if unilib.global.pkg_executed_table["tree_pine_frozen"] ~= nil then

        unilib.register_craft({
            -- From snow:moss
            output = "unilib:moss_snow",
            recipe = {
                {"unilib:tree_pine_frozen_leaves", "unilib:tree_pine_frozen_leaves"},
                {"unilib:tree_pine_frozen_leaves", "unilib:tree_pine_frozen_leaves"},
            },
        })

    end

end
