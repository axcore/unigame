---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_undersea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

-- Convert a randomly-generated number in the range 2-5 into a coral
local coral_table = {}
coral_table[2] = "unilib:coral_rooted_blue_glow"
coral_table[3] = "unilib:coral_rooted_orange_glow"
coral_table[4] = "unilib:coral_rooted_pink_glow"
coral_table[5] = "unilib:coral_rooted_green_glow"

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_undersea.init()

    return {
        description = "Undersea sand",
        notes = "Used in an ore distribution. Looks identical to ordinary sand, but coral," ..
                " seaweed and other sealife grows on it",
        depends = {
            "coral_rooted_blue_glow",
            "coral_rooted_green_glow",
            "coral_rooted_orange_glow",
            "coral_rooted_pink_glow",
            "liquid_water_ordinary",
            "misc_sponge",
            "plant_seaweed_undersea",
            "sand_ordinary",
        },
    }

end

function unilib.pkg.sand_undersea.exec()

    unilib.register_node("unilib:sand_undersea", "ethereal:sandy", mode, {
        -- From ethereal:sandy
        description = S("Undersea Sand"),
        tiles = {"unilib_sand_ordinary.png"},
        groups = {crumbly = 3, falling_node = 1, not_in_creative_inventory = 1, sand = 1},
        sounds = unilib.sound_table.sand,

        drop = "unilib:sand_ordinary",
    })

    unilib.register_abm({
        -- From ethereal:sandy
        label = "Grow coral/seaweed [sand_undersea]",
        nodenames = {"unilib:sand_undersea"},

        catch_up = false,
        chance = 10,
        interval = 15,
        neighbors = {"group:water"},

        action = function(pos, node)

            local sel = math.random(6)

            pos.y = pos.y + 1

            local nod = minetest.get_node(pos).name
            if nod == "unilib:liquid_water_ordinary_source" and sel == 6 then

                minetest.swap_node(pos, {name = "unilib:misc_sponge_wet"})
                return

            end

            if nod == "unilib:liquid_water_ordinary_source" and sel > 1 then

                minetest.swap_node(pos, {name = coral_table[sel]})
                return

            end

            if nod == "unilib:plant_seaweed_undersea" or sel == 1 then

                local height = 0
                local high = 14

                while height < high and
                        minetest.get_node(pos).name == "unilib:plant_seaweed_undersea" do

                    height = height + 1
                    pos.y = pos.y + 1

                end

                if pos.y < 1 and
                        height < high and
                        minetest.get_node(pos).name == "unilib:liquid_water_ordinary_source" then
                    minetest.swap_node(pos, {name = "unilib:plant_seaweed_undersea"})
                end
            end
        end
    })

end
