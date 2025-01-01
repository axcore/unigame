---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrapdoors
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.trapdoor_wood_apple_ornate = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrapdoors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.trapdoor_wood_apple_ornate.init()

    return {
        description = "Ornate apple tree wood trapdoor",
        depends = "tree_apple",
    }

end

function unilib.pkg.trapdoor_wood_apple_ornate.exec()

    local c_wood = "unilib:tree_apple_wood"

    unilib.register_trapdoor({
        -- From moretrapdoors:wood_trapdoor. Creates unilib:trapdoor_wood_apple_ornate_closed, etc
        part_name = "wood_apple_ornate",
        orig_name_list = {"moretrapdoors:wood_trapdoor", "moretrapdoors:wood_trapdoor_open"},
        def_table = {
            description = S("Ornate Apple Tree Wood Trapdoor"),
            -- (no tiles)
            groups = {choppy = 2, door = 1, flammable = 2, oddly_breakable_by_hand = 2},
            -- (no sounds)

            gain_close = 0.13,
            gain_open = 0.06,
            inventory_image = "unilib_trapdoor_wood_apple_ornate.png",
            tile_front = "unilib_trapdoor_wood_apple_ornate.png",
            -- N.B. "side" image not used in original code
            tile_side = "unilib_trapdoor_wood_apple_ornate_side.png",
            wield_image = "unilib_trapdoor_wood_apple_ornate.png",
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From moretrapdoors:wood_trapdoor
        output = "unilib:trapdoor_wood_apple_ornate 2",
        recipe = {
            {c_wood, c_wood, c_wood},
            {c_wood, "unilib:tree_apple_trunk", c_wood},
        },
    })

end
