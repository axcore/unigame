---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_sponge_fiery = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_sponge_fiery.init()

    return {
        description = "Fiery sponge",
        notes = "Dry sponges soak up lava in a radius of 3 blocks. Wet sponges can be dried" ..
                " in a furnace. Unlike normal sponges, does not grow spontaneously on undersea" ..
                " sand",
        depends = "misc_sponge_air",
    }

end

function unilib.pkg.misc_sponge_fiery.exec()

    unilib.register_node("unilib:misc_sponge_fiery_dry", nil, mode, {
        -- Original to unilib, loosely based on ethereal:sponge
        description = S("Dry Fiery Sponge"),
        tiles = {"unilib_misc_sponge_fiery_dry.png"},
        groups = {crumbly = 3},
        sounds = unilib.global.sound_table.sand,

        after_place_node = function(pos, placer, itemstack, pointed_thing)

            -- Get player name
            local name = placer:get_player_name()

            -- Is the area protected?
            if core.is_protected(pos, name) then
                return
            end

            --Get lava nodes within range
            local num = core.find_nodes_in_area(
                {x = pos.x - 3, y = pos.y - 3, z = pos.z - 3},
                {x = pos.x + 3, y = pos.y + 3, z = pos.z + 3},
                {"group:lava"}
            )

            -- No lava
            if #num == 0 then
                return
            end

            -- Replace lava nodes with sponge air
            for _, w in pairs(num) do

                if not core.is_protected(pos, name) then
                    core.set_node(w, {name = "unilib:misc_sponge_air"})
                end

            end

            -- Replace dry sponge with wet sponge
            core.set_node(pos, {name = "unilib:misc_sponge_fiery_wet"})

        end
    })
    unilib.register_craft({
        -- Original to unilib
        type = "cooking",
        output = "unilib:misc_sponge_fiery_dry",
        recipe = "unilib:misc_sponge_fiery_wet",
        -- N.B. 5 times slower than ordinary sponges
        cooktime = 15,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:misc_sponge_dry",
        -- N.B. 5 times longer than ordinary sponges
        burntime = 25,
    })

    unilib.register_node("unilib:misc_sponge_fiery_wet", nil, mode, {
        -- Original to unilib, loosely based on ethereal:sponge_wet
        description = S("Wet Fiery Sponge"),
        tiles = {"unilib_misc_sponge_fiery_wet.png"},
        groups = {crumbly = 3, igniter = 1},
        sounds = unilib.global.sound_table.sand,
    })

end
