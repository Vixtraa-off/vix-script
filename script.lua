-- Charger Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Créer la fenêtre principale avec KeySystem activé
local Window = Rayfield:CreateWindow({
    Name = "Vix'Script - Menu avec KeySystem",
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
        GrabKeyFromSite = false, -- Changez pour `true` si vous utilisez un fichier en ligne
        Key = {"vixscript", "backupkey"}, -- Liste des clés acceptées
        Actions = {
            [1] = {
                Text = "Cliquez ici pour copier le lien de la clé",
                OnPress = function()
                    setclipboard("https://votre-site-ou-lien-cle.com") -- Remplacez par le lien réel pour obtenir une clé
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

-- Gestion du Fly
local flying = false
Tab:CreateButton({
    Name = "Activer/Désactiver Fly",
    Callback = function()
        flying = not flying
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local bodyVelocity = Instance.new("BodyVelocity")

        if flying then
            bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Monte initialement
            bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")
            Rayfield:Notify({
                Title = "Fly Activé",
                Content = "Vous volez maintenant. Utilisez ZQSD pour vous déplacer.",
                Duration = 5,
            })
        else
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
            Rayfield:Notify({
                Title = "Fly Désactivé",
                Content = "Vous avez arrêté de voler.",
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
