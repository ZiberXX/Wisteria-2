getgenv().autogourd = true
local item = "Large Gourd" -- Large Medium Small

local function checkGourd()
    for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Gui.Inventory.InventoryItems.Items:GetChildren()) do
        if string.find(v.Name, "Gourd") then
            return true
        end
    end
end

local function checkEquip()
    for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name, "Gourd") then
            return true
        end
    end
end

local function checkBH()
    for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
        if v.Name == "GourdKeys" then
            return true
        end
    end
end

----------------------------------------------------------------------------------------------

local function gourdActive()
    for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name, "Gourd") then
            return v:Activate()
        end
    end
end

local function pressBH()
    local keyMap = { 
        ["Y"] = Enum.KeyCode.Y,
        ["U"] = Enum.KeyCode.U,
        ["F"] = Enum.KeyCode.F,
        ["G"] = Enum.KeyCode.G,
        ["H"] = Enum.KeyCode.H,
        ["J"] = Enum.KeyCode.J
    }
    for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
        if v.Name == "GourdKeys" then
            return game:GetService("VirtualInputManager"):SendKeyEvent(true, keyMap[v.Frame.Key.Text], false, game)
        end
    end
end

----------------------------------------------------------------------------------------------

warn("-------------------------------")
while autogourd do task.wait()
    if checkGourd() then
        if checkEquip() then
            game:GetService("Players").LocalPlayer.Character.Scripts.Local.Breathe:FireServer(true)
    
            if checkBH() then
                repeat
                    pressBH()
                    task.wait(.1)
                until not checkBH()
            else
                -- Active Gourd
                gourdActive()
            end
        else
            -- Equip Gourd
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Usetool"):FireServer("Equip", item)
            task.wait(.6)
        end
    else
        -- Buy Gourd
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Dialogue"):FireServer({
            ["Type"] = "End",
            ["Npc"] = workspace:WaitForChild("Npcs"):WaitForChild("Jin"),
            ["Path"] = item
        })
        task.wait(2)
    end
end

if not autogourd then
    game:GetService("Players").LocalPlayer.Character.Scripts.Local.Breathe:FireServer(false)
end