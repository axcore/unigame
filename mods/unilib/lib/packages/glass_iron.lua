---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_iron = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_iron.init()

    return {
        description = "Iron glass",
        depends = {"glass_ordinary", "metal_steel"},
        optional = "mineral_coal",
    }

end

function unilib.pkg.glass_iron.exec()

    unilib.register_node("unilib:glass_iron", "moreblocks:iron_glass", mode, {
        -- From moreblocks:iron_glass
        description = S("Iron Glass"),
        tiles = {
            "unilib_glass_ordinary.png^[colorize:#DEDEDE",
            "unilib_glass_ordinary_detail.png^[colorize:#DEDEDE",
        },
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From moreblocks:iron_glass
        type = "shapeless",
        output = "unilib:glass_iron",
        recipe = {"unilib:metal_steel_ingot", "unilib:glass_ordinary"},
    })
    if unilib.global.pkg_executed_table["mineral_coal"] ~= nil then

        unilib.register_craft({
            -- From moreblocks:iron_glass
            type = "shapeless",
            output = "unilib:glass_ordinary",
            recipe = {"unilib:mineral_coal_lump", "unilib:glass_iron"},
        })

    end
    unilib.register_stairs("unilib:glass_iron", {
        glass_flag = true,
    })
    unilib.register_carvings("unilib:glass_iron", {
        millwork_flag = true,
    })

end
