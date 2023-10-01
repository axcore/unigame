---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ropes
-- Code:    MIT
-- Media:   unknown (textures), CC0 (sounds)
---------------------------------------------------------------------------------------------------

unilib.pkg.rope_mining = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ropes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rope_mining.init()

    return {
        description = "Mining rope",
        notes = "Creates the mining rope used by all mining rope spools",
        depends = "shared_ropes",
        optional = "rope_sturdy",
        suggested = {
            "crop_cotton",                      -- group:thread
        },
    }

end

function unilib.pkg.rope_mining.exec()

    unilib.register_node("unilib:rope_mining", "ropes:rope", mode, {
        -- From ropes:rope
        description = S("Mining Rope"),
        tiles = {
            "unilib_rope_mining_3.png",
            "unilib_rope_mining_3.png",
            "unilib_rope_mining_3.png",
            "unilib_rope_mining_3.png",
            "unilib_rope_mining_5.png",
            "unilib_rope_mining_5.png",
        },
        groups = {choppy = 2, flammable = 2, not_in_creative_inventory = 1},
        sounds = {
            footstep = {name = "unilib_rope_mining_creak", gain = 0.8, max_hear_distance = 6},
            dig = "__group",
            dug = "__group",
        },

        climbable = true,
        connect_sides = {"top"},
        connects_to = {"group:mining_rope"},
        drawtype = "nodebox",
        drop = "",
        node_box = {
            type = "connected",
            fixed = {-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
            connect_top = {-1/16, 1/2, -1/16, 1/16, 3/4, 1/16}
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,

        after_destruct = function(pos)

            unilib.pkg.shared_ropes.hanging_after_destruct(
                pos, "unilib:rope_mining", "unilib:rope_mining_bottom"
            )

        end,
    })

    unilib.register_node("unilib:rope_mining_bottom", "ropes:rope_bottom", mode, {
        -- From ropes:rope_bottom
        description = S("Mining Rope"),
        tiles = {
            "unilib_rope_mining_3.png",
            "unilib_rope_mining_3.png",
            "unilib_rope_mining_3.png",
            "unilib_rope_mining_3.png",
            "unilib_rope_mining_5.png",
            "unilib_rope_mining_5.png",
        },
        groups = {choppy = 2, flammable = 2, not_in_creative_inventory = 1},
        sounds = {
            footstep = {name = "unilib_rope_mining_creak", gain = 0.8, max_hear_distance = 6},
            dig = "__group",
            dug = "__group",
        },

        climbable = true,
        connects_to = {"group:mining_rope"},
        connect_sides = {"top"},
        drawtype = "nodebox",
        drop = "",
        node_box = {
            type = "connected",
            fixed = {
                {-1/16, -3/8, -1/16, 1/16, 1/2, 1/16},
                {-2/16, -5/16, -2/16, 2/16, -1/16, 2/16},
            },
            connect_top = {-1/16, 1/2, -1/16, 1/16, 3/4, 1/16}
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,

        after_destruct = function(pos)

            unilib.pkg.shared_ropes.hanging_after_destruct(
                pos, "unilib:rope_mining", "unilib:rope_mining_bottom"
            )

        end,

        on_construct = function(pos)

            local timer = minetest.get_node_timer(pos)
            timer:start(1)

        end,

        on_timer = unilib.pkg.shared_ropes.make_rope_on_timer("unilib:rope_mining"),
    })

    unilib.register_craftitem("unilib:rope_mining_segment", "ropes:ropesegment", mode, {
        -- From ropes:ropesegment
        description = S("Mining Rope Segment"),
        groups = {vines = 1},
        inventory_image = "unilib_rope_mining_segment.png",
    })
    -- N.B. group:thread is provided by unilib:crop_cotton_harvest
    --[[
    unilib.register_craft({
        -- From ropes:ropesegment
        output = "unilib:rope_mining_segment",
        recipe = {
            {"unilib:crop_cotton_harvest", "unilib:crop_cotton_harvest"},
            {"unilib:crop_cotton_harvest", "unilib:crop_cotton_harvest"},
            {"unilib:crop_cotton_harvest", "unilib:crop_cotton_harvest"},
        },
    })
    ]]--
    minetest.register_craft({
        -- From ropes:ropesegment
        output = "unilib:rope_mining_segment",
        recipe = {
            {"group:thread", "group:thread"},
            {"group:thread", "group:thread"},
            {"group:thread", "group:thread"},
        },
    })
    if unilib.pkg_executed_table["rope_sturdy"] then

        unilib.register_craft({
            -- From ropes:ropesegment
            output = "unilib:rope_mining_segment",
            recipe = {
                {"unilib:rope_sturdy"},
                {"unilib:rope_sturdy"},
            },
        })

    end
    unilib.register_craft({
        -- From ropes:ropesegment
        type = "fuel",
        recipe = "unilib:rope_mining_segment",
        -- (The same value used in the "shared_ropes_spools" package)
        burntime = 6,
    })

end
