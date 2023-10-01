---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_fence_ponga = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_fence_ponga.init()

    return {
        description = "Traditional ponga fence",
        at_least_one = {"tree_fern_silver", "tree_mamaku", "tree_wheki"},
    }

end

function unilib.pkg.misc_fence_ponga.exec()

    unilib.register_node("unilib:misc_fence_ponga", "aotearoa:ponga_fence", mode, {
        -- From aotearoa:ponga_fence
        description = S("Traditional Ponga Fence"),
        tiles = {
            "unilib_misc_fence_ponga_top.png",
            "unilib_misc_fence_ponga_top.png",
            "unilib_misc_fence_ponga.png"
        },
        groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        connects_to = {
            "unilib:misc_fence_ponga",
            "group:crumbly",
            "group:stone",
            "group:tree",
            "group:wood",
        },
        drawtype = "nodebox",
        inventory_image = "unilib_misc_fence_ponga.png",
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
        use_texture_alpha = "clip",
        wield_image = "unilib_misc_fence_ponga.png",
    })
    if unilib.pkg_executed_table["tree_fern_silver"] ~= nil then

        local c_trunk = "unilib:tree_fern_silver_trunk"

        unilib.register_craft({
            -- From aotearoa:ponga_fence
            output = "unilib:misc_fence_ponga",
            recipe = {
                {"", "", ""},
                {"", "", ""},
                {c_trunk, c_trunk, c_trunk},
            },
        })

    end
    if unilib.pkg_executed_table["tree_mamaku"] ~= nil then

        local c_trunk = "unilib:tree_mamaku_trunk"

        unilib.register_craft({
            -- From aotearoa:ponga_fence
            output = "unilib:misc_fence_ponga",
            recipe = {
                {"", "", ""},
                {"", "", ""},
                {c_trunk, c_trunk, c_trunk},
            },
        })

    end
    if unilib.pkg_executed_table["tree_wheki"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:ponga_fence
            output = "unilib:misc_fence_ponga",
            recipe = {
                {"", "", ""},
                {"", "", ""},
                {"unilib:tree_wheki_trunk", "unilib:tree_wheki_trunk", "unilib:tree_wheki_trunk"},
            },
        })

    end
    unilib.register_craft({
        -- From aotearoa:ponga_fence
        type = "fuel",
        recipe = "unilib:misc_fence_ponga",
        burntime = 3,
    })

end
