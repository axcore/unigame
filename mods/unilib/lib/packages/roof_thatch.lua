---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.roof_thatch = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.roof_thatch.init()

    return {
        description = "Thatch roofing",
        optional = {"item_stick_ordinary", "plant_papyrus_ordinary"},
    }

end

function unilib.pkg.roof_thatch.exec()

    -- N.B. The craft recipe using papyrus conflicts with a recipe in "plant_papyrus_ordinary", so
    --      modified all craft recipes in this package (for consistency)

    local c_papyrus = "unilib:plant_papyrus_ordinary"
    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:roof_thatch", "earthbuild:thatch", mode, {
        -- From earthbuild:thatch
        description = S("Thatch Roofing"),
        tiles = {"unilib_roof_thatch.png"},
        groups = {flammable = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "normal",
        -- N.B. is_ground_content = false not in original code; added to match other rooves
        is_ground_content = false,
        paramtype = "light",
    })
    --[[
    unilib.register_craft({
        -- From earthbuild:thatch
        output = "unilib:roof_thatch 6",
        recipe = {
            {"group:leaves", "group:leaves", "group:leaves"},
            {"group:leaves", "group:leaves", "group:leaves"},
            {"group:leaves", "group:leaves", "group:leaves"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From earthbuild:thatch
        output = "unilib:roof_thatch 4",
        recipe = {
            {"group:leaves", "group:leaves", "group:leaves"},
            {c_stick, c_stick, c_stick},
            {"group:leaves", "group:leaves", "group:leaves"},
        },
    })
    --[[
    unilib.register_craft({
        -- From earthbuild:thatch
        output = "unilib:roof_thatch 6",
        recipe = {
            {"group:grass", "group:grass", "group:grass"},
            {"group:grass", "group:grass", "group:grass"},
            {"group:grass", "group:grass", "group:grass"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From earthbuild:thatch
        output = "unilib:roof_thatch 4",
        recipe = {
            {"group:grass", "group:grass", "group:grass"},
            {c_stick, c_stick, c_stick},
            {"group:grass", "group:grass", "group:grass"},
        },
    })
    --[[
    unilib.register_craft({
        -- From earthbuild:thatch
        output = "unilib:roof_thatch 6",
        recipe = {
            {"group:dry_grass", "group:dry_grass", "group:dry_grass"},
            {"group:dry_grass", "group:dry_grass", "group:dry_grass"},
            {"group:dry_grass", "group:dry_grass", "group:dry_grass"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From earthbuild:thatch
        output = "unilib:roof_thatch 4",
        recipe = {
            {"group:dry_grass", "group:dry_grass", "group:dry_grass"},
            {c_stick, c_stick, c_stick},
            {"group:dry_grass", "group:dry_grass", "group:dry_grass"},
        },
    })
    --[[
    unilib.register_craft({
        -- From earthbuild:thatch
        output = "unilib:roof_thatch 6",
        recipe = {
            {"unilib:grass_jungle", "unilib:grass_jungle", "unilib:grass_jungle"},
            {"unilib:grass_jungle", "unilib:grass_jungle", "unilib:grass_jungle"},
            {"unilib:grass_jungle", "unilib:grass_jungle", "unilib:grass_jungle"},
        },
    })
    ]]--
    -- N.B. default:junglegrass in the original code
    unilib.register_craft({
        -- From earthbuild:thatch
        output = "unilib:roof_thatch 4",
        recipe = {
            {"group:junglegrass", "group:junglegrass", "group:junglegrass"},
            {c_stick, c_stick, c_stick},
            {"group:junglegrass", "group:junglegrass", "group:junglegrass"},
        },
    })
    if unilib.global.pkg_executed_table["plant_papyrus_ordinary"] ~= nil then

        --[[
        unilib.register_craft({
            -- From earthbuild:thatch
            output = "unilib:roof_thatch 6",
            recipe = {
                {c_papyrus, c_papyrus, c_papyrus},
                {c_papyrus, c_papyrus, c_papyrus},
                {c_papyrus, c_papyrus, c_papyrus},
            },
        })
        ]]--
        unilib.register_craft({
            -- From earthbuild:thatch
            output = "unilib:roof_thatch 4",
            recipe = {
                {c_papyrus, c_papyrus, c_papyrus},
                {c_stick, c_stick, c_stick},
                {c_papyrus, c_papyrus, c_papyrus},
            },
        })

    end
    unilib.register_craft({
        -- From earthbuild:thatch
        type = "fuel",
        recipe = "unilib:roof_thatch",
        burntime = 9,
    })
    unilib.register_stairs("unilib:roof_thatch", {
        basic_flag = true,
    })

end
