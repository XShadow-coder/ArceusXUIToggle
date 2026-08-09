local CoreGui = game:GetService("CoreGui")

-- gethui() nel tuo caso restituisce:
-- CoreGui.9rMgS4.mriOy9
local targetParent = (gethui and gethui()) or CoreGui

-- =========================================================
-- REMOVE OLD TOGGLES
-- =========================================================

for _, obj in ipairs(targetParent:GetChildren()) do
    if obj:IsA("ScreenGui") and obj.Name == "ArceusXVisibilityToggle" then
        obj:Destroy()
    end
end

-- =========================================================
-- FIND ARCEUS X
-- =========================================================

local function findArceusX()

    for _, obj in ipairs(targetParent:GetChildren()) do

        if obj:IsA("ScreenGui") then

            if obj.DisplayOrder == 1999999999 then
                return obj
            end

        end
    end

    return nil
end

-- =========================================================
-- IMAGE URLS
-- =========================================================

local VISIBLE_IMAGE_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4700.png"

local HIDDEN_IMAGE_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4701.png"


-- =========================================================
-- ARCEUS X TOGGLE - ANIMATED NEON UI
-- =========================================================

local VISIBLE_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4700.png"

local HIDDEN_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4701.png"

local VISIBLE_FILE = "ArceusXToggle_Visible.png"
local HIDDEN_FILE = "ArceusXToggle_Hidden.png"


-- =========================================================
-- DOWNLOAD IMAGE
-- =========================================================

local function downloadImage(url, fileName)

    if isfile and isfile(fileName) then
        return getcustomasset(fileName)
    end

    local http = request or http_request

    if not http then
        warn("Arceus X Toggle: HTTP function not available")
        return nil
    end

    local success, response = pcall(function()
        return http({
            Url = url,
            Method = "GET"
        })
    end)

    if not success or not response then
        warn("Arceus X Toggle: failed to download " .. fileName)
        return nil
    end

    if not response.Body then
        warn("Arceus X Toggle: response has no Body")
        return nil
    end

    writefile(fileName, response.Body)

    return getcustomasset(fileName)
end


-- =========================================================
-- LOAD IMAGES
-- =========================================================

local visibleImage = downloadImage(
    VISIBLE_URL,
    VISIBLE_FILE
)

local hiddenImage = downloadImage(
    HIDDEN_URL,
    HIDDEN_FILE
)


-- =========================================================
-- CREATE GUI
-- =========================================================

local toggleGui = Instance.new("ScreenGui")

toggleGui.Name = "ArceusXVisibilityToggle"
toggleGui.ResetOnSpawn = false
toggleGui.IgnoreGuiInset = true
toggleGui.DisplayOrder = 2147483647

toggleGui.Parent = targetParent


-- =========================================================
-- MAIN BUTTON
-- =========================================================

local button = Instance.new("ImageButton")

button.Name = "ToggleButton"

button.Size = UDim2.new(0, 48, 0, 48)
button.Position = UDim2.new(0, 20, 0, 100)

button.BackgroundColor3 = Color3.fromRGB(8, 15, 20)
button.BackgroundTransparency = 0.12

button.AutoButtonColor = false
button.Image = ""

button.Active = true
button.Draggable = true

button.Parent = toggleGui


-- =========================================================
-- BUTTON CORNER
-- =========================================================

local corner = Instance.new("UICorner")

corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button


-- =========================================================
-- IMAGE
-- =========================================================

local image = Instance.new("ImageLabel")

image.Name = "StateImage"

image.Size = UDim2.new(1, -6, 1, -6)
image.Position = UDim2.new(0, 3, 0, 3)

image.BackgroundTransparency = 1

image.ScaleType = Enum.ScaleType.Fit

image.Parent = button


local imageCorner = Instance.new("UICorner")

imageCorner.CornerRadius = UDim.new(0, 9)
imageCorner.Parent = image


-- =========================================================
-- MAIN BORDER
-- =========================================================

local stroke = Instance.new("UIStroke")

stroke.Name = "Border"

stroke.Thickness = 2
stroke.Transparency = 0

stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

stroke.Parent = button


-- =========================================================
-- NEON GLOW
-- =========================================================

local glow = Instance.new("UIStroke")

glow.Name = "NeonGlow"

glow.Thickness = 6
glow.Transparency = 0.55

glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

glow.Parent = button


-- =========================================================
-- STATE
-- =========================================================

local hidden = false
local neonRunning = true


-- =========================================================
-- NEON ANIMATION
-- =========================================================

task.spawn(function()

    while neonRunning and toggleGui.Parent do

        if not hidden then

            -- Fade OUT
            for i = 0, 1, 0.025 do

                if hidden then
                    break
                end

                local alpha = 0.45 + (i * 0.35)

                glow.Transparency = alpha

                task.wait(0.025)
            end


            -- Fade IN
            for i = 1, 0, -0.025 do

                if hidden then
                    break
                end

                local alpha = 0.45 + (i * 0.35)

                glow.Transparency = alpha

                task.wait(0.025)
            end

        else

            -- Hidden = no glow
            glow.Transparency = 1

            task.wait(0.1)
        end
    end
end)


-- =========================================================
-- UPDATE UI
-- =========================================================

local function updateToggleUI()

    if hidden then

        -- ================================================
        -- HIDDEN
        -- ================================================

        if hiddenImage then
            image.Image = hiddenImage
        end

        -- White static border
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.Thickness = 2
        stroke.Transparency = 0

        -- Disable neon
        glow.Color = Color3.fromRGB(255, 255, 255)
        glow.Transparency = 1

        -- Dark interior
        button.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        button.BackgroundTransparency = 0.18

    else

        -- ================================================
        -- VISIBLE
        -- ================================================

        if visibleImage then
            image.Image = visibleImage
        end

        -- Cyan border
        stroke.Color = Color3.fromRGB(0, 200, 255)
        stroke.Thickness = 2
        stroke.Transparency = 0

        -- Neon
        glow.Color = Color3.fromRGB(0, 200, 255)
        glow.Thickness = 6

        -- Dark blue-ish interior
        button.BackgroundColor3 = Color3.fromRGB(8, 15, 20)
        button.BackgroundTransparency = 0.12
    end
end


-- =========================================================
-- INITIAL STATE
-- =========================================================

updateToggleUI()


-- =========================================================
-- CLICK EFFECT
-- =========================================================

button.MouseButton1Down:Connect(function()

    button.Size = UDim2.new(0, 45, 0, 45)
    button.Position = UDim2.new(0, 21, 0, 101)

end)


button.MouseButton1Up:Connect(function()

    button.Size = UDim2.new(0, 48, 0, 48)
    button.Position = UDim2.new(0, 20, 0, 100)

end)


-- =========================================================
-- TOGGLE
-- =========================================================

button.MouseButton1Click:Connect(function()

    local arceusGui = findArceusX()

    if not arceusGui then

        warn("Arceus X Not Found")

        return
    end

    hidden = not hidden

    arceusGui.Enabled = not hidden

    updateToggleUI()
end)