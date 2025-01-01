---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    replacer
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_replacer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.replacer.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Replacement blacklist, used by all node replacement tools
unilib.pkg.shared_replacer.blacklist_table = {}

-- Playing with tnt and creative building are usually contradictory (except when doing large-scale
--      landscaping in singleplayer)
unilib.pkg.shared_replacer.blacklist_table["unilib:tnt_ordinary_placeholder"] = true
unilib.pkg.shared_replacer.blacklist_table["tnt:boom"] = true

unilib.pkg.shared_replacer.blacklist_table["unilib:tnt_gunpowder"] = true
unilib.pkg.shared_replacer.blacklist_table["tnt:gunpowder"] = true

unilib.pkg.shared_replacer.blacklist_table["unilib:tnt_gunpowder_burning"] = true
unilib.pkg.shared_replacer.blacklist_table["tnt:gunpowder_burning"] = true

unilib.pkg.shared_replacer.blacklist_table["unilib:tnt_ordinary"] = true
unilib.pkg.shared_replacer.blacklist_table["tnt:tnt"] = true
-- (From "protector_redo" mod) Prevent accidental replacement of your protector blocks
unilib.pkg.shared_replacer.blacklist_table["protector:protect"] = true
unilib.pkg.shared_replacer.blacklist_table["protector:protect2"] = true

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_replacer.is_owned(pos, placer)

    -- Was replacer_homedecor_node_is_owned()
    -- A function to check ownership of a node; taken from VanessaEs homedecor mod

    if not placer or not pos then
        return true
    end

    local pname = placer:get_player_name()
    if type(core.is_protected) == "function" then

        local result = core.is_protected(pos, pname)
        if result then

            core.chat_send_player(
                pname,
                S("Node replacement error: Cannot replace protected nodes")
            )

        end

        return result

    end

    -- "node_ownership" mod by randomproof, https://forum.minetest.net/viewtopic.php?f=13&t=846
    -- "Protector" mod by glomie, https://forum.minetest.net/viewtopic.php?id=2793
    -- Both have been superseded by more recent mods (e.g. "areas"); nevertheless the old
    --      compatibility code is retained here, in case someone is using a fork
    local ownername = false
    if type(IsPlayerNodeOwner) == "function" then

        -- Returns true if the node is owned
        if HasOwner(pos, placer) then

            if not IsPlayerNodeOwner(pos, pname) then

                -- Is an old version...
                if type(getLastOwner) == "function" then

                    ownername = getLastOwner(pos)

                -- Is a recent version...
                elseif type(GetNodeOwnerName) == "function" then

                    ownername = GetNodeOwnerName(pos)

                else

                    ownername = "someone"

                end

            end
        end

    elseif type(isprotect) == "function" then

        if not isprotect(5, pos, placer) then
            ownername = "someone"
        end

    end

    if ownername ~= false then

        core.chat_send_player(
            pname,
            S("Node replacement error: Sorry, @1 owns that position", ownername)
        )

        return true

    else

        return false

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_replacer.init()

    return {
        description = "Shared functions for node replacement tools (from replacer)",
    }

end
