---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_brush_water = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_brush_water.init()

    return {
        description = "Water brush",
        notes = "Can be used to clean up puddles (especially those that unilib was not able to" ..
                " remove automatically)",
        depends = "misc_puddle",
    }

end

function unilib.pkg.item_brush_water.exec()

    unilib.register_tool("unilib:item_brush_water", nil, mode, {
        -- Original to unilib
        description = unilib.utils.hint(
            S("Water Brush"), S("use on puddles")
        ),
        inventory_image = "unilib_item_brush_water.png",
        groups = {},
        -- (no sounds)

        liquids_pointable = false,
        stack_max = 1,
        wield_scale = {x = 1.5, y = 1.5, z = 0.5},

        on_use = function(itemstack, user, pointed_thing)

            if pointed_thing and pointed_thing.type == "node" then

                local node = core.get_node(pointed_thing.above)
                if node and core.get_item_group(node.name, "puddle") > 0 then

                    core.remove_node(pointed_thing.above)
                    core.sound_play(
                        "unilib_misc_puddle",
                        {pos = pos, gain = 1.0, max_hear_distance = 10}
                    )

                end

            end

            return itemstack

        end,
    })

end
