-- Função para criar os efeitos avançados (sem mudanças nos efeitos, apenas melhoria na interface)
local function createAdvancedEffects()
    local lighting = game:GetService("Lighting")
    local effects = {}

    -- Efeito de Blur
    effects.Blur = Instance.new("BlurEffect")
    effects.Blur.Size = 10  -- Aumentando o tamanho para um blur mais forte
    effects.Blur.Name = "AdvancedBlur"

    -- Efeito de Bloom (brilho suave)
    effects.Bloom = Instance.new("BloomEffect")
    effects.Bloom.Intensity = 0.5  -- Intenso para um visual mais impactante
    effects.Bloom.Threshold = 0.8
    effects.Bloom.Size = 50
    effects.Bloom.Name = "AdvancedBloom"

    -- Efeito de Color Correction (Brilho, Saturação e Contraste)
    effects.ColorCorrection = Instance.new("ColorCorrectionEffect")
    effects.ColorCorrection.Brightness = 0.15
    effects.ColorCorrection.Saturation = 0.3
    effects.ColorCorrection.Contrast = 0.2
    effects.ColorCorrection.Name = "AdvancedColor"

    -- Efeito de Sun Rays (efeito de luz solar)
    effects.SunRays = Instance.new("SunRaysEffect")
    effects.SunRays.Intensity = 0.2
    effects.SunRays.Spread = 0.35
    effects.SunRays.Name = "AdvancedSun"

    -- Efeito de Depth of Field (Profundidade de Campo)
    effects.DepthOfField = Instance.new("DepthOfFieldEffect")
    effects.DepthOfField.FarIntensity = 0.15
    effects.DepthOfField.FocusDistance = 80
    effects.DepthOfField.InFocusRadius = 250
    effects.DepthOfField.NearIntensity = 0.1
    effects.DepthOfField.Name = "AdvancedDOF"

    -- Efeito de Ambient Occlusion
    effects.AmbientOcclusion = Instance.new("AmbientOcclusionEffect")
    effects.AmbientOcclusion.Intensity = 0.3
    effects.AmbientOcclusion.Name = "AdvancedAO"

    -- Efeito de Chromatic Aberration
    effects.ChromaticAberration = Instance.new("ChromaticAberrationEffect")
    effects.ChromaticAberration.Intensity = 0.2
    effects.ChromaticAberration.Name = "AdvancedChromatic"

    -- Efeito de Film Grain (granulação de filme)
    effects.FilmGrain = Instance.new("FilmGrainEffect")
    effects.FilmGrain.Intensity = 0.1
    effects.FilmGrain.Name = "AdvancedFilmGrain"

    return effects
end

-- Função para aplicar os efeitos avançados
local function applyAdvancedEffects(effects)
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
        if v:IsA("PostEffect") and v.Name:match("^Advanced") then
            v:Destroy()
        end
    end
end

-- Função para criar a interface moderna e gótica
local function createGothicUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GothicVisualMenu"
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0, 20, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)  -- Cor preta e escura
    frame.BackgroundTransparency = 0.3  -- Semi-transparente para o visual
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(50, 50, 50)  -- Borda sutil
    frame.Parent = screenGui

    -- Título Gótico
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 300, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "Gothic Visual Effects"
    title.TextSize = 26
    title.TextColor3 = Color3.fromRGB(200, 200, 200)  -- Cinza claro
    title.Font = Enum.Font.GothamBold
    title.TextStrokeTransparency = 0.8  -- Sombra para dar um visual mais forte
    title.BackgroundTransparency = 1
    title.Parent = frame

    -- Botão de Efeitos Avançados
    local buttonUltra = Instance.new("TextButton")
    buttonUltra.Size = UDim2.new(0, 280, 0, 50)
    buttonUltra.Position = UDim2.new(0, 10, 0, 70)
    buttonUltra.Text = "Apply Gothic Effects"
    buttonUltra.TextSize = 20
    buttonUltra.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    buttonUltra.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonUltra.Font = Enum.Font.GothamBold
    buttonUltra.TextStrokeTransparency = 0.7
    buttonUltra.BorderSizePixel = 2
    buttonUltra.BorderColor3 = Color3.fromRGB(100, 100, 100)
    buttonUltra.Parent = frame

    -- Botão de Desativar
    local buttonOff = Instance.new("TextButton")
    buttonOff.Size = UDim2.new(0, 280, 0, 50)
    buttonOff.Position = UDim2.new(0, 10, 0, 130)
    buttonOff.Text = "Turn Off Effects"
    buttonOff.TextSize = 20
    buttonOff.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    buttonOff.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonOff.Font = Enum.Font.GothamBold
    buttonOff.TextStrokeTransparency = 0.7
    buttonOff.BorderSizePixel = 2
    buttonOff.BorderColor3 = Color3.fromRGB(100, 100, 100)
    buttonOff.Parent = frame

    -- Funções dos botões
    buttonUltra.MouseButton1Click:Connect(function()
        local effects = createAdvancedEffects()
        applyAdvancedEffects(effects)
    end)

    buttonOff.MouseButton1Click:Connect(function()
        removeEffects()
    end)

    return screenGui
end

-- Função para alternar a visibilidade da interface com uma hotkey
local function toggleUI()
    local screenGui = createGothicUI()
    local uis = game:GetService("UserInputService")
    local uiVisible = true

    -- Hotkey F6 para ativar/desativar
    uis.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.F6 then
            if uiVisible then
                screenGui:Destroy()
                uiVisible = false
            else
                screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
                uiVisible = true
            end
        end
    end)
end

-- Chama a função de toggle
toggleUI()

-- Hotkey F5 para ativar o Ultra e aplicar os efeitos
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F5 then
        local effects = createAdvancedEffects()
        applyAdvancedEffects(effects)
    end
end)

