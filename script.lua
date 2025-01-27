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
local bodyGyro, bodyVelocity

-- Fonction pour activer Fly
local function fly(speed)
    if not flying then
        flying = true
        bodyGyro = Instance.new("BodyGyro")
        bodyVelocity = Instance.new("BodyVelocity")
        
        bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        bodyGyro.CFrame = humanoidRootPart.CFrame
        bodyGyro.Parent = humanoidRootPart
        
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        bodyVelocity.Velocity = Vector3.new(0, speed, 0)
        bodyVelocity.Parent = humanoidRootPart
        
        Rayfield:Notify({
            Title = "Fly Activé",
            Content = "Vous pouvez maintenant voler.",
            Duration = 5
        })
    else
        Rayfield:Notify({
            Title = "Fly déjà actif",
            Content = "Désactivez d'abord Fly avant de le réactiver.",
            Duration = 5
        })
    end
end

-- Fonction pour désactiver Fly
local function unfly()
    if flying then
        flying = false
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
        
        Rayfield:Notify({
            Title = "Fly Désactivé",
            Content = "Le vol a été désactivé.",
            Duration = 5
        })
    else
        Rayfield:Notify({
            Title = "Fly Inactif",
            Content = "Fly est déjà désactivé.",
            Duration = 5
        })
    end
end

-- Fonction pour activer Noclip
local function noclip()
    if not noclipping then
        noclipping = true
        humanoidRootPart.CanCollide = false
        Rayfield:Notify({
            Title = "Noclip Activé",
            Content = "Vous pouvez maintenant traverser les objets.",
            Duration = 5
        })
    else
        Rayfield:Notify({
            Title = "Noclip déjà actif",
            Content = "Désactivez d'abord Noclip avant de le réactiver.",
            Duration = 5
        })
    end
end

-- Fonction pour désactiver Noclip
local function unnoclip()
    if noclipping then
        noclipping = false
        humanoidRootPart.CanCollide = true
        Rayfield:Notify({
            Title = "Noclip Désactivé",
            Content = "Vous ne pouvez plus traverser les objets.",
            Duration = 5
        })
    else
        Rayfield:Notify({
            Title = "Noclip Inactif",
            Content = "Noclip est déjà désactivé.",
            Duration = 5
        })
    end
end

-- Ajouter le slider Fly et Unfly
Tab:CreateSlider({
    Name = "Fly (Vitesse)",
    Range = {0, 100},
    Increment = 10,
    Suffix = "vitesse",
    CurrentValue = 0,
    Flag = "FlySlider",
    Callback = function(Value)
        if Value > 0 then
            fly(Value)
        else
            unfly()
        end
    end,
})

-- Ajouter le slider Noclip et Unnoclip
Tab:CreateSlider({
    Name = "Noclip",
    Range = {0, 1},
    Increment = 1,
    Suffix = "On/Off",
    CurrentValue = 0,
    Flag = "NoclipSlider",
    Callback = function(Value)
        if Value == 1 then
            noclip()
        else
            unnoclip()
        end
    end,
})
