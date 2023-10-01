---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_sakura = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_sakura.init()

    return {
        description = "Sakura wood door",
        depends = {"item_paper_ordinary", "tree_sakura"},
    }

end

function unilib.pkg.door_wood_sakura.exec()

    unilib.register_door({
        -- From etheral:door_sakura. Creates unilib:door_wood_sakura
        part_name = "wood_sakura",
        orig_name = {
            "ethereal:door_sakura_a",
            "ethereal:door_sakura_b",
            "ethereal:door_sakura_c",
            "ethereal:door_sakura_d",
        },
        def_table = {
            description = S("Sakura Wood Door"),
            tiles = {{name = "unilib_door_sakura.png", backface_culling = true}},
            groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 2, snappy = 1},
            -- (no sounds)

            inventory_image = "unilib_door_sakura_inv.png",
            recipe = {
                {"group:stick", "unilib:item_paper_ordinary"},
                {"unilib:item_paper_ordinary", "group:stick"},
                {"unilib:tree_sakura_wood", "unilib:tree_sakura_wood"},
            },
            sound_open = "unilib_glass_door_open",
            sound_close = "unilib_glass_door_close",
        },

        replace_mode = mode,
        orig_craftitem_name = "ethereal:door_sakura",
    })

end
