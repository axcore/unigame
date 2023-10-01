---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_shale_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_shale_brown.init()

    return {
        description = "Brown shale",
        optional = "dirt_mud_dry",
    }

end

function unilib.pkg.stone_shale_brown.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "shale_brown",
        description = S("Brown Shale"),

        category = "sedimentary",
        grinder_flag = false,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 1)
        hardness = 2,
        hardness_real = 1,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("shale_brown", 2, nil)

    unilib.register_node("unilib:stone_shale_brown", "darkage:shale", mode, {
        -- From darkage:shale
        description = S("Brown Shale"),
        tiles = {
            "unilib_stone_shale_brown.png",
            "unilib_stone_shale_brown.png",
            "unilib_stone_shale_brown_side.png",
        },
        -- N.B. stone = 1 not in original code
        groups = {cracky = smooth_cracky, crumbly = 2, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,
    })
    if unilib.pkg_executed_table["dirt_mud_dry"] ~= nil then

        unilib.register_craft({
            -- From darkage:shale
            type = "cooking",
            output = "unilib:stone_shale_brown",
            recipe = "unilib:dirt_mud_dry",
        })

    end
    -- N.B. In common with "stone_shale_white" and "stone_lignite" packages, this stone now has no
    --      stairs/carvings
    --[[
    unilib.register_stairs("unilib:stone_shale_brown", {
        group_type = "smooth",
    })
    unilib.register_carvings("unilib:stone_shale_brown", {
        facade_flag = true,
    })
    ]]--

    -- (no block/brick/cobble/rubble variants)

end
