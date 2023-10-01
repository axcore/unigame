---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.material_cob = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_cob.init()

    return {
        description = "Cob",
        depends = "dirt_ordinary",
        optional = {"crop_wheat", "dirt_rammed", "plant_papyrus_ordinary", "plant_shrub_dry"},
    }

end

function unilib.pkg.material_cob.exec()

    unilib.register_node("unilib:material_cob", "earthbuild:cob", mode, {
        -- From earthbuild:cob
        description = S("Cob"),
        tiles = {"unilib_material_cob.png"},
        groups = {cracky = 3, crumbly = 2, falling_node = 1},
        sounds = unilib.sound_table.dirt,

        drawtype = "normal",
        paramtype = "light",
    })
    unilib.register_craft({
        -- From earthbuild:cob
        output = "unilib:material_cob 2",
        recipe = {
            {"unilib:dirt_ordinary", "", "unilib:dirt_ordinary"},
            {"", "group:grass", ""},
            {"", "", ""},
        },
    })
    unilib.register_craft({
        -- From earthbuild:cob
        output = "unilib:material_cob 2",
        recipe = {
            {"unilib:dirt_ordinary", "", "unilib:dirt_ordinary"},
            {"", "group:dry_grass", ""},
            {"", "", ""},
        },
    })
    unilib.register_craft({
        -- From earthbuild:cob
        output = "unilib:material_cob 2",
        recipe = {
            {"unilib:dirt_ordinary", "", "unilib:dirt_ordinary"},
            {"", "group:leaves", ""},
            {"", "", ""},
        },
    })
    unilib.register_craft({
        -- From earthbuild:cob
        output = "unilib:material_cob 2",
        recipe = {
            {"unilib:dirt_ordinary", "", "unilib:dirt_ordinary"},
            {"", "group:jungelgrass", ""},
            {"", "", ""},
        },
    })
    if unilib.pkg_executed_table["plant_shrub_dry"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:cob
            output = "unilib:material_cob 2",
            recipe = {
                {"unilib:dirt_ordinary", "", "unilib:dirt_ordinary"},
                {"", "unilib:plant_shrub_dry", ""},
                {"", "", ""},
            },
        })

    end
    if unilib.pkg_executed_table["plant_papyrus_ordinary"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:cob
            output = "unilib:material_cob 2",
            recipe = {
                {"unilib:dirt_ordinary", "", "unilib:dirt_ordinary"},
                {"", "unilib:plant_papyrus_ordinary", ""},
                {"", "", ""},
            },
        })

    end
    if unilib.pkg_executed_table["crop_wheat"] ~= nil then

        unilib.register_craft({
            -- From earthbuild:cob
            output = "unilib:material_cob 2",
            recipe = {
                {"unilib:dirt_ordinary", "", "unilib:dirt_ordinary"},
                {"", "unilib:crop_wheat_harvest", ""},
                {"", "", ""},
            },
        })

    end
    unilib.register_craft({
        -- From earthbuild:cob
        output = "unilib:material_cob",
        recipe = {
            {"unilib:material_cob_brick"},
        },
    })
    unilib.register_stairs("unilib:material_cob", {
        basic_flag = true,
    })

    unilib.register_node("unilib:material_cob_brick", "earthbuild:mud_brick", mode, {
        -- From earthbuild:mud_brick
        description = S("Mud Brick"),
        tiles = {"unilib_material_cob_brick.png"},
        groups = {cracky = 3, crumbly = 2},
        sounds = unilib.sound_table.dirt,

        drawtype = "normal",
        paramtype = "light",
    })
    unilib.register_craft({
        -- From earthbuild:mud_brick
        output = "unilib:material_cob_brick",
        recipe = {
            {"unilib:material_cob"},
        },
    })
    unilib.register_stairs("unilib:material_cob_brick", {
        basic_flag = true,
    })
    unilib.set_auto_rotate("unilib:material_cob_brick", unilib.auto_rotate_brick_flag)

end
