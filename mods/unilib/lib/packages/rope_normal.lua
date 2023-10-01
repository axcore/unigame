---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.rope_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rope_normal.init()

    return {
        description = "Normal rope",
        depends = "grass_jungle",
    }

end

function unilib.pkg.rope_normal.exec()

    unilib.register_node("unilib:rope_normal", "moreblocks:rope", mode, {
        -- From moreblocks:rope
        description = S("Normal Rope"),
        tiles = {"unilib_rope_normal.png"},
        -- (no tiles)
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.sound_table.leaves,

        climbable = true,
        drawtype = "signlike",
        inventory_image = "unilib_rope_normal.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {type = "wallmounted"},
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_rope_normal.png",
    })
    unilib.register_craft({
        -- From moreblocks:rope
        output = "unilib:rope_normal 3",
        recipe = {
            {"unilib:grass_jungle"},
            {"unilib:grass_jungle"},
            {"unilib:grass_jungle"},
        }
    })

end
