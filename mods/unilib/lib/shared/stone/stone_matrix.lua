---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone_matrix.lua
--      Registry functions for matrix stones
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Registry functions for matrix stones
---------------------------------------------------------------------------------------------------

function unilib.stone._register_matrix_stone(full_name, orig_name, mode, def_table)

    -- Original to unilib
    -- Registers the matrix stone (as well as the original node on which it's based, if applicable)
    -- Matrix stones are temporary nodes placed by remixes such as "underch" and "hades", initially
    --      replacing unilib:stone_ordinary. The matrix stone is then converted to some other node
    --      as the map is generated)
    -- For compatibility with the original mods, when loaded, both the original node (if any) and
    --      its unilib equivalent are registered

    unilib.register_node(full_name, orig_name, mode, def_table)

    table.insert(unilib.global.matrix_stone_list, full_name)
    if orig_name ~= nil then
        table.insert(unilib.global.matrix_stone_list, orig_name)
    end

end
