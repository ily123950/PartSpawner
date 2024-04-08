local character = game:GetService("Players").LocalPlayer.Character
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

if humanoidRootPart then
    local characterPosition = humanoidRootPart.Position

    for i = 1, 16 do
        local args = {
            [1] = "CreatePart",
            [2] = "Normal",
            [3] = CFrame.new(characterPosition),
            [4] = workspace
        }

        game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint:InvokeServer(unpack(args))
        wait(0.1)
    end

    wait(0.1)

    local partsToColor = {}

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Position == characterPosition then
            table.insert(partsToColor, {
                ["Part"] = obj,
                ["UnionColoring"] = true,
                ["Color"] = Color3.new(1, 0, 0)
            })
        end
    end

    local argsColor = {
        [1] = "SyncColor",
        [2] = partsToColor
    }

    game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint:InvokeServer(unpack(argsColor))

    wait(0.1)

    local partsToUnanchor = {}

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Color == Color3.new(1, 0, 0) then
            table.insert(partsToUnanchor, {
                ["Part"] = obj,
                ["Anchored"] = false
            })
        end
    end

    local argsUnanchor = {
        [1] = "SyncAnchor",
        [2] = partsToUnanchor
    }

    game:GetService("Players").LocalPlayer.Backpack.Folder.SyncAPI.ServerEndpoint:InvokeServer(unpack(argsUnanchor))
end
