-- Baixar a Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Criar a Janela
local Window = Rayfield:CreateWindow({
    Name = "Script de Voo Roblox",
    LoadingTitle = "Fly Script",
    LoadingSubtitle = "by mika2w",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Variáveis do Fly
local flying = false
local speed = 50
local bodyGyro, bodyVelocity

-- Função para ativar o voo
function startFly()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:WaitForChild("HumanoidRootPart")

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.cframe = humanoidRootPart.CFrame
    bodyGyro.Parent = humanoidRootPart

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.velocity = Vector3.new(0, 0, 0)
    bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = humanoidRootPart

    flying = true

    game:GetService("RunService").RenderStepped:Connect(function()
        if flying then
            bodyVelocity.velocity = workspace.CurrentCamera.CFrame.lookVector * speed
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        end
    end)
end

-- Função para parar o voo
function stopFly()
    flying = false
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
end

-- Criar botão na UI
Rayfield:CreateButton({
    Name = "Ativar/Desativar Voo",
    Callback = function()
        if flying then
            stopFly()
            Rayfield:Notify({
                Title = "Fly Script",
                Content = "Voo Desativado",
                Duration = 3
            })
        else
            startFly()
            Rayfield:Notify({
                Title = "Fly Script",
                Content = "Voo Ativado",
                Duration = 3
            })
        end
    end,
})
