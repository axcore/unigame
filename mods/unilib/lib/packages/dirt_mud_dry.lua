---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mud_dry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mud_dry.init()

    return {
        description = "Dru mud",
        optional = {"clay_ordinary", "dirt_ordinary", "sand_silt"},
    }

end

function unilib.pkg.dirt_mud_dry.exec()

    unilib.register_node("unilib:dirt_mud_dry", "darkage:mud", mode, {
        -- From darkage:mud
        description = S("Dry Mud"),
        tiles = {"unilib_dirt_mud_dry_top.png", "unilib_dirt_mud_dry.png"},
        -- N.B. dry_dirt = 1 not in original code
        groups = {crumbly = 3, dry_dirt = 1},
        sounds = unilib.sound.generate_dirt({
            footstep = "",
        }),

        drop = "unilib:dirt_mud_dry_lump 4",
        is_ground_content = unilib.setting.caves_chop_dirt_flag,
    })
    unilib.register_craft_2x2({
        -- From darkage:mud
        output = "unilib:dirt_mud_dry",
        ingredient = "unilib:dirt_mud_dry_lump",
    })
    if unilib.global.pkg_executed_table["clay_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["dirt_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["sand_silt"] ~= nil then

        unilib.register_craft({
            -- From darkage:mud
            output = "unilib:dirt_mud_dry 3",
            recipe = {
                {"unilib:dirt_ordinary", "unilib:dirt_ordinary"},
                {"unilib:clay_ordinary_lump", "unilib:sand_silt_lump"},
            },
        })

    end

    unilib.register_craftitem("unilib:dirt_mud_dry_lump", "darkage:mud_lump", mode, {
        -- From darkage:mud_lump
        description = S("Dry Mud Lump"),
        inventory_image = "unilib_dirt_mud_dry_lump.png",
    })

end
