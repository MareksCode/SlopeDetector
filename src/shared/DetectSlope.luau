--!strict
type SlopeResult = {
    slopeDetected: boolean,
    slopeHeight: number
}
local DEBUG_MODE = true :: boolean

return function(targetPart: Part, filterInstances: {Instance}?, scanHeight: number?, scanWidth: number?) : SlopeResult
    if not filterInstances then filterInstances = {targetPart} end
    if scanHeight == nil or typeof(scanHeight) ~= "number" then scanHeight = 12 end
    if scanWidth == nil or typeof(scanWidth) ~= "number" then scanWidth = 1 end

    local lookVector = targetPart.CFrame.LookVector :: Vector3
    local mid = targetPart.CFrame.Position :: Vector3
    local front = mid + lookVector * scanWidth :: Vector3

    local rayParams = RaycastParams.new() :: RaycastParams
    rayParams.FilterDescendantsInstances = filterInstances
    
    local rayMid = workspace:Raycast(mid, Vector3.new(0,-scanHeight,0), rayParams) :: RaycastResult?
    local rayToFront = workspace:Raycast(mid, lookVector * scanWidth, rayParams)
    local rayFront = workspace:Raycast(front, Vector3.new(0,-scanHeight,0), rayParams) :: RaycastResult?

    if not rayMid or not rayFront then
        return {
            slopeDetected = false, 
            slopeHeight = 0
        }
    end

    if DEBUG_MODE then --Debug visuals
        local p1 = workspace:FindFirstChild("p1") or Instance.new("Part")
        p1.Size = Vector3.new(.1,.1,.1)
        p1.Name = "p1"
        p1.Material = Enum.Material.Neon
        p1.Anchored = true
        p1.Parent = workspace
        p1.Color = Color3.fromRGB(0,255,0)
        p1.CanCollide = false
        p1.CanQuery = false
        p1.CanTouch = false
        local p2 = workspace:FindFirstChild("p2") or Instance.new("Part")
        p2.Size = Vector3.new(.1,.1,.1)
        p2.Name = "p2"
        p2.Material = Enum.Material.Neon
        p2.Anchored = true
        p2.Parent = workspace
        p2.Color = Color3.fromRGB(0,255,0)
        p2.CanCollide = false
        p2.CanQuery = false
        p2.CanTouch = false

        local e1 = workspace:FindFirstChild("e1") or Instance.new("Part")
        e1.Size = Vector3.new(.1,.1,.1)
        e1.Name = "e1"
        e1.Material = Enum.Material.Neon
        e1.Anchored = true
        e1.Parent = workspace
        e1.Color = Color3.fromRGB(0,100,255)
        e1.CanCollide = false
        e1.CanQuery = false
        e1.CanTouch = false
        local e2 = workspace:FindFirstChild("e2") or Instance.new("Part")
        e2.Size = Vector3.new(.1,.1,.1)
        e2.Name = "e2"
        e2.Material = Enum.Material.Neon
        e2.Anchored = true
        e2.Parent = workspace
        e2.Color = Color3.fromRGB(0,100,255)
        e2.CanCollide = false
        e2.CanQuery = false
        e2.CanTouch = false

        p1.Position = mid
        p2.Position = front
        e1.Position = rayMid.Position
        e2.Position = rayFront.Position
    end

    if rayToFront then --Object in front of the character; ignore rayFront result
        print("object in front")
        rayFront = rayToFront
    end

    return {
        slopeDetected = true, 
        slopeHeight = rayFront.Position.Y - rayMid.Position.Y
    }
end