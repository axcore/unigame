---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bucket
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bucket_steel = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bucket.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bucket_steel.init()

    return {
        description = "Steel bucket",
        depends = "metal_steel",
        -- Unregister water/lava buckets from default, but only if unilib replacements are loaded
        optional = {"liquid_lava_ordinary", "liquid_water_ordinary", "liquid_water_river"},
    }

end

function unilib.pkg.bucket_steel.exec()

    unilib.register_bucket({
        -- From bucket:bucket_empty (etc), creates unilib:bucket_steel_empty (etc)
        orig_name = {
            "bucket:bucket_empty",
            "bucket:bucket_water",
            "bucket:bucket_river_water",
            "bucket:bucket_lava",
        },
        bucket_type = "bucket_steel",

        replace_mode = mode,
        burntime = 0,
        description = S("Steel Bucket"),
        group_table = {tool = 1},
        ingredient = "unilib:metal_steel_ingot",
        stack_max = 99,
    })

end
