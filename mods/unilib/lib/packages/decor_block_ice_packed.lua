---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_block_ice_packed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_block_ice_packed.init()

    return {
        description = "Decorative packed ice",
        depends = "ice_ordinary",
    }

end

function unilib.pkg.decor_block_ice_packed.exec()

    unilib.register_node("unilib:decor_block_ice_packed", "xdecor:packed_ice", mode, {
        -- From xdecor:packed_ice
        description = S("Decorative Packed Ice"),
        tiles = {"unilib_decor_block_ice_packed.png"},
        groups = {cracky = 1, puts_out_fire = 1, slippery = 3},
        sounds = unilib.global.sound_table.glass,

        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
        paramtype2 = "facedir",
    })
    -- N.B. Original craft recipe conflicts with recipe in "ice_ordinary" package
    --[[
    unilib.register_craft({
        -- From xdecor:packed_ice
        output = "unilib:decor_block_ice_packed",
        recipe = {
            {"unilib:ice_ordinary", "unilib:ice_ordinary"},
            {"unilib:ice_ordinary", "unilib:ice_ordinary"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From xdecor:packed_ice
        output = "unilib:decor_block_ice_packed 2",
        recipe = {
            {"unilib:ice_ordinary", "unilib:ice_ordinary", "unilib:ice_ordinary"},
            {"unilib:ice_ordinary", "", "unilib:ice_ordinary"},
            {"unilib:ice_ordinary", "unilib:ice_ordinary", "unilib:ice_ordinary"},
        },
    })

end
