type SlopeResult = {
    slopeDetected: boolean,
    slopeHeight: number
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DetectSlope = require(ReplicatedStorage.Shared.DetectSlope)

local Player = Players.LocalPlayer

local debugUI = Instance.new("ScreenGui")
debugUI.Parent = Player.PlayerGui
local debugTextLabel = Instance.new("TextLabel", debugUI)
debugTextLabel.AnchorPoint = Vector2.new(.5,.5)
debugTextLabel.Position = UDim2.new(.5,0, .85,0)
debugTextLabel.TextScaled = true
debugTextLabel.Size = UDim2.new(1, 0, .09, 0)
debugTextLabel.BackgroundTransparency = 1
debugTextLabel.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UIStroke", debugTextLabel)

while true do
    task.wait(0.05)
    if Player.Character == nil then continue end

    local humRootPart = Player.Character:FindFirstChild("HumanoidRootPart")
    if humRootPart == nil then continue end

    local slopeResult = DetectSlope(humRootPart, {Player.Character})
    if slopeResult.slopeDetected then
        debugTextLabel.Text = slopeResult.slopeHeight
    else
        debugTextLabel.Text = ""
    end
end
