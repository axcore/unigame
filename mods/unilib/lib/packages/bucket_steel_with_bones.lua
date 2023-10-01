---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.bucket_steel_with_bones = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bucket_steel_with_bones.init()

    return {
        description = "Bucket of bones",
        depends = "bucket_steel",
    }

end

function unilib.pkg.bucket_steel_with_bones.exec()

    unilib.register_craftitem("unilib:bucket_steel_with_bones", "cheese:bones_water_bucket", mode, {
        -- From cheese:bones_water_bucket
        description = S("Bucket of Bones"),
        inventory_image = "unilib_bucket_steel_with_bones.png",
        -- N.B. bucket = 1 in original code
        groups = {inactive_bucket = 1, tool = 1},
    })
    unilib.register_craft({
        -- From cheese:bones_water_bucket
        type = "shapeless",
        output = "unilib:bucket_steel_with_bones",
        recipe = {"group:bone", "group:bone", "group:bone", "unilib:bucket_steel_empty"},
    })

end
