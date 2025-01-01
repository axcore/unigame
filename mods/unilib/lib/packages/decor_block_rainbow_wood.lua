---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores_rainbow
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_block_rainbow_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores_rainbow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_block_rainbow_wood.init()

    return {
        description = "Wooden rainbow block",
        at_least_one = {"decor_block_rainbow_stone", "misc_nyancat"},
    }

end

function unilib.pkg.decor_block_rainbow_wood.exec()

    unilib.register_node("unilib:decor_block_rainbow_wood", "xtraores_rainbow:wood", mode, {
        -- From xtraores_rainbow:wood
        description = S("Wooden Rainbow Block"),
        tiles = {"unilib_decor_block_rainbow_wood.png"},
        groups = {choppy = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        light_source = unilib.constant.light_max - 1,
        -- N.B. is_ground_content = true in original code
        is_ground_content = false,
    })
    if unilib.global.pkg_executed_table["decor_block_rainbow_stone"] ~= nil then

        unilib.register_craft({
            -- From xtraores_rainbow:wood
            output = "unilib:decor_block_rainbow_wood 5",
            -- N.B. Original recipe used "default:wood"
            recipe = {
                {"", "group:wood", ""},
                {"group:wood", "unilib:decor_block_rainbow_stone", "group:wood"},
                {"", "group:wood", ""},
            },
        })

    end
    if unilib.global.pkg_executed_table["misc_nyancat"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:decor_block_rainbow_wood 5",
            recipe = {
                {"", "group:wood", ""},
                {"group:wood", "unilib:misc_nyancat_rainbow", "group:wood"},
                {"", "group:wood", ""},
            },
        })

    end

end
