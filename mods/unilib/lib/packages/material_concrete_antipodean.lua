---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.material_concrete_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_concrete_antipodean.init()

    return {
        description = "Antipodean concrete",
        depends = {"gravel_ordinary", "material_quicklime"},
    }

end

function unilib.pkg.material_concrete_antipodean.exec()

    unilib.register_node("unilib:material_concrete_antipodean", "aotearoa:concrete", mode, {
        -- From aotearoa:concrete
        description = S("Antipodean Concrete"),
        tiles = {"unilib_material_concrete_antipodean.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:stone_concrete",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
    })
    unilib.register_stairs("unilib:material_concrete_antipodean", {
        basic_flag = true,
    })
    unilib.register_craft({
        -- From aotearoa:concrete
        output = "unilib:material_concrete_antipodean 6",
        recipe = {
            {"unilib:material_quicklime", "group:sand", "unilib:gravel_ordinary"},
        },
    })

    unilib.register_node(
        -- From aotearoa:concrete_block
        "unilib:material_concrete_antipodean_block",
        "aotearoa:concrete_block",
        mode,
        {
            description = S("Antipodean Concrete Block"),
            tiles = {"unilib_material_concrete_antipodean_block.png"},
            groups = {cracky = 2, stone = 1},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3x9({
        -- From aotearoa:concrete_block
        output = "unilib:material_concrete_antipodean_block",
        ingredient = "unilib:material_concrete_antipodean",
    })
    unilib.register_stairs("unilib:material_concrete_antipodean_block", {
        basic_flag = true,
    })

    unilib.register_node(
        -- From aotearoa:concretebrick
        "unilib:material_concrete_antipodean_brick",
        "aotearoa:concretebrick",
        mode,
        {
            description = S("Antipodean Concrete Bricks"),
            tiles = {"unilib_material_concrete_antipodean_brick.png"},
            groups = {cracky = 2, stone = 1},
            sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        }
    )
    unilib.register_craft_2x2x4({
        -- From aotearoa:concretebrick
        output = "unilib:material_concrete_antipodean_brick",
        ingredient = "unilib:material_concrete_antipodean",
    })
    unilib.register_stairs("unilib:material_concrete_antipodean_brick", {
        basic_flag = true,
    })
    unilib.utils.set_auto_rotate(
        "unilib:material_concrete_antipodean_brick", unilib.setting.auto_rotate_brick_flag
    )

end
