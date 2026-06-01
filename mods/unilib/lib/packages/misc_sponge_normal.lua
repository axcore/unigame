---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_sponge_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_sponge_normal.init()

    return {
        description = "Normal sponge",
        notes = "Dry normal sponges soak up water in a radius of 3 blocks. Wet normal sponges" ..
                " can be dried in a furnace. Because of code in the \"sand_undersea\" mod, grows" ..
                " spontaneously on undersea sand",
        depends = "misc_sponge_air",
    }

end

function unilib.pkg.misc_sponge_normal.exec()

    unilib.register_node("unilib:misc_sponge_normal_dry", "ethereal:sponge", mode, {
        -- From ethereal:sponge
        description = S("Dry Normal Sponge"),
        tiles = {"unilib_misc_sponge_normal_dry.png"},
        groups = {crumbly = 3},
        sounds = unilib.global.sound_table.sand,

        after_place_node = function(pos, placer, itemstack, pointed_thing)

            -- Get player name
            local name = placer:get_player_name()

            -- Is the area protected?
            if core.is_protected(pos, name) then
                return
            end

            --Get water nodes within range
            local num = core.find_nodes_in_area(
                {x = pos.x - 3, y = pos.y - 3, z = pos.z - 3},
                {x = pos.x + 3, y = pos.y + 3, z = pos.z + 3},
                {"group:water"}
            )

            -- No water
            if #num == 0 then
                return
            end

            -- Replace water nodes with sponge air
            for _, w in pairs(num) do

                if not core.is_protected(pos, name) then
                    core.set_node(w, {name = "unilib:misc_sponge_air"})
                end

            end

            -- Replace dry sponge with wet sponge
            core.set_node(pos, {name = "unilib:misc_sponge_normal_wet"})

        end
    })
    unilib.register_craft({
        -- From ethereal:sponge
        type = "cooking",
        output = "unilib:misc_sponge_normal_dry",
        recipe = "unilib:misc_sponge_normal_wet",
        cooktime = 3,
    })
    unilib.register_craft({
        -- From ethereal:sponge
        type = "fuel",
        recipe = "unilib:misc_sponge_normal_dry",
        burntime = 5,
    })
    -- N.B. Items in this mod were renamed in unilib v1.2.0
    core.register_alias("unilib:misc_sponge_dry", "unilib:misc_sponge_normal_dry")

    unilib.register_node("unilib:misc_sponge_normal_wet", "ethereal:sponge_wet", mode, {
        -- From ethereal:sponge_wet
        description = S("Wet Normal Sponge"),
        tiles = {"unilib_misc_sponge_normal_wet.png"},
        groups = {crumbly = 3},
        sounds = unilib.global.sound_table.sand,
    })
    core.register_alias("unilib:misc_sponge_wet", "unilib:misc_sponge_normal_wet")

end
