---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bucket_wooden
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bucket_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bucket_wooden.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bucket_wood.init()

    return {
        description = "Wooden bucket",
    }

end

function unilib.pkg.bucket_wood.exec()

    local burntime = 22

    unilib.register_bucket({
        -- From bucket_wooden:bucket_empty (etc), creates unilib:bucket_wood_empty (etc)
        orig_name = {
            "bucket_wooden:bucket_empty",
            "bucket_wooden:bucket_water",
            "bucket_wooden:bucket_river_water",
        },
        bucket_type = "bucket_wood",

        replace_mode = mode,
        burntime = burntime,
        description = S("Wooden Bucket"),
        -- N.B. water_bucket_wooden = 1 in the original code, but in unilib, that is not required
        group_table = {tool = 1},
        ingredient = "group:wood",
        stack_max = 99,
    })
    unilib.register_craft({
        -- From bucket_wooden:bucket_empty
        type = "fuel",
        recipe = "unilib:bucket_wood_empty",
        burntime = burntime,
    })

end
