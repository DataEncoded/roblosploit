--[[
Last Updated: 07/30/2022
Description:  General bootstrapper meant to set up roblosploit on the server

Copyright (C) 2022  DataEncoded

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

print("Hello world, from server!")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local sploitRemote = ReplicatedStorage.roblosploit_shared.RoblosploitRemote
local remoteRecieved = script.RemoteRecieved

local allowedUsers = require(script.AllowedUsers)

local allowedCache = {}

--Returns true if person can send remotes, false if not
local function verifyAllowed(p)
	if table.find(allowedCache, p) then
		return true
	end

	--No cache here, would be meaningless to just add every user to the cache
	if allowedUsers["vip-all"] then
		return true
	end

	--Special case for VIP server where owner is allowed
	if allowedUsers["vip"] then
		if game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0 then
			if p.UserId == game.PrivateServerOwnerId then
				table.insert(allowedCache, p)
				return true
			end
		end
	end

	--Player wasn't found in cache, loop over to ensure they are allowed
	for _, v in ipairs(allowedUsers["ids"]) do
		if p.UserId == v then
			table.insert(allowedCache, p)
			return true
		end
	end

	for _, v in ipairs(allowedUsers["usernames"]) do
		if p.Name == v then
			table.insert(allowedCache, p)
			return true
		end
	end
end

--Ensure that only people allowed can send remotes
sploitRemote.OnServerEvent:Connect(function(p, header, ...)
	if verifyAllowed(p) then
		if header and header ~= "" then
			remoteRecieved:Fire(header, ...)
		end
	end
end)
