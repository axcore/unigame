---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_torchberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_torchberry.init()

    return {
        description = "Torchberry plant",
        notes = "Does not produce berries, but does produce light (and can be crafted into" ..
                " torches)",
        optional = {"item_stick_ordinary", "torch_ordinary"},
    }

end

function unilib.pkg.plant_torchberry.exec()

    local img = "unilib_plant_torchberry.png"

    unilib.register_node("unilib:plant_torchberry", "underch:torchberries", mode, {
        -- From underch:torchberries
        description = S("Torchberry Plant"),
        tiles = {img},
        groups = {flammable = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = img,
        light_source = 8,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -5 / 16, -6 / 16, 6 / 16, 0.5, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = img,

        -- N.B. Not in original code. Orientate the torchberry the right way, when placed manually
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.rotate_and_place(
                itemstack, placer, pointed_thing, {[0] = 1, 0, 3, 2, 5, 4}
            )

        end,
    })
    if unilib.global.pkg_executed_table["torch_ordinary"] ~= nil then

        if unilib.setting.underch_tweak_flag then

            unilib.register_craft({
                -- Original to unilib
                output = "unilib:torch_ordinary 4",
                recipe = {
                    {"unilib:plant_torchberry"},
                    {"group:stick"},
                },
            })

        elseif unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then

            unilib.register_craft({
                -- From underch:torchberries
                output = "unilib:torch_ordinary 4",
                recipe = {
                    {"unilib:plant_torchberry"},
                    {"unilib:item_stick_ordinary"},
                },
            })

        end

    end
    -- (not compatible with flowerpots)

    unilib.register_decoration_spare("unilib:plant_torchberry")

end
