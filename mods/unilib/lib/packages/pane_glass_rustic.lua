---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_rustic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_rustic.init()

    return {
        description = "Rustic glass panes",
        depends = "glass_ordinary",
    }

end

function unilib.pkg.pane_glass_rustic.exec()

    unilib.register_node("unilib:pane_glass_rustic", "cottages:glass_pane", mode, {
        -- From cottages:glass_pane
        description = unilib.utils.brackets(S("Rustic Glass Pane"), S("Centred")),
        tiles = {"unilib_pane_glass_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.glass,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.05, 0.5, 0.5, 0.05},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.05, 0.5, 0.5, 0.05},
            },
        },
        use_texture_alpha = "clip",
    })
    -- N.B. Original craft recipe conflicts with recipe in "glass_framed_wood_connecting" package
    --[[
    unilib.register_craft({
        -- From cottages:glass_pane
        output = "unilib:pane_glass_rustic 4",
        recipe = {
            {"group:stick", "group:stick", "group:stick"},
            {"group:stick", "unilib:glass_ordinary", "group:stick"},
            {"group:stick", "group:stick", "group:stick"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From cottages:glass_pane
        output = "unilib:pane_glass_rustic 4",
        recipe = {
            {"group:stick", "", "group:stick"},
            {"group:stick", "unilib:glass_ordinary", "group:stick"},
            {"group:stick", "", "group:stick"},
        },
    })
    unilib.register_craft({
        -- From cottages:glass_pane
        output = "unilib:pane_glass_rustic",
        recipe = {
            {"unilib:pane_glass_rustic_side"},
        },
    })

    unilib.register_node("unilib:pane_glass_rustic_side", "cottages:glass_pane_side", mode, {
        -- From cottages:glass_pane_side
        description = unilib.utils.brackets(S("Rustic Glass Pane"), S("Off-Centre")),
        tiles = {"unilib_pane_glass_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.glass,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.40, 0.5, 0.5, -0.50},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.40, 0.5, 0.5, -0.50},
            },
        },
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From cottages:glass_pane_side
        output = "unilib:pane_glass_rustic_side",
        recipe = {
            {"unilib:pane_glass_rustic"},
        },
    })

end
