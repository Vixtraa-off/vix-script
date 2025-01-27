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

-- Variables
local flying = false
local noclipping = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera
local flySpeed = 50
local connection

-- Fonction pour Fly
local function toggleFly()
    if not flying then
        flying = true
        humanoidRootPart.Anchored = false
        humanoidRootPart.CanCollide = false

        connection = game:GetService("RunService").RenderStepped:Connect(function()
            local direction = Vector3.new()
            local move = player:GetMouse().KeyDown

            if move == "w" then direction += camera.CFrame.LookVector end
            if move == "s" then direction -= camera.CFrame.LookVector end
            if move == "a" then direction -= camera.CFrame.RightVector end
            if move == "d" then direction += camera.CFrame.RightVector end

            humanoidRootPart.Velocity = direction * flySpeed
        end)

        Rayfield:Notify({
            Title = "Fly Activé",
            Content = "Vous pouvez maintenant voler.",
            Duration = 5
        })
    else
        flying = false
        if connection then connection:Disconnect() end
        humanoidRootPart.Velocity = Vector3.zero

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
        game:GetService("RunService").Stepped:Connect(function()
            if noclipping then
                humanoidRootPart.CanCollide = false
            else
                humanoidRootPart.CanCollide = true
            end
        end)

        Rayfield:Notify({
            Title = "Noclip Activé",
            Content = "Vous pouvez traverser les murs.",
            Duration = 5
        })
    else
        noclipping = false
        humanoidRootPart.CanCollide = true

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
