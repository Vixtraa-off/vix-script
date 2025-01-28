-- Charger Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Créer la fenêtre principale avec KeySystem activé
local Window = Rayfield:CreateWindow({
    Name = "Vix'Script - Menu",
    Icon = 0, -- Pas d'icône, remplacez par un ID si nécessaire
    LoadingTitle = "Chargement du Menu...",
    LoadingSubtitle = "Par Vixtraa.",
    Theme = "Default",
    KeySystem = true, -- Activation du système de clé
    KeySettings = {
        Title = "Vix'Script KeySystem",
        Subtitle = "Accès Sécurisé",
        Note = "Rejoignez le Discord (discord.gg/vixscript)",
        FileName = "VixScriptKey",
        SaveKey = false, -- N'enregistre pas la clé localement
        GrabKeyFromSite = false, -- Changez pour true si vous utilisez un fichier en ligne
        Key = {"vixscript", "backupkey"}, -- Liste des clés acceptées
        Actions = {
            [1] = {
                Text = "Cliquez ici pour copier le lien de la clé",
                OnPress = function()
                    setclipboard("https://discord.gg/w92d9hnT2p") -- Remplacez par le lien réel pour obtenir une clé
                    Rayfield:Notify({
                        Title = "Lien Copié",
                        Content = "Le lien vers la clé a été copié dans votre presse-papier.",
                        Duration = 5,
                    })
                end,
            },
        },
    },
})

-- Onglet Utilitaires
local Tab = Window:CreateTab("Utilitaires", 4483362458)

-- Ajouter un bouton "Rejoindre le Discord"
Tab:CreateButton({
    Name = "Rejoindre le Discord",
    Callback = function()
        -- Ouvre le lien du Discord dans le navigateur
        setclipboard("https://discord.gg/w92d9hnT2p")  -- Copie le lien dans le presse-papier
        game:GetService("GuiService"):OpenBrowserWindow("https://discord.gg/w92d9hnT2p")  -- Ouvre le lien dans le navigateur

        -- Affiche une notification
        Rayfield:Notify({
            Title = "Discord",
            Content = "Le lien vers le Discord a été copié dans votre presse-papier. Vous pouvez aussi rejoindre directement en cliquant ici !",
            Duration = 5,
        })
    end,
})

-- Gestion du Fly
local flying = false
local bodyVelocity = nil
local bodyGyro = nil

Tab:CreateButton({
    Name = "Activer/Désactiver Fly",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        if flying then
            -- Désactiver le vol
            if bodyVelocity then
                bodyVelocity:Destroy()
                bodyVelocity = nil
            end
            if bodyGyro then
                bodyGyro:Destroy()
                bodyGyro = nil
            end
            flying = false
            Rayfield:Notify({
                Title = "Fly Désactivé",
                Content = "Le vol a été désactivé. Vous êtes revenu au sol.",
                Duration = 5,
            })
        else
            -- Activer le vol
            flying = true

            -- Créer un BodyVelocity pour permettre le vol
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Monte initialement
            bodyVelocity.Parent = humanoidRootPart

            -- Créer un BodyGyro pour éviter que le personnage ne bascule en l'air
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
            bodyGyro.CFrame = humanoidRootPart.CFrame
            bodyGyro.Parent = humanoidRootPart

            -- Mettre à jour la vitesse et la direction pendant le vol
            game:GetService("RunService").Heartbeat:Connect(function()
                if flying then
                    -- Maintenir le personnage dans les airs et l'empêcher de tomber
                    bodyVelocity.Velocity = humanoidRootPart.CFrame.LookVector * 50 -- Déplacement avant/arrière
                    bodyGyro.CFrame = humanoidRootPart.CFrame -- Maintenir l'orientation
                end
            end)

            Rayfield:Notify({
                Title = "Fly Activé",
                Content = "Vous volez maintenant. Utilisez ZQSD pour vous déplacer.",
                Duration = 5,
            })
        end
    end,
})

-- Gestion du Noclip
local noclipping = false
Tab:CreateButton({
    Name = "Activer/Désactiver Noclip",
    Callback = function()
        noclipping = not noclipping
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        if noclipping then
            game:GetService("RunService").Stepped:Connect(function()
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
                Duration = 5,
            })
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and not part.CanCollide then
                    part.CanCollide = true
                end
            end
            Rayfield:Notify({
                Title = "Noclip Désactivé",
                Content = "Vous ne pouvez plus traverser les murs.",
                Duration = 5,
            })
        end
    end,
})

-- Gestion du Respawn
Tab:CreateButton({
    Name = "Reset Personnage",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character

        if character then
            character:BreakJoints() -- Détruit les joints du personnage, ce qui provoque un respawn
            Rayfield:Notify({
                Title = "Personnage Réinitialisé",
                Content = "Votre personnage a été réinitialisé avec succès.",
                Duration = 5,
            })
        else
            Rayfield:Notify({
                Title = "Erreur",
                Content = "Impossible de réinitialiser le personnage.",
                Duration = 5,
            })
        end
    end,
})

-- Ajout d'autres fonctionnalités
Tab:CreateButton({
    Name = "Notification Exemple",
    Callback = function()
        Rayfield:Notify({
            Title = "Exemple de Notification",
            Content = "Vous avez cliqué sur le bouton d'exemple.",
            Duration = 5,
        })
    end,
})
