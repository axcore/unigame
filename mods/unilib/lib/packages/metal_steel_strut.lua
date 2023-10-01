---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_strut = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_strut.init()

    return {
        description = "Steel struts",
        depends = "metal_steel",
        optional = "metal_steel_scrap",
    }

end

function unilib.pkg.metal_steel_strut.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node(
        -- From steel:strut
        "unilib:metal_steel_strut",
        {"steel:strut", "streets:steel_support"},
        mode,
        {
            description = S("Steel Strut"),
            tiles = {"unilib_metal_steel_strut.png"},
            -- N.B. dig_stone = 1 in original code
            groups = {choppy = 1, cracky = 1},
            -- N.B. "stone" in original code
            sounds = unilib.sound_table.metal,

            drawtype = "glasslike",
            paramtype = "light",
            use_texture_alpha = "clip",
        }
    )
    unilib.register_craft({
        -- From steel:strut
        output = "unilib:metal_steel_strut 5",
        recipe = {
            {"", c_ingot, ""},
            {c_ingot, c_ingot, c_ingot},
            {"", c_ingot, ""},
        }
    })
    if unilib.pkg_executed_table["metal_steel_scrap"] ~= nil then

        unilib.register_craft({
            -- From steel:strut
            output = "unilib:metal_steel_scrap 2",
            recipe = {
                {"unilib:metal_steel_strut"},
            },
        })

    end

    unilib.register_node("unilib:metal_steel_strut_with_mount", "steel:strut_mount", mode, {
        -- From steel:strut_mount
        description = S("Steel Strut with Mount"),
        tiles = {
            "unilib_metal_steel_strut.png",
            "unilib_metal_steel_strut.png",
            "unilib_metal_steel_strut.png^unilib_metal_steel_strut_overlay.png",
            "unilib_metal_steel_strut.png^unilib_metal_steel_strut_overlay.png",
            "unilib_metal_steel_strut.png^unilib_metal_steel_strut_overlay.png",
            "unilib_metal_steel_strut.png^unilib_metal_steel_strut_overlay.png",
        },
        -- N.B. dig_stone = 1 in original code
        groups = {choppy = 1, cracky = 1},
        -- N.B. "stone" in original code
        sounds = unilib.sound_table.metal,

        drawtype = "mesh",
        mesh = "unilib_metal_steel_strut.obj",
        paramtype = "light",
        paramtype2 = "wallmounted",
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From steel:strut_mount
        output = "unilib:metal_steel_strut_with_mount",
        recipe = {
            {"unilib:metal_steel_strut", c_ingot},
        },
    })

end
