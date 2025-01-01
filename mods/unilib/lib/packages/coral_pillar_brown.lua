---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_pillar_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_pillar_brown.init()

    return {
        description = "Brown coral pillar",
        notes = "This node is processor-intensive, and should be used sparingly",
        depends = {"coral_block_skeleton", "shared_coral_pillar"},
    }

end

function unilib.pkg.coral_pillar_brown.exec()

    unilib.register_node("unilib:coral_pillar_brown", nil, mode, {
        -- Original to unilib, adapted from lib_ecology:plant_coral_pillar
        description = S("Brown Coral Pillar"),
        tiles = {"unilib_coral_pillar_brown.png"},
        groups = {coral = 1, cracky = 3, stone = 1, sea = 1},
        sounds = unilib.global.sound_table.stone,

        drawtype = "nodebox",
        drop = "unilib:coral_block_skeleton",
        light_source = 2,
        node_box = {
            type = "fixed",
            fixed = unilib.pkg.shared_coral_pillar.node_box_table,
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        },

        -- N.B. No .on_place() in original code
        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {need_under = "group:sand"}
            )

        end,
    })

end
