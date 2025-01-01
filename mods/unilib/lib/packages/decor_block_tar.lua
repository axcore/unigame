---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_block_tar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_block_tar.init()

    return {
        description = "Block of tar",
        notes = "Tar is produced by cooking pine tree trunks (and optionally by cooking" ..
                " ordinary gravel)",
        depends = "tree_pine",
        optional = "gravel_ordinary",
    }

end

function unilib.pkg.decor_block_tar.exec()

    unilib.register_node("unilib:decor_block_tar", "moreblocks:tar", mode, {
        -- From moreblocks:tar
        description = S("Block of Tar"),
        tiles = {"unilib_decor_block_tar.png"},
        groups = {cracky = 2, tar_block = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From moreblocks:tar
        type = "cooking",
        output = "unilib:decor_block_tar",
        recipe = "unilib:tree_pine_trunk",
    })
    if unilib.global.pkg_executed_table["gravel_ordinary"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:decor_block_tar",
            recipe = "unilib:gravel_ordinary",
            cooktime = 12,
        })

    end
    unilib.register_stairs("unilib:decor_block_tar")

end
