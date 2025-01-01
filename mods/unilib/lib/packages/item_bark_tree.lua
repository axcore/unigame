---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    stripped_tree
-- Code:    GPLv3.0
-- Media:   GPLv3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_bark_tree = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.stripped_tree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_bark_tree.init()

    return {
        description = "Tree bark",
        notes = "Created when a compatible tree trunk is scraped with a bark chisel",
        optional = {"item_paper_ordinary", "item_string_ordinary"},
    }

end

function unilib.pkg.item_bark_tree.exec()

    local c_bark = "unilib:item_bark_tree"

    unilib.register_craftitem(c_bark, "default:tree_bark", mode, {
        -- From stripped_tree, default:tree_bark
        description = S("Tree Bark"),
        inventory_image = "unilib_item_bark_tree.png",
        groups = {not_in_creative_inventory = 1}
    })
    unilib.register_craft({
        -- From stripped_tree, default:tree_bark
        type = "fuel",
        recipe = c_bark,
        burntime = 15,
    })
    if unilib.global.pkg_executed_table["item_string_ordinary"] ~= nil then

        unilib.register_craft({
            -- From stripped_tree, default:tree_bark
            output = "unilib:item_string_ordinary 4",
            recipe = {
                {c_bark, c_bark, c_bark},
                {c_bark, c_bark, c_bark},
                {c_bark, c_bark, c_bark},
            },
        })

    end
    if unilib.global.pkg_executed_table["item_fertiliser_mulch"] ~= nil then

        unilib.register_craft({
            -- From stripped_tree, default:tree_bark
            output = "unilib:item_fertiliser_mulch 4",
            recipe = {
                {c_bark, c_bark, c_bark},
                {c_bark, c_bark, c_bark},
                {"", "", ""},
            },
        })

    end

end

function unilib.pkg.item_bark_tree.post()

    local c_bark = "unilib:item_bark_tree"

    if unilib.global.pkg_executed_table["item_paper_ordinary"] ~= nil  then

        unilib.register_craft({
            -- From stripped_tree, default:tree_bark
            output = "unilib:item_paper_ordinary 8",
            recipe = {
                {c_bark, c_bark, c_bark},
                {c_bark, "group:craftable_bucket", c_bark},
                {c_bark, c_bark, c_bark},
            },
            replacements = unilib.global.craftable_bucket_list,
        })

    end

end
