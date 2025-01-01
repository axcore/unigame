---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_clean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_clean.init()

    return {
        description = "Clean glass",
        depends = {"glass_ordinary", "item_sweeper"},
        optional = "mineral_mese",
    }

end

function unilib.pkg.glass_clean.exec()

    unilib.register_node("unilib:glass_clean", "moreblocks:clean_glass", mode, {
        -- From moreblocks:clean_glass
        description = S("Clean Glass"),
        tiles = {"unilib_glass_clean.png", "unilib_glass_clean_detail.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From moreblocks:clean_glass
        type = "shapeless",
        output = "unilib:glass_clean",
        recipe = {"unilib:item_sweeper", "unilib:glass_ordinary"},
    })
    unilib.register_stairs("unilib:glass_clean", {
        glass_flag = true,
    })
    unilib.register_carvings("unilib:glass_clean", {
        millwork_flag = true,
    })
    unilib.register_glass_trap({
        -- From moreblocks:trap_clean_glass. Creates unilib:glass_clean_trap
        orig_name = "moreblocks:trap_clean_glass",
        ingredient = "unilib:glass_clean",
        replace_mode = mode,
        group_table = {cracky = 3, oddly_breakable_by_hand = 3},
    })
    unilib.register_craft({
        -- From moreblocks:trap_clean_glass
        type = "shapeless",
        output = "unilib:glass_clean_trap",
        recipe = {"unilib:item_sweeper", "unilib:glass_ordinary_trap"},
    })

end
