---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_coal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_coal.init()

    return {
        description = "Coal glass",
        depends = {"glass_ordinary", "mineral_coal"},
        optional = "metal_steel",
    }

end

function unilib.pkg.glass_coal.exec()

    unilib.register_node("unilib:glass_coal", "moreblocks:coal_glass", mode, {
        -- From moreblocks:coal_glass
        description = S("Coal Glass"),
        tiles = {
            "unilib_glass_ordinary.png^[colorize:#828282",
            "unilib_glass_ordinary_detail.png^[colorize:#828282",
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
        -- From moreblocks:coal_glass
        type = "shapeless",
        output = "unilib:glass_coal",
        recipe = {"unilib:mineral_coal_lump", "unilib:glass_ordinary"},
    })
    if unilib.global.pkg_executed_table["metal_steel"] ~= nil then

        unilib.register_craft({
            -- From moreblocks:coal_glass
            type = "shapeless",
            output = "unilib:glass_ordinary",
            recipe = {"unilib:metal_steel_ingot", "unilib:glass_coal"},
        })

    end
    unilib.register_stairs("unilib:glass_coal", {
        glass_flag = true,
    })
    unilib.register_carvings("unilib:glass_coal", {
        millwork_flag = true,
    })

end
