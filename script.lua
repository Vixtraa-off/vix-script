-- Charger Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Créer la fenêtre principale
local Window = Rayfield:CreateWindow({
    Name = "Menu Éducatif - Utilitaires",
    Icon = 0,
    LoadingTitle = "Chargement du Menu...",
    LoadingSubtitle = "Par Sirius",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "Utilitaires"
    },
    Discord = {
       Enabled = false,
       Invite = "",
       RememberJoins = true
    },
    KeySystem = false
})

-- Créer l'onglet Utilitaires
local Tab = Window:CreateTab("Utilitaires", 4483362458)

-- Variables pour Fly et Noclip
local flying = false
local noclipping = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera
local flySpeed = 50
local flyConnection
local noclipConnection

-- Fonction pour activer/désactiver Fly
local function toggleFly()
    if not flying then
        flying = true

        local bodyGyro = Instance.new("BodyGyro", humanoidRootPart)
        local bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
        bodyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
        bodyGyro.CFrame = humanoidRootPart.CFrame
        bodyVelocity.MaxForce = Vector3.new(9e4, 9e4, 9e4)
        bodyVelocity.Velocity = Vector3.zero

        flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local moveDirection = Vector3.zero
            local input = game:GetService("UserInputService")

            if input:IsKeyDown(Enum.KeyCode.Z) then
                moveDirection = moveDirection + camera.CFrame.LookVector
            end
            if input:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - camera.CFrame.LookVector
            end
            if input:IsKeyDown(Enum.KeyCode.Q) then
                moveDirection = moveDirection - camera.CFrame.RightVector
            end
            if input:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + camera.CFrame.RightVector
            end
            if input:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if input:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end

            moveDirection = moveDirection.Unit * flySpeed
            bodyVelocity.Velocity = moveDirection
            bodyGyro.CFrame = camera.CFrame
        end)

        Rayfield:Notify({
            Title = "Fly Activé",
            Content = "Vous pouvez maintenant voler.",
            Duration = 5
        })
    else
        flying = false
        if flyConnection then flyConnection:Disconnect() end
        humanoidRootPart:FindFirstChildOfClass("BodyGyro"):Destroy()
        humanoidRootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()

        Rayfield:Notify({
            Title = "Fly Désactivé",
            Content = "Le vol a été désactivé.",
            Duration = 5
        })
    end
end

-- Fonction pour activer/désactiver Noclip
local function toggleNoclip()
    if not noclipping then
        noclipping = true

        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if noclipping then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)

        Rayfield:Notify({
            Title = "Noclip Activé",
            Content = "Vous pouvez maintenant traverser les murs.",
            Duration = 5
        })
    else
        noclipping = false
        if noclipConnection then noclipConnection:Disconnect() end

        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end

        Rayfield:Notify({
            Title = "Noclip Désactivé",
            Content = "Vous ne pouvez plus traverser les murs.",
            Duration = 5
        })
    end
end

-- Bouton pour Fly
Tab:CreateButton({
    Name = "Activer/Désactiver Fly",
    Callback = function()
        toggleFly()
    end
})

-- Bouton pour Noclip
Tab:CreateButton({
    Name = "Activer/Désactiver Noclip",
    Callback = function()
        toggleNoclip()
    end
})
