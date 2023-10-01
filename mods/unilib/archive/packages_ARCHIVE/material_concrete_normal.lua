---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cement
-- Code:    GPLv3.0
-- Media:   GPLv3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local dry_cement = 'default_sand.png^(default_gravel.png^[opacity:128)'
local wet_cement = '('..dry_cement..')^[colorize:#000000:60'
local hard_cement = '('..wet_cement..')^[brighten'
local sanded_cement = '(default_sand.png^(default_sandstone.png^[opacity:128)^[brighten)'

minetest.register_node('cement:hard', {
    description = S('Hard Cement'),
    tiles = { hard_cement },
    groups = { cracky = 2},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    paramtype2 = 'color',
    drawtype = 'color',
    palette = 'cement_palette.png',
    on_punch = function (pos, node, puncher, pointed_thing)
        colorize(pos, node, puncher, pointed_thing)
    end
})

minetest.register_node('cement:sanded', {
    description = S('Sanded Cement'),
    tiles = { sanded_cement },
    groups = { cracky = 2},
    is_ground_content = false,
    sounds = default.node_sound_stone_defaults(),
    paramtype2 = 'color',
    drawtype = 'color',
    palette = 'cement_palette.png',
    on_punch = function (pos, node, puncher, pointed_thing)
        colorize(pos, node, puncher, pointed_thing)
    end
})

minetest.register_abm({
    label = 'Wet cement to hard cement',
    nodenames = { 'cement:wet' },
    interval = 10,
    chance = 3,
    catch_up = true,
    action = function(pos, node)
        local n = minetest.find_node_near(pos, 1, { 'default:water_source'})
        if n == nil then minetest.set_node(pos, { name = 'cement:hard'}) end
    end
})
]]--
