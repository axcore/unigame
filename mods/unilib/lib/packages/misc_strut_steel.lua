---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_strut_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_strut_steel.init()

    return {
        description = "Steel struts",
        depends = "metal_steel",
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.misc_strut_steel.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node(
        -- From steel:strut
        "unilib:misc_strut_steel",
        {"steel:strut", "streets:steel_support"},
        mode,
        {
            description = S("Steel Strut"),
            tiles = {"unilib_misc_strut_steel.png"},
            -- N.B. dig_stone = 1 in original code
            groups = {choppy = 1, cracky = 1},
            -- N.B. "stone" in original code
            sounds = unilib.global.sound_table.metal,

            drawtype = "glasslike",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
            use_texture_alpha = "clip",
        }
    )
    unilib.register_craft({
        -- From steel:strut
        output = "unilib:misc_strut_steel 5",
        recipe = {
            {"", c_ingot, ""},
            {c_ingot, c_ingot, c_ingot},
            {"", c_ingot, ""},
        },
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:material_scrap_steel 2",
            recipe = {
                {"unilib:misc_strut_steel"},
            },
        })

    end

    unilib.register_node("unilib:misc_strut_steel_with_mount", "steel:strut_mount", mode, {
        -- From steel:strut_mount
        description = S("Steel Strut with Mount"),
        tiles = {
            "unilib_misc_strut_steel.png",
            "unilib_misc_strut_steel.png",
            "unilib_misc_strut_steel.png^unilib_misc_strut_steel_overlay.png",
            "unilib_misc_strut_steel.png^unilib_misc_strut_steel_overlay.png",
            "unilib_misc_strut_steel.png^unilib_misc_strut_steel_overlay.png",
            "unilib_misc_strut_steel.png^unilib_misc_strut_steel_overlay.png",
        },
        -- N.B. dig_stone = 1 in original code
        groups = {choppy = 1, cracky = 1},
        -- N.B. "stone" in original code
        sounds = unilib.global.sound_table.metal,

        drawtype = "mesh",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        mesh = "unilib_misc_strut_steel.obj",
        paramtype = "light",
        paramtype2 = "wallmounted",
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From steel:strut_mount
        output = "unilib:misc_strut_steel_with_mount",
        recipe = {
            {"unilib:misc_strut_steel", c_ingot},
        },
    })

end
