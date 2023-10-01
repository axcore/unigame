---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tsm_pyramids
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_ordinary_trap = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.tsm_pyramids.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_ordinary_trap.init()

    return {
        description = "Ordinary sandstone traps",
        depends = "sand_ordinary",
        optional = "shared_tsm_pyramids",
        suggested = {
            "tool_pick_wood",                   -- group:pickaxe
        },
    }

end

function unilib.pkg.stone_sandstone_ordinary_trap.exec()

    local c_sand = "unilib:sand_ordinary"

    unilib.register_node(
        -- From tsm_pyramids:trap
        "unilib:stone_sandstone_ordinary_trap_cracked",
        "tsm_pyramids:trap",
        mode,
        {
            description = S("Cracked Ordinary Sandstone"),
            tiles = {"unilib_stone_sandstone_ordinary.png^unilib_stone_cracked_overlay.png"},
            groups = {cracky = 3, crumbly = 3},
            sounds = unilib.sound_table.stone,

            drop = {
                items = {
                    {items = {c_sand}, rarity = 1},
                    {items = {c_sand}, rarity = 2},
                }
            },
            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:stone_sandstone_ordinary_trap_cracked",
        recipe = {
            {c_sand, c_sand, c_sand},
            {c_sand, "group:pickaxe", c_sand},
            {c_sand, c_sand, c_sand},
        },
    })

    unilib.register_node(
        -- From tsm_pyramids:trap_2
        "unilib:stone_sandstone_ordinary_trap_crumbling",
        "tsm_pyramids:trap_2",
        mode,
        {
            description = S("Crumbling Ordinary Sandstone"),
            tiles = {"unilib_stone_sandstone_ordinary.png^unilib_stone_crumbling_overlay.png"},
            groups = {cracky = 3, crumbly = 3},
            sounds = unilib.sound_table.stone,

            drop = {
                items = {
                    {items = {c_sand}, rarity = 1},
                    {items = {c_sand}, rarity = 2},
                }
            },
            is_ground_content = false,
        }
    )

    -- N.B. Unless the Minetest setting permits, these "trap" stones are purely decorative
    if unilib.tsm_pyramids_real_trap_flag and
            unilib.pkg_executed_table["shared_tsm_pyramids"] ~= nil then

        unilib.pkg.shared_tsm_pyramids.register_trap(
            "unilib:stone_sandstone_ordinary_trap_cracked",
            "unilib:stone_sandstone_ordinary_trap_crumbling",
            S("Cracked Ordinary Sandstone Trap"),
            S("Crumbling Ordinary Sandstone Trap")
        )

    else

        -- ...and the decorative stone needs a craft recipe
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:stone_sandstone_ordinary_trap_crumbling",
            recipe = {
                {c_sand, c_sand, "group:pickaxe"},
                {c_sand, c_sand, c_sand},
                {"group:pickaxe", c_sand, c_sand},
            },
        })

    end

end
