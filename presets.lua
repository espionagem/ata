-- Função para criar presets refinados de efeitos visuais com reflexos HDR
local function getRefinedPresets()
    return {
        ULTRA = {
            Lighting = {
                Ambient = Color3.fromRGB(140, 140, 140),
                Brightness = 2.0,
                ColorShift_Bottom = Color3.fromRGB(230, 210, 190),
                ColorShift_Top = Color3.fromRGB(245, 220, 200),
                OutdoorAmbient = Color3.fromRGB(110, 110, 110),
                EnvironmentDiffuseScale = 1.2,
                EnvironmentSpecularScale = 1.2,
                GlobalShadows = true,
                ShadowSoftness = 0.4,
                FogColor = Color3.fromRGB(200, 200, 220),
                FogEnd = 900,
                FogStart = 200
            },
            Effects = {
                Blur = {Size = 5},
                Bloom = {Intensity = 1.0, Threshold = 0.7, Size = 60},
                ColorCorrection = {
                    Brightness = 0.08,
                    Saturation = 0.25,
                    Contrast = 0.25,
                    TintColor = Color3.fromRGB(255, 230, 210)
                },
                DepthOfField = {
                    FocusDistance = 60,
                    InFocusRadius = 250,
                    FarIntensity = 0.15,
                    NearIntensity = 0.1
                },
                SunRays = {Intensity = 0.2, Spread = 0.35}
            },
            GroundReflectivity = 0.25 -- Reflexos HDR no chão
        },
        CLEAN = {
            Lighting = {
                Ambient = Color3.fromRGB(160, 160, 160),
                Brightness = 1.8,
                OutdoorAmbient = Color3.fromRGB(140, 140, 140),
                EnvironmentDiffuseScale = 1.0,
                EnvironmentSpecularScale = 1.0,
                GlobalShadows = true,
                ShadowSoftness = 0.6,
                FogColor = Color3.fromRGB(220, 220, 240),
                FogEnd = 1100,
                FogStart = 250
            },
            Effects = {
                Blur = {Size = 4},
                Bloom = {Intensity = 0.15, Threshold = 0.9, Size = 50},
                ColorCorrection = {
                    Brightness = 0.04,
                    Saturation = 0.18,
                    Contrast = 0.18,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }
            },
            GroundReflectivity = 0.2 -- Reflexos HDR
        },
        NOIR = {
            Lighting = {
                Ambient = Color3.fromRGB(60, 50, 40),
                Brightness = 1.5,
                OutdoorAmbient = Color3.fromRGB(60, 50, 40),
                GlobalShadows = true,
                ShadowSoftness = 0.7,
                FogColor = Color3.fromRGB(50, 45, 40),
                FogEnd = 800,
                FogStart = 150
            },
            Effects = {
                Blur = {Size = 3},
                ColorCorrection = {
                    Brightness = -0.1,
                    Saturation = -0.8,
                    Contrast = 0.6,
                    TintColor = Color3.fromRGB(180, 150, 120) -- Filtro amarelado/marrom café
                }
            },
            GroundReflectivity = 0.15 -- Reflexos HDR
        },
        DREAMY = {
            Lighting = {
                Ambient = Color3.fromRGB(190, 170, 240),
                Brightness = 2.0,
                ColorShift_Top = Color3.fromRGB(245, 200, 240),
                OutdoorAmbient = Color3.fromRGB(140, 110, 190),
                EnvironmentDiffuseScale = 1.1,
                EnvironmentSpecularScale = 1.1,
                ShadowSoftness = 0.5,
                FogColor = Color3.fromRGB(220, 190, 240),
                FogEnd = 800,
                FogStart = 200
            },
            Effects = {
                Blur = {Size = 8},
                Bloom = {Intensity = 0.9, Threshold = 0.8, Size = 90},
                ColorCorrection = {
                    Brightness = 0.15,
                    Saturation = 0.4,
                    Contrast = 0.2,
                    TintColor = Color3.fromRGB(250, 220, 250)
                },
                SunRays = {Intensity = 0.3, Spread = 0.45}
            },
            GroundReflectivity = 0.2 -- Reflexos HDR
        },
        RETRO = {
            Lighting = {
                Ambient = Color3.fromRGB(110, 90, 70),
                Brightness = 1.8, -- Mais brilho
                ColorShift_Bottom = Color3.fromRGB(60, 50, 40),
                EnvironmentDiffuseScale = 0.9,
                EnvironmentSpecularScale = 0.9,
                ShadowSoftness = 0.6,
                FogColor = Color3.fromRGB(90, 70, 60),
                FogEnd = 700,
                FogStart = 150
            },
            Effects = {
                Blur = {Size = 5},
                ColorCorrection = {
                    Brightness = 0.1,
                    Saturation = -0.3,
                    Contrast = 0.4,
                    TintColor = Color3.fromRGB(210, 190, 170)
                },
                FilmGrain = {Intensity = 0.3},
                ChromaticAberration = {Intensity = 0.3}
            },
            GroundReflectivity = 0.4 -- Reflexos HDR mais intensos
        }
    }
end

-- Função para aplicar reflexos no chão
local function applyGroundReflectivity(reflectivity)
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsA("MeshPart") and part.Material == Enum.Material.Concrete then
            part.Reflectance = reflectivity
        end
    end
end

-- Função para aplicar os presets refinados
local function applyRefinedPreset(presetName)
    local presets = getRefinedPresets()
    local preset = presets[presetName]

    if not preset then
        warn("Preset não encontrado: " .. tostring(presetName))
        return
    end

    -- Configuração de Lighting
    local lighting = game:GetService("Lighting")
    for property, value in pairs(preset.Lighting or {}) do
        lighting[property] = value
    end

    -- Remove efeitos antigos
    for _, effect in pairs(lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect:Destroy()
        end
    end

    -- Aplica novos efeitos
    for effectName, properties in pairs(preset.Effects or {}) do
        local effect = Instance.new(effectName .. "Effect")
        for prop, value in pairs(properties) do
            effect[prop] = value
        end
        effect.Parent = lighting
    end

    -- Aplica reflexos no chão
    if preset.GroundReflectivity then
        applyGroundReflectivity(preset.GroundReflectivity)
    end
end

-- Interface refinada com visual gótico e funcionalidade arrastável
local function createRefinedUI()
    local player = game:GetService("Players").LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = "RefinedVisualEffects"

    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0, 400, 0, 500)
    frame.Position = UDim2.new(0.5, -200, 0.5, -250)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(80, 60, 60)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Text = "Refined Visual Effects"
    title.Font = Enum.Font.GothamBlack -- Estilo próximo ao gótico
    title.TextSize = 26
    title.TextColor3 = Color3.fromRGB(240, 200, 140)
    title.BackgroundTransparency = 1

    local buttonContainer = Instance.new("Frame", frame)
    buttonContainer.Size = UDim2.new(1, -20, 1, -70)
    buttonContainer.Position = UDim2.new(0, 10, 0, 60)
    buttonContainer.BackgroundTransparency = 1

    local uiListLayout = Instance.new("UIListLayout", buttonContainer)
    uiListLayout.Padding = UDim.new(0, 10)
    uiListLayout.FillDirection = Enum.FillDirection.Vertical
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local presets = getRefinedPresets()
    for presetName, _ in pairs(presets) do
        local button = Instance.new("TextButton", buttonContainer)
        button.Size = UDim2.new(1, 0, 0, 50)
        button.Text = presetName
        button.Font = Enum.Font.GothamBlack -- Estilo próximo ao gótico
        button.TextSize = 18
        button.TextColor3 = Color3.fromRGB(240, 200, 140)
        button.BackgroundColor3 = Color3.fromRGB(30, 20, 20)
        button.BorderSizePixel = 2
        button.BorderColor3 = Color3.fromRGB(100, 70, 70)

        -- Efeito de hover
        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(40, 30, 30)
        end)
        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(30, 20, 20)
        end)

        -- Aplica o preset ao clicar
        button.MouseButton1Click:Connect(function()
            applyRefinedPreset(presetName)
        end)
    end

    -- Adiciona funcionalidade para arrastar o frame
    local dragging, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return screenGui
end

-- Alternador de visibilidade com hotkey
local function toggleRefinedUI()
    local screenGui = createRefinedUI()
    local uis = game:GetService("UserInputService")
    local uiVisible = true

    uis.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.F6 then
            uiVisible = not uiVisible
            screenGui.Enabled = uiVisible
        end
    end)
end

-- Inicializa a interface
toggleRefinedUI()
