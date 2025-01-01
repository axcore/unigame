---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_rainbow
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_block_rainbow_glass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_rainbow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_block_rainbow_glass.init()

    return {
        description = "Glass rainbow block",
        depends = "glass_ordinary",
        at_least_one = {"decor_block_rainbow_stone", "misc_nyancat"},
    }

end

function unilib.pkg.decor_block_rainbow_glass.exec()

    local c_glass = "unilib:glass_ordinary"

    unilib.register_node("unilib:decor_block_rainbow_glass", "xtraores_rainbow:glass", mode, {
        -- From xtraores_rainbow:glass
        description = S("Glass Rainbow Block"),
        tiles = {"unilib_decor_block_rainbow_glass.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike",
        is_ground_content = false,
        light_source = unilib.constant.light_max,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    if unilib.global.pkg_executed_table["decor_block_rainbow_stone"] ~= nil then

        unilib.register_craft({
            -- From xtraores_rainbow:glass
            output = "unilib:decor_block_rainbow_glass 8",
            recipe = {
                {"", c_glass, ""},
                {c_glass, "unilib:decor_block_rainbow_stone", c_glass},
                {"", c_glass, ""},
            },
        })

    end
    if unilib.global.pkg_executed_table["misc_nyancat"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:decor_block_rainbow_glass 8",
            recipe = {
                {"", c_glass, ""},
                {c_glass, "unilib:misc_nyancat_rainbow", c_glass},
                {"", c_glass, ""},
            },
        })

    end

end
