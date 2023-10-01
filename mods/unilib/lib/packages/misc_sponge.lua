---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_sponge = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_sponge.init()

    return {
        description = "Sponge",
        notes = "Dry sponges soak up water in a radius of 3 blocks. Wet sponges can be dried" ..
                " in a furnace",
    }

end

function unilib.pkg.misc_sponge.exec()

    unilib.register_node("unilib:misc_sponge_dry", "ethereal:sponge", mode, {
        -- From ethereal:sponge
        description = S("Dry Sponge"),
        tiles = {"unilib_misc_sponge_dry.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.sand,

        after_place_node = function(pos, placer, itemstack, pointed_thing)

            -- Get player name
            local name = placer:get_player_name()

            -- Is the area protected?
            if minetest.is_protected(pos, name) then
                return
            end

            --Get water nodes within range
            local num = minetest.find_nodes_in_area(
                {x = pos.x - 3, y = pos.y - 3, z = pos.z - 3},
                {x = pos.x + 3, y = pos.y + 3, z = pos.z + 3},
                {"group:water"})

            -- No water
            if #num == 0 then
                return
            end

            -- Replace water nodes with sponge air
            for _, w in pairs(num) do

                if not minetest.is_protected(pos, name) then
                    minetest.swap_node(w, {name = "unilib:misc_sponge_air"})
                end

            end

            -- Replace dry sponge with wet sponge
            minetest.swap_node(pos, {name = "unilib:misc_sponge_wet"})

        end
    })
    unilib.register_craft({
        -- From ethereal:sponge
        type = "cooking",
        output = "unilib:misc_sponge_dry",
        recipe = "unilib:misc_sponge_wet",
        cooktime = 3,
    })
    unilib.register_craft({
        -- From ethereal:sponge
        type = "fuel",
        recipe = "unilib:misc_sponge_dry",
        burntime = 5,
    })

    unilib.register_node("unilib:misc_sponge_wet", "ethereal:sponge_wet", mode, {
        -- From ethereal:sponge_wet
        description = S("Wet sponge"),
        tiles = {"unilib_misc_sponge_wet.png"},
        groups = {crumbly = 3},
        sounds = unilib.sound_table.sand,
    })

    -- When a dry sponge is placed near water, surround it with "sponge" air nodes, displacing the
    --      existing water, and preventing new water from flowing in
    -- We use leaf decay to remove the "sponge" air nodes
    unilib.register_node("unilib:misc_sponge_air", "ethereal:sponge_air", mode, {
        -- From ethereal:sponge_air
        -- (no description)
        -- (no tiles)
        groups = {not_in_creative_inventory = 1},
        -- (no sounds)

        buildable_to = true,
        drawtype = "airlike",
        drop = "",
        paramtype = "light",
        pointable = false,
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_leafdecay({
        -- From ethereal:sponge_air
        trunks = {"unilib:misc_sponge_wet"},
        leaves = {"unilib:misc_sponge_air"},
        radius = 3,
    })

end
