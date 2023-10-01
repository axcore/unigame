---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.hedge_decorative_light = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hedge_decorative_light.init()

    return {
        description = "Light decorative hedge",
        notes = "ethereal-ng creates leaf blocks that are taller than normal blocks." ..
                " Apparently, this item have been provided to fill the space of a normal" ..
                " blockso these; it doesn't resemble any other hedges",
        depends = "tree_aspen",
    }

end

function unilib.pkg.hedge_decorative_light.exec()

    unilib.register_node("unilib:hedge_decorative_light", "ethereal:bush2", mode, {
        -- From ethereal:bush2
        description = S("Light Decorative Hedge"),
        tiles = {"unilib_tree_aspen_leaves.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "allfaces_optional",
        paramtype = "light",
        walkable = true,
    })
    unilib.register_craft({
        -- From ethereal:bush2
        output = "unilib:hedge_decorative_light",
        recipe = {
            {"group:leaves", "group:leaves", "group:leaves"},
            {"group:leaves", "unilib:tree_aspen_leaves", "group:leaves"},
            {"group:leaves", "group:leaves", "group:leaves"}
        }
    })
    unilib.register_craft({
        -- From ethereal:bush2
        type = "fuel",
        recipe = "unilib:hedge_decorative_light",
        burntime = 1,
    })

end
