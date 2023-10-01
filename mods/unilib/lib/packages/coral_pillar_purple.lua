---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_pillar_purple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_pillar_purple.init()

    return {
        description = "Purple coral pillar",
        notes = "This node is processor-intensive, and should be used very sparingly",
        depends = {"coral_block_skeleton", "shared_coral_pillar"},
    }

end

function unilib.pkg.coral_pillar_purple.exec()

    unilib.register_node("unilib:coral_pillar_purple", nil, mode, {
        -- Original to unilib, adapted from lib_ecology:plant_coral_pillar
        description = S("Purple Coral Pillar"),
        tiles = {"unilib_coral_pillar_purple.png"},
        groups = {cracky = 3, stone = 1, sea = 1},
        sounds = unilib.sound_table.stone,

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
    })

end
