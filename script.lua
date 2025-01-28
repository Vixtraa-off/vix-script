-- Charger Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Créer la fenêtre principale
local Window = Rayfield:CreateWindow({
    Name = "Vix'Script - Menu",
    Icon = 0,
    LoadingTitle = "Chargement du Menu...",
    LoadingSubtitle = "Par vixtraa.",
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

-- Variables globales
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local flying = false
local noclipping = false
local flyConnection, noclipConnection
local flySpeed = 50 -- Ajustez la vitesse de vol

-- Fonction pour Fly
local function toggleFly()
    if not flying then
        flying = true

        -- Ajouter des forces de mouvement pour Fly
        local bodyGyro = Instance.new("BodyGyro", humanoidRootPart)
        bodyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
        bodyGyro.P = 9e4
        bodyGyro.CFrame = humanoidRootPart.CFrame

        local bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
        bodyVelocity.MaxForce = Vector3.new(9e4, 9e4, 9e4)
        bodyVelocity.Velocity = Vector3.zero

        -- Gérer le déplacement avec les touches
        flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local direction = Vector3.zero
            local input = game:GetService("UserInputService")

            if input:IsKeyDown(Enum.KeyCode.Z) then
                direction += workspace.CurrentCamera.CFrame.LookVector
            end
            if input:IsKeyDown(Enum.KeyCode.S) then
                direction -= workspace.CurrentCamera.CFrame.LookVector
            end
            if input:IsKeyDown(Enum.KeyCode.Q) then
                direction -= workspace.CurrentCamera.CFrame.RightVector
            end
            if input:IsKeyDown(Enum.KeyCode.D) then
                direction += workspace.CurrentCamera.CFrame.RightVector
            end
            if input:IsKeyDown(Enum.KeyCode.Space) then
                direction += Vector3.new(0, 1, 0)
            end
            if input:IsKeyDown(Enum.KeyCode.LeftShift) then
                direction -= Vector3.new(0, 1, 0)
            end

            -- Appliquer la vitesse et l'orientation
            direction = direction.Unit * flySpeed
            bodyVelocity.Velocity = direction
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        end)

        Rayfield:Notify({
            Title = "Fly Activé",
            Content = "Vous pouvez maintenant voler librement.",
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

-- Fonction pour Noclip
local function toggleNoclip()
    if not noclipping then
        noclipping = true

        -- Désactiver les collisions des parties du personnage
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
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

        -- Réactiver les collisions des parties du personnage
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
