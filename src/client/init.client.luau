type SlopeResult = {
    slopeDetected: boolean,
    slopeHeight: number
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DetectSlope = require(ReplicatedStorage.Shared.DetectSlope)

local Player = Players.LocalPlayer

while true do
    task.wait(0.05)
    if Player.Character == nil then continue end

    local humRootPart = Player.Character:FindFirstChild("HumanoidRootPart")
    if humRootPart == nil then continue end

    local slopeResult = DetectSlope(humRootPart)
    if slopeResult.slopeDetected then
        print(slopeResult.slopeHeight)
    else
        print("in the air")
    end
end
