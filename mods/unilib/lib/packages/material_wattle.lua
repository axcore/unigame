---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.material_wattle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_wattle.init()

    return {
        description = "Wattle",
        depends = "item_stick_ordinary",
        optional = {"material_cob", "material_lime_slaked"},
    }

end

function unilib.pkg.material_wattle.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:material_wattle", "earthbuild:wattle", mode, {
        -- From earthbuild:wattle
        description = S("Wattle"),
        tiles = {
            "unilib_material_wattle_top.png",
            "unilib_material_wattle_top.png",
            "unilib_material_wattle.png",
            "unilib_material_wattle.png",
            "unilib_material_wattle.png",
            "unilib_material_wattle.png",
        },
        groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        connects_to = {
            "group:crumbly",
            "group:stone",
            "group:tree",
            "group:wood",
            "unilib:material_wattle",
            "unilib:material_wattle_loose",
        },
        drawtype = "nodebox",
        inventory_image = "unilib_material_wattle.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "connected",
            fixed = {
                {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
            },
            connect_front = {
                {-1/8, -1/2, -1/2,  1/8, 1/2, -1/8},
            },
            connect_left = {
                {-1/2, -1/2, -1/8, -1/8, 1/2,  1/8},
            },
            connect_back = {
                {-1/8, -1/2,  1/8,  1/8, 1/2,  1/2},
            },
            connect_right = {
                { 1/8, -1/2, -1/8,  1/2, 1/2,  1/8},
            },
        },
        paramtype = "light",
        use_texture_alpha = "clip",
        wield_image = "unilib_material_wattle.png",
    })
    -- N.B. Original code uses group:stick; here we use a specific stick, so that the reverse
    --      craft recipe can be added
    unilib.register_craft({
        -- From earthbuild:wattle
        output = "unilib:material_wattle 4",
        recipe = {
            {"", "", ""},
            {"", c_stick, ""},
            {c_stick, c_stick, c_stick},
        },
    })
    unilib.register_craft({
        -- From earthbuild:wattle_loose
        output = "unilib:material_wattle",
        recipe = {
            {"unilib:material_wattle_loose", "unilib:material_wattle_loose"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:wattle
        output = "unilib:material_wattle",
        recipe = {
            {"unilib:material_wattle_and_daub"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:wattle
        output = c_stick,
        recipe = {
            {"unilib:material_wattle"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:wattle
        type = "fuel",
        recipe = "unilib:material_wattle",
        burntime = 3,
    })

    unilib.register_node("unilib:material_wattle_loose", "earthbuild:wattle_loose", mode, {
        -- From earthbuild:wattle_loose
        description = S("Loose Wattle"),
        tiles = {
            "unilib_material_wattle_top.png",
            "unilib_material_wattle_top.png",
            "unilib_material_wattle_loose.png",
            "unilib_material_wattle_loose.png",
            "unilib_material_wattle_loose.png",
            "unilib_material_wattle_loose.png",
        },
        groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        connects_to = {
            "group:crumbly",
            "group:stone",
            "group:tree",
            "group:wood",
            "unilib:material_wattle",
            "unilib:material_wattle_loose",
            "unilib:roof_thatch",
        },
        drawtype = "nodebox",
        inventory_image = "unilib_material_wattle_loose.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "connected",
            fixed = {
                {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
            },
            connect_front = {
                {-1/8, -1/2, -1/2, 1/8, 1/2, -1/8},
            },
            connect_left = {
                {-1/2, -1/2, -1/8, -1/8, 1/2, 1/8},
            },
            connect_back = {
                {-1/8, -1/2,  1/8, 1/8, 1/2, 1/2},
            },
            connect_right = {
                {1/8, -1/2, -1/8, 1/2, 1/2, 1/8},
            },
        },
        paramtype = "light",
        use_texture_alpha = "clip",
        wield_image = "unilib_material_wattle_loose.png",
    })
    unilib.register_craft({
        -- From earthbuild:wattle_loose
        output = "unilib:material_wattle_loose 4",
        recipe = {
            {"unilib:material_wattle", "unilib:material_wattle"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:wattle_loose
        type = "fuel",
        recipe = "unilib:material_wattle_loose",
        burntime = 1.5,
    })

    if unilib.global.pkg_executed_table["material_cob"] ~= nil then

        unilib.register_node(
            -- From earthbuild:wattle_and_daub
            "unilib:material_wattle_and_daub",
            "earthbuild:wattle_and_daub",
            mode,
            {
                description = S("Wattle and Daub"),
                tiles = {"unilib_material_wattle_and_daub.png"},
                groups = {choppy = 2, cracky = 3, crumbly = 2},
                sounds = unilib.global.sound_table.dirt,

                connects_to = {
                    "group:crumbly",
                    "group:stone",
                    "group:tree",
                    "group:wood",
                    "unilib:material_wattle",
                    "unilib:material_wattle_loose",
                },
                drawtype = "nodebox",
                -- N.B. The item looks better when it is 3D-rendered in the inventory
--              inventory_image = "unilib_material_wattle_and_daub.png",
                -- N.B. is_ground_content = false not in original code
                is_ground_content = false,
                node_box = {
                    type = "connected",
                    fixed = {
                        {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
                    },
                    connect_front = {
                        {-1/4, -1/2, -1/2,  1/4, 1/2, -1/4},
                    },
                    connect_left = {
                        {-1/2, -1/2, -1/4, -1/4, 1/2,  1/4},
                    },
                    connect_back = {
                        {-1/4, -1/2,  1/4,  1/4, 1/2,  1/2},
                    },
                    connect_right = {
                        { 1/4, -1/2, -1/4,  1/2, 1/2,  1/4},
                    },
                },
                paramtype = "light",
                wield_image = "unilib_material_wattle_and_daub.png",
            }
        )
        unilib.register_craft({
            -- From earthbuild:wattle_and_daub
            output = "unilib:material_wattle_and_daub 6",
            recipe = {
                {"unilib:material_wattle", "unilib:material_wattle", "unilib:material_wattle"},
                {"unilib:material_wattle", "unilib:material_wattle", "unilib:material_wattle"},
                {"", "unilib:material_cob", ""},
            },
        })

    end

end
