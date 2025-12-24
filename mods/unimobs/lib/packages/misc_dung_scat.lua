---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_dung_scat = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_dung_scat.init()

    return {
        description = "Scat",
        notes = "Deposited by bears (or by other suitable creatures), but only when near trees",
        optional = "item_fertiliser_mulch",
    }

end

function unilib.pkg.misc_dung_scat.exec()

    unilib.register_node("unilib:misc_dung_scat", nil, mode, {
        -- Original to unimobs, adapted from unilib:misc_dung_normal
        description = S("Scat"),
        tiles = {"unilib_misc_dung_scat.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        falling_node = true,
        inventory_image = "unilib_misc_dung_scat_inv.png",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
                {-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
                {-0.0625, -0.375, -0.0625, 0.0625, -0.3125, 0.0625},
            },
        },
        paramtype = "light",
        walkable = false,

        on_construct = function(pos)

            local timer = core.get_node_timer(pos)
            timer:start(unimobs.petz_setting.average_dung_decay_rate)

        end,

        on_timer = function(pos, elapsed)

            core.remove_node(pos)
            return false

        end,
    })
    if unilib.global.pkg_executed_table["item_fertiliser_mulch"] ~= nil then

        unilib.register_craft({
            -- Original to unimobs
            type = "shapeless",
            output = "unilib:item_fertiliser_mulch",
            recipe = {"unilib:misc_dung_scat"},
        })

    end

    unilib.register_node("unilib:misc_dung_scat_block", nil, mode, {
        -- Original to unimobs, adapted from unilib:misc_dung_normal_block
        description = S("Scat Block"),
        tiles = {"unilib_misc_dung_scat.png"},
        groups = {flammable = 3, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "allfaces_optional",
        is_ground_content = false,
        paramtype = "light",
    })
    unilib.register_craft_3x3({
        -- Original to unimobs
        output = "unilib:misc_dung_scat_block",
        ingredient = "unilib:misc_dung_scat",
    })

end
