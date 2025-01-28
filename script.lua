-- Définir les clés valides
local validKeys = {
    "vixscript"
}

-- Fonction pour vérifier la clé
local function isKeyValid(inputKey)
    for _, key in pairs(validKeys) do
        if inputKey == key then
            return true
        end
    end
    return false
end

-- Charger Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Créer une fenêtre pour le Key System
local KeyWindow = Rayfield:CreateWindow({
    Name = "Système de Clé - Accès Menu",
    Icon = 0,
    LoadingTitle = "Chargement du Système de Clé",
    LoadingSubtitle = "Par vixtraa.",
    Theme = "Default",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

-- Onglet pour entrer la clé
local KeyTab = KeyWindow:CreateTab("Entrer la Clé", 4483362458)

KeyTab:CreateInput({
    Name = "Clé d'Accès",
    PlaceholderText = "Entrez votre clé ici",
    RemoveTextAfterFocusLost = true,
    Callback = function(inputKey)
        if isKeyValid(inputKey) then
            Rayfield:Notify({
                Title = "Accès Accordé",
                Content = "Clé correcte, accès au menu autorisé.",
                Duration = 5
            })

            KeyWindow:Destroy() -- Ferme la fenêtre de clé
            loadMainMenu() -- Charge le menu principal
        else
            Rayfield:Notify({
                Title = "Accès Refusé",
                Content = "Clé incorrecte, veuillez réessayer.",
                Duration = 5
            })
        end
    end
})

-- Fonction pour charger le menu principal après validation
function loadMainMenu()
    local Window = Rayfield:CreateWindow({
        Name = "Vix'Script - Menu",
        Icon = 0,
        LoadingTitle = "Chargement du Menu...",
        LoadingSubtitle = "Par vixtraa.",
        Theme = "Amber Glow",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "vixscript",
            FileName = "Utilities"
        },
        KeySystem = false
    })

    local Tab = Window:CreateTab("Utilitaires", 4483362458)

    -- Ajoutez vos fonctionnalités ici (Fly, Noclip, etc.)
    local flying = false
    local noclipping = false

    Tab:CreateButton({
        Name = "Activer/Désactiver Fly",
        Callback = function()
            -- Votre code Fly ici
            flying = not flying
            if flying then
                Rayfield:Notify({ Title = "Fly Activé", Content = "Vous volez maintenant.", Duration = 5 })
            else
                Rayfield:Notify({ Title = "Fly Désactivé", Content = "Vous avez arrêté de voler.", Duration = 5 })
            end
        end
    })

    Tab:CreateButton({
        Name = "Activer/Désactiver Noclip",
        Callback = function()
            -- Votre code Noclip ici
            noclipping = not noclipping
            if noclipping then
                Rayfield:Notify({ Title = "Noclip Activé", Content = "Vous pouvez traverser les murs.", Duration = 5 })
            else
                Rayfield:Notify({ Title = "Noclip Désactivé", Content = "Vous ne pouvez plus traverser les murs.", Duration = 5 })
            end
        end
    })
end
