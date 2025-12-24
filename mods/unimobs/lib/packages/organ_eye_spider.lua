---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.organ_eye_spider = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.organ_eye_spider.init()

    return {
        description = "Spider eye",
        notes = "Dropped by tarantulas; in original petz code, it is not used for anything",
    }

end

function unilib.pkg.organ_eye_spider.exec()

    unilib.register_craftitem("unilib:organ_eye_spider", "petz:spider_eye", mode, {
        -- From petz:spider_eye
        description = S("Spider Eye"),
        inventory_image = "unilib_organ_eye_spider.png",
    })

end
