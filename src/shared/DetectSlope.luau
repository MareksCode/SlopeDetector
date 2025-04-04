--!strict
type SlopeResult = {
    slopeDetected: boolean,
    slopeHeight: number
}

return function(targetPart: Part, filterInstances: {any}?, scanHeight: number?, scanWidth: number?) : SlopeResult
    if not filterInstances then filterInstances = {targetPart} end
    if scanHeight == nil or typeof(scanHeight) ~= "number" then scanHeight = 10 end
    if scanWidth == nil or typeof(scanWidth) ~= "number" then scanWidth = 1 end

    local lookVector = targetPart.CFrame.LookVector :: Vector3
    local mid = targetPart.CFrame.Position :: Vector3
    local front = mid + lookVector :: Vector3

    local rayParams = RaycastParams.new() :: RaycastParams
    rayParams.FilterDescendantsInstances = {targetPart}
    
    local rayMid = workspace:Raycast(mid, Vector3.new(0,-scanHeight,0), rayParams) :: RaycastResult?
    local rayFront = workspace:Raycast(front, Vector3.new(0,-scanHeight,0), rayParams) :: RaycastResult?

    if not rayMid or not rayFront then
        return {
            slopeDetected = false, 
            slopeHeight = 0
        }
    end

    return {
        slopeDetected = true, 
        slopeHeight = rayFront.Position.Y - rayMid.Position.Y
    }
end