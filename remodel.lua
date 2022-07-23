local game = remodel.readPlaceFile("build.rbxlx")

local shared = game.ReplicatedStorage["roblosploit-shared"]

for _, v in ipairs(shared:GetChildren()) do
    if not (v.ClassName == "Script" or v.ClassName == "LocalScript" or v.ClassName == "ModuleScript") then
        remodel.writeModelFile(v, "src/shared/" .. v.Name .. ".rbxmx")
    end
end