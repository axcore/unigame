---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_dung_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_dung_normal.init()

    return {
        description = "Normal dung",
        notes = "In original code, dung was deposited by cows, goats, pigs and sheep; in" ..
                " unimobs, dung is deposited by any mob with the .dung_name property. Dung is" ..
                " automatically removed after a while",
        optional = "item_fertiliser_mulch",
    }

end

function unilib.pkg.misc_dung_normal.exec()

    unilib.register_node("unilib:misc_dung_normal", "petz:poop", mode, {
        -- From petz:poop
        description = S("Normal Dung"),
        tiles = {"unilib_misc_dung_normal.png"},
        groups = {crumbly = 3, falling_node = 1},
        -- N.B. "stone" sounds in original code
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        falling_node = true,
        inventory_image = "unilib_misc_dung_normal_inv.png",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875},
                {-0.125, -0.375, -0.125, 0.125, -0.3125, 0.125},
                {-0.0625, -0.3125, -0.0625, 0.0625, -0.25, 0.0625},
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
            -- From petz:poop
            type = "shapeless",
            output = "unilib:item_fertiliser_mulch",
            recipe = {"unilib:misc_dung_normal"},
        })

    end

    unilib.register_node("unilib:misc_dung_normal_block", "petz:poop_block", mode, {
        -- From petz:poop_block
        description = S("Normal Dung Block"),
        tiles = {"unilib_misc_dung_normal.png"},
        groups = {flammable = 3, leaves = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "allfaces_optional",
        is_ground_content = false,
        paramtype = "light",
    })
    unilib.register_craft_3x3({
        -- From petz:poop_block
        output = "unilib:misc_dung_normal_block",
        ingredient = "unilib:misc_dung_normal",
    })

end
