-- Função para criar os efeitos avançados
local function createAdvancedEffects()
    local effects = {
        Blur = {Type = "BlurEffect", Size = 10},
        Bloom = {Type = "BloomEffect", Intensity = 0.5, Threshold = 0.8, Size = 50},
        ColorCorrection = {Type = "ColorCorrectionEffect", Brightness = 0.15, Saturation = 0.3, Contrast = 0.2},
        SunRays = {Type = "SunRaysEffect", Intensity = 0.2, Spread = 0.35},
        DepthOfField = {Type = "DepthOfFieldEffect", FarIntensity = 0.15, FocusDistance = 80, InFocusRadius = 250, NearIntensity = 0.1},
        AmbientOcclusion = {Type = "AmbientOcclusionEffect", Intensity = 0.3},
        ChromaticAberration = {Type = "ChromaticAberrationEffect", Intensity = 0.2},
        FilmGrain = {Type = "FilmGrainEffect", Intensity = 0.1}
    }
    
    for name, properties in pairs(effects) do
        local effect = Instance.new(properties.Type)
        for prop, value in pairs(properties) do
            if prop ~= "Type" then
                effect[prop] = value
            end
        end
        effect.Name = "Advanced" .. name
        effects[name] = effect
    end
    
    return effects
end

-- Função para aplicar os efeitos
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
    local screenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    screenGui.Name = "GothicVisualMenu"

    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0, 20, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(50, 50, 50)

    local uiComponents = {
        {Type = "TextLabel", Properties = {
            Size = UDim2.new(0, 300, 0, 50),
            Position = UDim2.new(0, 0, 0, 0),
            Text = "Gothic Visual Effects",
            TextSize = 26,
            TextColor3 = Color3.fromRGB(200, 200, 200),
            Font = Enum.Font.GothamBlack,
            BackgroundTransparency = 1
        }},
        {Type = "TextButton", Name = "ApplyEffects", Properties = {
            Size = UDim2.new(0, 280, 0, 50),
            Position = UDim2.new(0, 10, 0, 70),
            Text = "Apply Gothic Effects",
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.GothamBold,
            BorderSizePixel = 2,
            BorderColor3 = Color3.fromRGB(100, 100, 100)
        }},
        {Type = "TextButton", Name = "RemoveEffects", Properties = {
            Size = UDim2.new(0, 280, 0, 50),
            Position = UDim2.new(0, 10, 0, 130),
            Text = "Turn Off Effects",
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.GothamBold,
            BorderSizePixel = 2,
            BorderColor3 = Color3.fromRGB(100, 100, 100)
        }}
    }

    for _, component in ipairs(uiComponents) do
        local uiElement = Instance.new(component.Type, frame)
        for prop, value in pairs(component.Properties) do
            uiElement[prop] = value
        end

        if component.Name == "ApplyEffects" then
            uiElement.MouseButton1Click:Connect(function()
                applyAdvancedEffects(createAdvancedEffects())
            end)
        elseif component.Name == "RemoveEffects" then
            uiElement.MouseButton1Click:Connect(removeEffects)
        end
    end

    return screenGui
end

-- Alternador de visibilidade com hotkey
local function toggleUI()
    local screenGui = createGothicUI()
    local uis = game:GetService("UserInputService")
    local uiVisible = true

    uis.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.F6 then
            uiVisible = not uiVisible
            screenGui.Enabled = uiVisible
        end
    end)
end

-- Hotkey F5 para aplicar efeitos diretamente
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F5 then
        applyAdvancedEffects(createAdvancedEffects())
    end
end)

-- Inicializa a interface
toggleUI()
