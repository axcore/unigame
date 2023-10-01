-- farming/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("farming")

-- Global farming namespace

farming = {}
farming.path = minetest.get_modpath("farming")
farming.get_translator = S

-- Load files

dofile(farming.path .. "/api.lua")
dofile(farming.path .. "/nodes.lua")
dofile(farming.path .. "/hoes.lua")
