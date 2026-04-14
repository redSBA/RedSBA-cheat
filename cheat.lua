-- =============================================
-- redSBA cheat — Полная версия (NoClip + Анимации меню + Анимации нажатий)
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

local infiniteJumpEnabled = false
local speedEnabled = false
local noclipEnabled = false

local speedValue = 50
local VIDEO_LINK = "https://photos.app.goo.gl/c3DgsxY1s3DJDDSZ7"

local gui = Instance.new("ScreenGui")
gui.Name = "redSBAcheat"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ==================== КРАСНОЕ МЕНЮ ====================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 380)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = gui

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(255, 0, 0)
border.Thickness = 4
border.Parent = mainFrame

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "redSBA cheat"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local orangeLine = Instance.new("Frame")
orangeLine.Size = UDim2.new(0, 40, 0, 4)
orangeLine.Position = UDim2.new(1, -55, 0, 18)
orangeLine.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
orangeLine.Parent = titleBar

-- Кнопка −
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
minimizeBtn.Position = UDim2.new(1, -45, 0, 3)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 180, 0)
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = titleBar

-- Мини-иконка
local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(0, 90, 0, 90)
miniFrame.Position = UDim2.new(1, -110, 1, -110)
miniFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
miniFrame.BorderSizePixel = 0
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.Visible = false
miniFrame.Parent = gui

Instance.new("UICorner", miniFrame).CornerRadius = UDim.new(0, 20)

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(1, -20, 1, -20)
openBtn.Position = UDim2.new(0, 10, 0, 10)
openBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
openBtn.Text = "Открыть"
openBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
openBtn.TextScaled = true
openBtn.Font = Enum.Font.GothamBold
openBtn.Parent = miniFrame
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 15)

-- ======================= Кнопки с анимацией нажатия =======================
local y = 55

local function createButton(text, isToggle)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btn.Text = text .. (isToggle and ": OFF" or "")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = mainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    -- Анимация нажатия
    local originalSize = btn.Size
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0.85, 0, 0, 46)
        }):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Size = originalSize
        }):Play()
    end)

    y = y + 60
    return btn
end

local infJumpBtn = createButton("Бесконечные прыжки", true)
local speedBtn   = createButton("Скорость", true)
local noclipBtn  = createButton("NoClip", true)
local reviewBtn  = createButton("Обзор скрипта", false)

reviewBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)

-- Поле скорости
local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.4, 0, 0, 40)
speedInput.Position = UDim2.new(0.55, 0, 0, 130)
speedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
speedInput.Text = "50"
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextScaled = true
speedInput.Font = Enum.Font.Gotham
speedInput.Parent = mainFrame
Instance.new("UICorner", speedInput).CornerRadius = UDim.new(0, 8)

-- Надпись создателя
local creatorLabel = Instance.new("TextLabel")
creatorLabel.Size = UDim2.new(1, 0, 0, 20)
creatorLabel.Position = UDim2.new(0, 0, 1, -25)
creatorLabel.BackgroundTransparency = 1
creatorLabel.Text = "redSBA (redSBA_team)"
creatorLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
creatorLabel.TextScaled = true
creatorLabel.Font = Enum.Font.Gotham
creatorLabel.Parent = mainFrame

-- ======================= АНИМАЦИИ ОТКРЫТИЯ/ЗАКРЫТИЯ МЕНЮ =======================
local tweenPop = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenShrink = TweenInfo.new(0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function showMain()
    mainFrame.Visible = true
    mainFrame.Size = UDim2.new(0, 220, 0, 220)
    TweenService:Create(mainFrame, tweenPop, {Size = UDim2.new(0, 320, 0, 380)}):Play()
end

local function hideMain()
    local tween = TweenService:Create(mainFrame, tweenShrink, {Size = UDim2.new(0, 220, 0, 220)})
    tween:Play()
    tween.Completed:Connect(function()
        mainFrame.Visible = false
    end)
end

-- ======================= ИСПРАВЛЕННЫЙ NOCLIP =======================
local noclipConnection = nil

local function toggleNoClip()
    if noclipEnabled then
        if noclipConnection then noclipConnection:Disconnect() end

        noclipConnection = RunService.RenderStepped:Connect(function()
            local character = player.Character
            if not character then return end

            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end

        local character = player.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- ======================= Логика кнопок =======================
local function updateButtonColor(btn, isOn)
    btn.BackgroundColor3 = isOn and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(200, 50, 50)
end

infJumpBtn.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    infJumpBtn.Text = "Бесконечные прыжки: " .. (infiniteJumpEnabled and "ON" or "OFF")
    updateButtonColor(infJumpBtn, infiniteJumpEnabled)
end)

speedBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    speedBtn.Text = "Скорость: " .. (speedEnabled and "ON" or "OFF")
    updateButtonColor(speedBtn, speedEnabled)
end)

noclipBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipBtn.Text = "NoClip: " .. (noclipEnabled and "ON" or "OFF")
    updateButtonColor(noclipBtn, noclipEnabled)
    toggleNoClip()
end)

reviewBtn.MouseButton1Click:Connect(function()
    setclipboard(VIDEO_LINK)

    StarterGui:SetCore("SendNotification", {
        Title = "redSBA cheat";
        Text = "Ссылка скопирована!\nВставь её в браузер.";
        Duration = 5;
    })

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://131057176"
    sound.Volume = 0.7
    sound.Parent = workspace
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end)

speedInput.FocusLost:Connect(function()
    local val = tonumber(speedInput.Text)
    if val and val > 0 then speedValue = val end
    speedInput.Text = tostring(speedValue)
end)

-- Сворачивание / разворачивание с анимацией
minimizeBtn.MouseButton1Click:Connect(function()
    hideMain()
    task.wait(0.35)
    miniFrame.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    miniFrame.Visible = false
    showMain()
end)

-- Основные функции
RunService.Heartbeat:Connect(function()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = speedEnabled and speedValue or 16
    end
end)

UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Показ меню с анимацией
task.wait(0.2)
showMain()

StarterGui:SetCore("SendNotification", {
    Title = "redSBA cheat";
    Text = "Скрипт успешно загружен!\nАвтор: redSBA (redSBA_team)";
    Duration = 5;
})

print("✅ redSBA cheat загружен с анимациями меню и исправленным NoClip!")
