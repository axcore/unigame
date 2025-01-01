---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.bucket_steel_with_seaweed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bucket_steel_with_seaweed.init()

    return {
        description = "Bucket of seaweed",
        depends = {"bucket_steel", "plant_seaweed_undersea"},
    }

end

function unilib.pkg.bucket_steel_with_seaweed.exec()

    local c_seaweed = "unilib:plant_seaweed_undersea"

    unilib.register_craftitem(
        -- From cheese:seaweed_water_bucket
        "unilib:bucket_steel_with_seaweed",
        "cheese:seaweed_water_bucket",
        mode,
        {
            description = S("Bucket of Seaweed"),
            inventory_image = "unilib_bucket_steel_with_seaweed.png",
            -- N.B. bucket = 1 in original code
            groups = {inactive_bucket = 1, tool = 1},
        }
    )
    unilib.register_craft({
        -- From cheese:seaweed_water_bucket
        type = "shapeless",
        output = "unilib:bucket_steel_with_seaweed",
        recipe = {c_seaweed, c_seaweed, c_seaweed, "unilib:bucket_steel_with_water_ordinary"},
    })

end
