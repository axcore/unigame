---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.material_thatch = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_thatch.init()

    return {
        description = "Reed thatch",
        depends = {"item_stick_ordinary", "plant_papyrus_ordinary"},
    }

end

function unilib.pkg.material_thatch.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:material_thatch", "cottages:reet", mode, {
        -- From cottages:reet
        description = S("Reed Thatch"),
        tiles = {"unilib_material_thatch.png"},
        groups = {choppy = 3, flammable = 3, hay = 3, oddly_breakable_by_hand = 3, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        is_ground_content = false,
    })
    -- N.B. Original craft recipe conflicts with recipe in "misc_reed_normal" package; also updated
    --      it to be consistent with the new recipes in the "roof_thatch" packages
    --[[
    unilib.register_craft({
        -- From cottages:reet
        output = "unilib:material_thatch",
        recipe = {
            {"unilib:plant_papyrus_ordinary", "unilib:plant_papyrus_ordinary"},
            {"unilib:plant_papyrus_ordinary", "unilib:plant_papyrus_ordinary"},
        },
    })
    ]]--
    unilib.register_craft({
        -- From cottages:reet
        output = "unilib:material_thatch",
        recipe = {
            {"unilib:plant_papyrus_ordinary", "unilib:plant_papyrus_ordinary"},
            {c_stick, c_stick},
            {"unilib:plant_papyrus_ordinary", "unilib:plant_papyrus_ordinary"},
        },
    })

end
