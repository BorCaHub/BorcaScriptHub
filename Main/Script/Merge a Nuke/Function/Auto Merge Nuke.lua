local RunService = game:GetService("RunService")
local AutoMergeNuke = {}

local autoMergeEnabled = false
local autoMergeConnection

local function safeGetChildren(parent)
    local ok, children = pcall(function()
        return parent:GetChildren()
    end)
    return ok and children or {}
end

local function safeFindFirstChild(parent, name)
    local ok, child = pcall(function()
        return parent:FindFirstChild(name)
    end)
    return ok and child or nil
end

local function findMergeTarget()
    local names = {"Nuke", "MergeNuke", "AutoMergeTarget"}
    for _, name in ipairs(names) do
        local target = safeFindFirstChild(workspace, name)
        if target then
            return target
        end
    end

    local queue = safeGetChildren(workspace)
    while #queue > 0 do
        local node = table.remove(queue, 1)
        if node.Name == "Nuke" or node.Name == "MergeNuke" or node.Name == "AutoMergeTarget" then
            return node
        end
        for _, child in ipairs(safeGetChildren(node)) do
            table.insert(queue, child)
        end
    end

    return nil
end

local function sendMergeAction(target)
    if not target then
        return false
    end

    local mergeEvent = target:FindFirstChild("MergeEvent")
    if mergeEvent and mergeEvent:IsA("RemoteEvent") then
        mergeEvent:FireServer()
        return true
    end

    -- Jika gamenya memiliki tombol atau part khusus untuk merge, ganti logika ini.
    local mergePart = target:FindFirstChild("MergePart")
    if mergePart and mergePart:IsA("BasePart") then
        -- Contoh placeholder: jika ada event dan method khusus, panggil di sini.
        -- mergePart:FireClick()   -- Ganti dengan aksi game sebenarnya
        return true
    end

    return false
end

function AutoMergeNuke.DebugScan()
    local results = {}
    local function walk(node)
        for _, child in ipairs(safeGetChildren(node)) do
            local className = child.ClassName
            if className == "RemoteEvent" or className == "RemoteFunction" then
                table.insert(results, {
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Class = className
                })
            end
            walk(child)
        end
    end

    pcall(function()
        walk(workspace)
    end)

    return results
end

function AutoMergeNuke.SetEnabled(value)
    autoMergeEnabled = value and true or false
    print("Auto Merge Nuke", autoMergeEnabled and "enabled" or "disabled")

    if autoMergeEnabled and not autoMergeConnection then
        autoMergeConnection = RunService.Heartbeat:Connect(function()
            AutoMergeNuke.Execute()
        end)
        print("AutoMergeNuke: Heartbeat connected")
    elseif not autoMergeEnabled and autoMergeConnection then
        autoMergeConnection:Disconnect()
        autoMergeConnection = nil
        print("AutoMergeNuke: Heartbeat disconnected")
    end
end

function AutoMergeNuke.IsEnabled()
    return autoMergeEnabled
end

function AutoMergeNuke.Execute()
    print("AutoMergeNuke: Execute called")
    local target = findMergeTarget()
    if not target then
        warn("AutoMergeNuke: target merge tidak ditemukan")
        return
    end
    print("AutoMergeNuke: found target", target:GetFullName())

    local success = sendMergeAction(target)
    if success then
        print("AutoMergeNuke: merge action dispatched")
    else
        warn("AutoMergeNuke: belum ada aksi merge yang diimplementasikan untuk target " .. target.Name)
    end
end

return AutoMergeNuke
