-- Presets de Visual (Configurações com efeitos como Bloom, DOF, etc)
local function createEffects()
    local lighting = game:GetService("Lighting")
    local effects = {}

    -- Efeito de Blur
    effects.Blur = Instance.new("BlurEffect")
    effects.Blur.Size = 2
    effects.Blur.Name = "TryhardBlur"

    -- Efeito de Color Correction (Brilho, Saturação e Contraste)
    effects.ColorCorrection = Instance.new("ColorCorrectionEffect")
    effects.ColorCorrection.Brightness = 0.1
    effects.ColorCorrection.Saturation = 0.2
    effects.ColorCorrection.Contrast = 0.12
    effects.ColorCorrection.Name = "TryhardColor"

    -- Efeito de Sun Rays (efeito de luz solar)
    effects.SunRays = Instance.new("SunRaysEffect")
    effects.SunRays.Intensity = 0.08
    effects.SunRays.Spread = 0.25
    effects.SunRays.Name = "TryhardSun"

    -- Efeito de Bloom (brilho suave)
    effects.Bloom = Instance.new("BloomEffect")
    effects.Bloom.Intensity = 0.15
    effects.Bloom.Threshold = 0.9
    effects.Bloom.Size = 35
    effects.Bloom.Name = "TryhardBloom"

    -- Profundidade de Campo (Depth of Field)
    effects.DepthOfField = Instance.new("DepthOfFieldEffect")
    effects.DepthOfField.FarIntensity = 0.1
    effects.DepthOfField.FocusDistance = 51
    effects.DepthOfField.InFocusRadius = 200
    effects.DepthOfField.NearIntensity = 0.05
    effects.DepthOfField.Name = "TryhardDOF"

    return effects
end

-- Função para ativar os efeitos
local function applyEffects(effects)
    local lighting = game:GetService("Lighting")
    for _, effect in pairs(effects) do
        if not lighting:FindFirstChild(effect.Name) then
            effect:Clone().Parent = lighting
        end
    end
end

-- Função para remover os efeitos
local function removeEffects()
    local lighting = game:GetService("Lighting")
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("PostEffect") and v.Name:match("^Tryhard") then
            v:Destroy()
        end
    end
end

-- Interface gráfica para o menu de presets
local function createUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VisualMenu"
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0, 20, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BackgroundTransparency = 0.5
    frame.Parent = screenGui

    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 300, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "Visual Effects"
    title.TextSize = 24
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Parent = frame

    -- Botões de presets
    local buttonUltra = Instance.new("TextButton")
    buttonUltra.Size = UDim2.new(0, 280, 0, 50)
    buttonUltra.Position = UDim2.new(0, 10, 0, 70)
    buttonUltra.Text = "Ultra Effects"
    buttonUltra.TextSize = 20
    buttonUltra.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    buttonUltra.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonUltra.Parent = frame

    local buttonClean = Instance.new("TextButton")
    buttonClean.Size = UDim2.new(0, 280, 0, 50)
    buttonClean.Position = UDim2.new(0, 10, 0, 130)
    buttonClean.Text = "Clean Effects"
    buttonClean.TextSize = 20
    buttonClean.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    buttonClean.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonClean.Parent = frame

    local buttonNoir = Instance.new("TextButton")
    buttonNoir.Size = UDim2.new(0, 280, 0, 50)
    buttonNoir.Position = UDim2.new(0, 10, 0, 190)
    buttonNoir.Text = "Noir Effect"
    buttonNoir.TextSize = 20
    buttonNoir.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    buttonNoir.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonNoir.Parent = frame

    local buttonOff = Instance.new("TextButton")
    buttonOff.Size = UDim2.new(0, 280, 0, 50)
    buttonOff.Position = UDim2.new(0, 10, 0, 250)
    buttonOff.Text = "Turn Off Effects"
    buttonOff.TextSize = 20
    buttonOff.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    buttonOff.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonOff.Parent = frame

    -- Funções dos botões
    buttonUltra.MouseButton1Click:Connect(function()
        local effects = createEffects()
        applyEffects(effects)
    end)

    buttonClean.MouseButton1Click:Connect(function()
        -- Limpeza dos efeitos com menos intensidade
        local effects = createEffects()
        effects.Bloom.Intensity = 0.1
        effects.DepthOfField.FarIntensity = 0.05
        applyEffects(effects)
    end)

    buttonNoir.MouseButton1Click:Connect(function()
        -- Ajuste para efeito Noir (preto e branco)
        local effects = createEffects()
        effects.ColorCorrection.Saturation = -1
        effects.ColorCorrection.Contrast = 0.5
        effects.Bloom.Intensity = 0
        applyEffects(effects)
    end)

    buttonOff.MouseButton1Click:Connect(function()
        removeEffects()
    end)
end

-- Chama a interface gráfica
createUI()

-- Hotkey F5 para ativar o Ultra
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F5 then
        local effects = createEffects()
        applyEffects(effects)
    end
end)
