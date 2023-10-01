---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    compass
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_block_compass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.compass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_block_compass.init()

    return {
        description = "Decorative compass block",
        notes = "Always orientated in the right direction when placed in the world. Also" ..
                " shows the location's coordinates as infotext",
        depends = {"metal_steel", "torch_ordinary"},
    }

end

function unilib.pkg.decor_block_compass.exec()

    unilib.register_node("unilib:decor_block_compass", "compass:compass", mode, {
        -- From compass:compass
        description = S("Decorative Compass Block"),
        tiles = {
            "unilib_decor_block_compass_top.png",
            "unilib_decor_block_compass_bottom.png",
            "unilib_decor_block_compass_side_w.png",
            "unilib_decor_block_compass_side_e.png",
            "unilib_decor_block_compass_side_s.png",
            "unilib_decor_block_compass_side_n.png",
        },
        groups = {choppy = 3, oddly_breakable_by_hand = 3, snappy = 3},
        -- (no sounds)

        light_source = 14,

        after_place_node = function(pos, placer)

            -- N.B. Output tweaked for aesthetic reasons
            local meta = minetest.get_meta(pos)
            local msg = S("Compass at:") .. " "

            msg = msg .. tostring(math.floor(pos.x))
            if pos.x >= 0 then
                msg = msg .. "m " .. S("E") .. ", "
            else
                msg = msg .. "m " .. S("W") .. ", "
            end

            msg = msg .. tostring(math.floor(pos.z))
            if pos.z >= 0 then
                msg = msg .. "m " .. S("N") .. ", "
            else
                msg = msg .. "m " .. S("S") .. ", "
            end

            msg = msg .. tostring(math.floor(pos.y))
            if pos.y >= 0 then
                msg = msg .. "m " .. S("above sea level")
            else
                msg = msg .. "m " .. S("below sea level")
            end

            local player = placer:get_player_name() or ""
            if player ~= "" then
                msg = msg .. "\n(" .. S("Placed by @1", player) .. ")"
            end

            meta:set_string("infotext", msg)

        end,
    })
    -- N.B. Original recipe used default:wood
    unilib.register_craft({
        -- From compass:compass
        output = "unilib:decor_block_compass",
        recipe = {
            {"unilib:metal_steel_ingot"},
            {"unilib:torch_ordinary"},
            {"group:wood"},
        },
    })

end
