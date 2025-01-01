---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bonemeal
-- Code:    MIT
-- Media:   CC0-1.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_bone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bonemeal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_bone.init()

    return {
        description = "Bone",
        depends = "dirt_ordinary",
    }

end

function unilib.pkg.item_bone.exec()

    unilib.register_craftitem("unilib:item_bone", "bonemeal:bone", mode, {
        -- From bonemeal:bone
        description = S("Bone"),
        inventory_image = "unilib_item_bone.png",
        groups = {bone = 1},
    })

end

function unilib.pkg.item_bone.post()

    -- Add bones to dirt. In the original code, only default:dirt was updated; here, we update all
    --      dirts on which turf can grow
    for _, full_name in pairs(unilib.global.fertile_dirt_table) do

        unilib.override_item(full_name, {
            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:item_bone"}, rarity = 40},
                    {items = {full_name}},
                },
            },
        })

    end

end
