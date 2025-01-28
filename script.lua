-- Gestion du Fly
local flying = false
local bodyVelocity = nil
local bodyGyro = nil
local flyAnimation = nil
local humanoid = nil
local humanoidRootPart = nil

Tab:CreateButton({
    Name = "Activer/Désactiver Fly",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        humanoid = character:WaitForChild("Humanoid")
        humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Animation de vol
        if not flyAnimation then
            flyAnimation = Instance.new("Animation")
            flyAnimation.AnimationId = "rbxassetid://1234567890"  -- Remplacez par l'ID de l'animation de vol
        end

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
            humanoid:StopAnimations()  -- Arrêter l'animation de vol
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
            bodyVelocity.Velocity = Vector3.new(0, 50, 0)  -- Monte initialement
            bodyVelocity.Parent = humanoidRootPart

            -- Créer un BodyGyro pour éviter que le personnage ne bascule en l'air
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
            bodyGyro.CFrame = humanoidRootPart.CFrame
            bodyGyro.Parent = humanoidRootPart

            -- Appliquer l'animation de vol
            local flyTrack = humanoid:LoadAnimation(flyAnimation)
            flyTrack:Play()

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
