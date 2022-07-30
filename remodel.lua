local game = remodel.readPlaceFile("build.rbxlx")

local shared = game.ReplicatedStorage.roblosploit_shared
local server = game.ServerScriptService.roblosploit_server

for _, v in ipairs(shared:GetChildren()) do
	if
		not (
			v.ClassName == "Script"
			or v.ClassName == "LocalScript"
			or v.ClassName == "ModuleScript"
			or v.ClassName == "Folder"
		)
	then
		remodel.writeModelFile(v, "src/shared/" .. v.Name .. ".rbxmx")
	end
end

for _, v in ipairs(server:GetChildren()) do
	if
		not (
			v.ClassName == "Script"
			or v.ClassName == "LocalScript"
			or v.ClassName == "ModuleScript"
			or v.ClassName == "Folder"
		)
	then
		remodel.writeModelFile(v, "src/server/" .. v.Name .. ".rbxmx")
	end
end
