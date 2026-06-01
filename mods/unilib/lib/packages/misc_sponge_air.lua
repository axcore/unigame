---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_sponge_air = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_sponge_air.init()

    return {
        description = "Sponge air barrier",
        notes = "Used by both normal and fiery sponges",
    }

end

function unilib.pkg.misc_sponge_air.exec()

    -- When a dry sponge is placed near water, surround it with "sponge" air nodes, displacing the
    --      existing water, and preventing new water from flowing in
    unilib.register_node("unilib:misc_sponge_air", "ethereal:sponge_air", mode, {
        -- From ethereal:sponge_air
        -- (no description)
        -- (no tiles)
        groups = {not_in_creative_inventory = 1},
        -- (no sounds)

        buildable_to = true,
        drawtype = "airlike",
        drop = "",
        paramtype = "light",
        pointable = false,
        sunlight_propagates = true,
        walkable = false,
    })
    -- We use leaf decay to remove the "sponge" air nodes
    unilib.register_leafdecay({
        -- From ethereal:sponge_air
        -- N.B. Only used with normal sponges in the original code
        trunks = {"unilib:misc_sponge_normal_wet", "unilib:misc_sponge_fiery_wet"},
        others = {"unilib:misc_sponge_air"},
        radius = 3,
    })

end
