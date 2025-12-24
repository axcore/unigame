---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_block_honey = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_block_honey.init()

    return {
        description = "Decorative block of honey",
        depends = {"food_honey_normal", "misc_honeycomb_normal"},
    }

end

function unilib.pkg.decor_block_honey.exec()

    local c_honey = "unilib:food_honey_normal"
    local c_honeycomb = "unilib:misc_honeycomb_normal"

    unilib.register_node("unilib:decor_block_honey", "petz:honey_block", mode, {
        -- From petz:honey_block
        description = S("Block of Honey"),
        tiles =  {"unilib_decor_block_honey.png"},
        groups = {snappy = 2},
        sounds = unilib.global.sound_table.glass,

        drawtype = "nodebox",
        light_source = unilib.constant.light_max - 1,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-0.3125, -0.3125, -0.3125, 0.3125, 0.3125, 0.3125},
            },
        },
        param2 = 50,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "blend",
        walkable = true,
    })
    unilib.register_craft({
        -- Original to unimobs (petz did not any means to obtain this block)
        output = "unilib:decor_block_honey",
        type = "shaped",
        recipe = {
            {c_honeycomb, c_honey, c_honeycomb},
            {c_honey, c_honeycomb, c_honey},
            {c_honeycomb, c_honey, c_honeycomb},
        },
    })
    -- (The reverse recipe returns honeycomb, but not the honey "glue")
    unilib.register_craft({
        -- Original to unimobs
        output = c_honeycomb .. " 5",
        type = "shaped",
        recipe = {
            {"unilib:decor_block_honey"},
        },
    })

end
