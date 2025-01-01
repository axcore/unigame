---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_dried = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_dried.init()

    return {
        description = "Dried dirt",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.dirt_dried.exec()

    unilib.register_fertile_dirt({
        -- From ethereal:dry_dirt. Creates unilib:dirt_dried
        part_name = "dirt_dried",
        orig_name = "ethereal:dry_dirt",
        def_table = {
            description = S("Dried Dirt"),
            tiles = {"unilib_dirt_dried.png"},
            -- N.B. dry_dirt = 1 not in original code
            groups = {crumbly = 3, dry_dirt = 1},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        compressed_description = S("Compressed Dried Dirt"),
        compressed_group_table = {crumbly = 2},
    })
    unilib.register_craft({
        -- From ethereal:dry_dirt
        type = "cooking",
        output = "unilib:dirt_dried",
        recipe = "unilib:dirt_ordinary",
        cooktime = 3,
    })
    unilib.register_stairs("unilib:dirt_dried")

end
