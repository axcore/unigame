---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_chain = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_chain.init()

    return {
        description = "Chain ladder",
        depends = "item_stick_iron",
    }

end

function unilib.pkg.ladder_chain.exec()

    unilib.register_node("unilib:ladder_chain", "darkage:chain", mode, {
        -- From darkage:chain
        description = S("Chain Ladder"),
        tiles = {"unilib_ladder_chain.png"},
        groups = {cracky = 2, oddly_breakable_by_hand = 2, snappy = 1},
        -- (no sounds)

        climbable = true,
        drawtype = "signlike",
        inventory_image = "unilib_ladder_chain.png",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        walkable = false,
        wield_image = "unilib_ladder_chain.png",
    })
    unilib.register_craft({
        -- From darkage:chain
        output = "unilib:ladder_chain 2",
        recipe = {
            {"unilib:item_stick_iron"},
            {"unilib:item_stick_iron"},
            {"unilib:item_stick_iron"},
        }
    })

end
