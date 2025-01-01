---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plaster
-- Code:    CC BY-SA 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_block_plaster = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plaster.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_block_plaster.init()

    return {
        description = "Block of plaster",
        depends = "material_lime_crushed",
    }

end

function unilib.pkg.decor_block_plaster.exec()

    unilib.register_node("unilib:decor_block_plaster", "plaster:plaster", mode, {
        -- From plaster:plaster
        description = S("Block of Plaster"),
        tiles = {"unilib_decor_block_plaster.png"},
        groups = {choppy = 2, cracky = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })

    -- N.B. Instead of creating framed variants directly, as in the original code, re-use fachwerk
    --      code to create the framed variants
    unilib.pkg.shared_fachwerk.register_timber_frame({
        -- From fachwerk:brick, etc. Creates unilib:brick_ordinary_block_with_frame_timber, etc
        ingredient = "unilib:decor_block_plaster",
        orig_name = "plaster:plaster",

        replace_mode = mode,
    })

end

function unilib.pkg.decor_block_plaster.post()

    local c_lime = "unilib:material_lime_crushed"

    unilib.register_craft({
        -- From plaster:plaster
        output = "unilib:decor_block_plaster 6",
        recipe = {
            {"group:sand", c_lime, "group:sand"},
            {c_lime, "group:craftable_bucket", c_lime},
            {"group:sand", c_lime, "group:sand"},
        },
        replacements = unilib.global.craftable_bucket_list,
    })

end
