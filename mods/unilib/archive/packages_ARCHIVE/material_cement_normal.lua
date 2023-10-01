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

minetest.register_node('cement:dry', {
    description = S('Dry Cement'),
    tiles = { dry_cement },
    groups = { falling_node = 1, crumbly = 2},
    is_ground_content = false,
    sounds = default.node_sound_gravel_defaults()
})
minetest.register_craft({
    output = 'cement:dry 2',
    type = 'shapeless',
    recipe = { 'group:sand', 'default:gravel' }
})

minetest.register_node('cement:wet', {
    description = S('Wet Cement'),
    tiles = { wet_cement },
    groups = { falling_node = 1, crumbly = 3},
    is_ground_content = false,
    sounds = default.node_sound_dirt_defaults()
})
minetest.register_craft({
    output = 'cement:wet 2',
    type = 'shapeless',
    recipe = { 'group:sand', 'default:gravel', 'bucket:bucket_water' },
    replacements = {{ 'bucket:bucket_water', 'bucket:bucket_empty' }}
})

minetest.register_abm({
    label = 'Turn dry cement to wet cement',
    nodenames = { 'cement:dry' },
    neighbors = { 'default:water_source' },
    interval = 5,
    chance = 2,
    catch_up = true,
    action = function(pos, node)
        minetest.set_node(pos, { name = 'cement:wet'})
    end
})
]]--
