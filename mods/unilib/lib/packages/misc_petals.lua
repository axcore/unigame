---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_petals = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_petals.init()

    return {
        description = "Petals",
        notes = "Harvested from certain nodes by using a sickle",
        depends = "shared_sickles",
        optional = {"flower_dandelion_white", "flower_dandelion_yellow"},
    }

end

function unilib.pkg.misc_petals.exec()

    local node_box = {
        type = "wallmounted",
        wall_side = { -0.5, -0.5, -0.5, -0.45, 0.5, 0.5 },
        wall_top = { -0.5, 0.45, -0.5, 0.5, 0.5, 0.5 },
        wall_bottom = { -0.5, -0.5, -0.5, 0.5, -0.45, 0.5 }
    }

    unilib.register_node("unilib:misc_petals", "sickles:petals", mode, {
        -- From sickles:petals
        description = S("Flower Petals"),
        tiles = {"unilib_misc_petals.png"},
        groups = {attached_node = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "signlike",
        floodable = true,
        inventory_image = "unilib_misc_petals.png",
        is_ground_content = false,
        node_box = node_box,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = node_box,
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_misc_petals.png",
    })
    if unilib.global.pkg_executed_table["flower_dandelion_white"] ~= nil and
            unilib.global.pkg_executed_table["flower_dandelion_white"] ~= nil then

        -- N.B. Original craft recipe conflicts with recipe in "flower_dandelion_white_cluster"
        --      package
        --[[
        unilib.register_craft_2x2({
            -- From sickles:petals
            output = "unilib:misc_petals",
            ingredient = "unilib:flower_dandelion_white",
        })
        ]]--
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:misc_petals",
            recipe = {
                {"unilib:flower_dandelion_white", "unilib:flower_dandelion_yellow"},
                {"unilib:flower_dandelion_yellow", "unilib:flower_dandelion_white"},
            },
        })

    end

end
