---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steel
-- Code:    GPL-2.0
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_plate_rusted = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.steel.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_plate_rusted.init()

    return {
        description = "Rusted steel plate",
        depends = "metal_steel_plate_soft",
    }

end

function unilib.pkg.metal_steel_plate_rusted.exec()

    unilib.register_node("unilib:metal_steel_plate_rusted", "steel:plate_rusted", mode, {
        -- From steel:plate_rusted
        description = S("Rusted Steel Plate"),
        tiles = {"unilib_metal_steel_plate_rusted.png"},
        -- N.B. dig_stone = 1 in original code
        groups = {choppy = 1, cracky = 1},
        -- N.B. "stone" in original code
        sounds = unilib.sound_table.metal,
    })
    unilib.register_abm({
        label = "Generate rusty steel [metal_steel_plate_rusted]",
        nodenames = {"unilib:metal_steel_plate_soft"},
        neighbors = {"group:water"},

        chance = 20,
        interval = 50,

        action = function(pos)

            if minetest.find_node_near(pos, 2, "air") then
                minetest.set_node(pos, {name = "unilib:metal_steel_plate_rusted"})
            end

        end,
    })

end
