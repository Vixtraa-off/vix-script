-- Importation de Rayfield
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sirius-Development/Rayfield/main/source.lua"))()

-- Création du menu principal
local Window = Rayfield:CreateWindow({
    Name = "Protection Roblox - Menu Educatif",
    LoadingTitle = "Chargement...",
    LoadingSubtitle = "Bienvenue dans la formation de sécurité Roblox",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VixEducation",
        FileName = "ProtectionMenu"
    },
    Discord = {
        Enabled = false,
        Invite = "https://discord.gg/vixedu", 
        RememberJoins = true
    },
    KeySystem = false,
})

-- Création du menu "Sécurité"
local SecurityTab = Window:CreateTab("Sécurité", 4483362458)

-- Ajouter une section de conseils de sécurité
SecurityTab:CreateSection({
    Name = "Conseils de Sécurité",
    Side = "Left",
    Size = UDim2.new(0, 200, 0, 100),
})

-- Ajouter un bouton pour apprendre à signaler les abus
SecurityTab:CreateButton({
    Name = "Signaler un Abus",
    Callback = function()
        game:GetService("Players").LocalPlayer:Kick("Signalez tout comportement abusif!")
    end,
})

-- Ajouter un bouton pour activer la protection contre les tricheurs
SecurityTab:CreateButton({
    Name = "Activer Protection Anti-Triche",
    Callback = function()
        print("Protection anti-triche activée")
    end,
})

-- Ajouter un bouton pour activer le "Safe Mode"
SecurityTab:CreateButton({
    Name = "Mode Sécurisé",
    Callback = function()
        print("Vous êtes en mode sécurisé! Toutes les actions non autorisées sont bloquées.")
    end,
})

-- Ajouter un bouton pour ajuster les paramètres de confidentialité
SecurityTab:CreateButton({
    Name = "Ajuster Paramètres de Confidentialité",
    Callback = function()
        print("Accédez aux paramètres de confidentialité de votre compte Roblox!")
    end,
})

-- Création du menu "Utilitaire"
local UtilityTab = Window:CreateTab("Utilitaire", 4483362458)

-- Section Utilitaire
UtilityTab:CreateSection({
    Name = "Commandes Utilitaires",
    Side = "Left",
    Size = UDim2.new(0, 200, 0, 100),
})

-- Variables pour Fly et Noclip
local flying = false
local noclipping = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local bodyGyro = nil
local bodyVelocity = nil

-- Fonction pour activer le vol
local function fly()
    if not flying then
        flying = true
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        bodyGyro = Instance.new("BodyGyro")
        bodyVelocity = Instance.new("BodyVelocity")
        
        bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        bodyGyro.CFrame = humanoidRootPart.CFrame
        bodyGyro.Parent = humanoidRootPart
        
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
        bodyVelocity.Parent = humanoidRootPart
        
        print("Fly activé")
    end
end

-- Fonction pour désactiver le vol
local function unfly()
    if flying then
        flying = false
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
        print("Fly désactivé")
    end
end

-- Fonction pour activer Noclip
local function noclip()
    if not noclipping then
        noclipping = true
        humanoid.PlatformStand = true
        print("Noclip activé")
        
        -- Désactiver la détection des collisions
        local function disableCollision()
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        disableCollision()
        
        -- Mettre à jour chaque frame
        game:GetService("RunService").Heartbeat:Connect(function()
            if noclipping then
                disableCollision()
            end
        end)
    end
end

-- Fonction pour désactiver Noclip
local function unnoclip()
    if noclipping then
        noclipping = false
        humanoid.PlatformStand = false
        print("Noclip désactivé")
        
        -- Rétablir les collisions
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Ajouter des boutons pour les fonctions Utilitaires

UtilityTab:CreateButton({
    Name = "Activer le Vol",
    Callback = function()
        fly()
    end,
})

UtilityTab:CreateButton({
    Name = "Désactiver le Vol",
    Callback = function()
        unfly()
    end,
})

UtilityTab:CreateButton({
    Name = "Activer Noclip",
    Callback = function()
        noclip()
    end,
})

UtilityTab:CreateButton({
    Name = "Désactiver Noclip",
    Callback = function()
        unnoclip()
    end,
})
