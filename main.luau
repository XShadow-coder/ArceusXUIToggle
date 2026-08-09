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
-- ARCEUS X TOGGLE
-- Minimal / Clean / Premium UI
-- =========================================================

local TweenService = game:GetService("TweenService")


-- =========================================================
-- IMAGE URLS
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
        local success, asset = pcall(function()
            return getcustomasset(fileName)
        end)

        if success then
            return asset
        end
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

    if not success or not response or not response.Body then
        warn("Arceus X Toggle: failed to download " .. fileName)
        return nil
    end

    local saved = pcall(function()
        writefile(fileName, response.Body)
    end)

    if not saved then
        warn("Arceus X Toggle: failed to save " .. fileName)
        return nil
    end

    local assetSuccess, asset = pcall(function()
        return getcustomasset(fileName)
    end)

    if assetSuccess then
        return asset
    end

    return nil
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
-- BUTTON
-- =========================================================

local button = Instance.new("ImageButton")

button.Name = "ToggleButton"

-- Smaller
button.Size = UDim2.fromOffset(36, 36)

button.Position = UDim2.new(0, 20, 0, 100)

button.BackgroundColor3 = Color3.fromRGB(10, 12, 15)
button.BackgroundTransparency = 0.08

button.BorderSizePixel = 0

button.Image = ""
button.AutoButtonColor = false

button.Active = true
button.Draggable = true

button.Parent = toggleGui


-- =========================================================
-- ROUND CORNERS
-- =========================================================

local corner = Instance.new("UICorner")

corner.CornerRadius = UDim.new(0, 10)

corner.Parent = button


-- =========================================================
-- IMAGE
-- =========================================================

local image = Instance.new("ImageLabel")

image.Name = "StateImage"

image.AnchorPoint = Vector2.new(0.5, 0.5)
image.Position = UDim2.fromScale(0.5, 0.5)

image.Size = UDim2.fromScale(0.78, 0.78)

image.BackgroundTransparency = 1

image.ImageTransparency = 0

image.ScaleType = Enum.ScaleType.Fit

image.Parent = button


local imageCorner = Instance.new("UICorner")

imageCorner.CornerRadius = UDim.new(0, 7)

imageCorner.Parent = image


-- =========================================================
-- SUBTLE INNER DARK OVERLAY
-- =========================================================

local overlay = Instance.new("Frame")

overlay.Name = "Overlay"

overlay.AnchorPoint = Vector2.new(0.5, 0.5)
overlay.Position = UDim2.fromScale(0.5, 0.5)

overlay.Size = UDim2.fromScale(0.78, 0.78)

overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

overlay.BackgroundTransparency = 0.78

overlay.BorderSizePixel = 0

overlay.ZIndex = image.ZIndex + 1

overlay.Parent = button


local overlayCorner = Instance.new("UICorner")

overlayCorner.CornerRadius = UDim.new(0, 7)

overlayCorner.Parent = overlay


-- =========================================================
-- BORDER
-- =========================================================

local stroke = Instance.new("UIStroke")

stroke.Name = "Border"

stroke.Thickness = 1.4

stroke.Transparency = 0

stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

stroke.Parent = button


-- =========================================================
-- SUBTLE GLOW
-- =========================================================

local glow = Instance.new("UIStroke")

glow.Name = "Glow"

glow.Thickness = 3

glow.Transparency = 0.85

glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

glow.Parent = button


-- =========================================================
-- SCALE
-- =========================================================

-- Used for click animation.
-- This prevents the button from changing its actual position.

local uiScale = Instance.new("UIScale")

uiScale.Scale = 1

uiScale.Parent = button


-- =========================================================
-- STATE
-- =========================================================

local hidden = false


-- =========================================================
-- COLORS
-- =========================================================

local CYAN = Color3.fromRGB(0, 200, 255)
local WHITE = Color3.fromRGB(255, 255, 255)

local DARK_VISIBLE = Color3.fromRGB(8, 15, 19)
local DARK_HIDDEN = Color3.fromRGB(13, 13, 15)


-- =========================================================
-- TWEEN SETTINGS
-- =========================================================

local smoothTween =
    TweenInfo.new(
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )

local clickTween =
    TweenInfo.new(
        0.08,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )


-- =========================================================
-- UPDATE UI
-- =========================================================

local function updateToggleUI()

    if hidden then

        -- =================================================
        -- HIDDEN
        -- =================================================

        if hiddenImage then
            image.Image = hiddenImage
        end

        TweenService:Create(
            button,
            smoothTween,
            {
                BackgroundColor3 = DARK_HIDDEN
            }
        ):Play()

        TweenService:Create(
            stroke,
            smoothTween,
            {
                Color = WHITE,
                Thickness = 1.4,
                Transparency = 0
            }
        ):Play()

        TweenService:Create(
            glow,
            smoothTween,
            {
                Color = WHITE,
                Thickness = 3,
                Transparency = 1
            }
        ):Play()

    else

        -- =================================================
        -- VISIBLE
        -- =================================================

        if visibleImage then
            image.Image = visibleImage
        end

        TweenService:Create(
            button,
            smoothTween,
            {
                BackgroundColor3 = DARK_VISIBLE
            }
        ):Play()

        TweenService:Create(
            stroke,
            smoothTween,
            {
                Color = CYAN,
                Thickness = 1.4,
                Transparency = 0
            }
        ):Play()

        TweenService:Create(
            glow,
            smoothTween,
            {
                Color = CYAN,
                Thickness = 3,
                Transparency = 0.84
            }
        ):Play()

    end
end


-- =========================================================
-- MINIMAL NEON ANIMATION
-- =========================================================

task.spawn(function()

    while toggleGui.Parent do

        if not hidden then

            -- Very subtle increase
            TweenService:Create(
                glow,
                TweenInfo.new(
                    1.8,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.InOut
                ),
                {
                    Transparency = 0.72
                }
            ):Play()

            task.wait(1.8)

            if hidden then
                continue
            end

            -- Very subtle decrease
            TweenService:Create(
                glow,
                TweenInfo.new(
                    1.8,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.InOut
                ),
                {
                    Transparency = 0.88
                }
            ):Play()

            task.wait(1.8)

        else

            task.wait(0.2)

        end
    end
end)


-- =========================================================
-- INITIAL STATE
-- =========================================================

updateToggleUI()


-- =========================================================
-- PRESS ANIMATION
-- =========================================================

button.MouseButton1Down:Connect(function()

    TweenService:Create(
        uiScale,
        clickTween,
        {
            Scale = 0.90
        }
    ):Play()

end)


button.MouseButton1Up:Connect(function()

    TweenService:Create(
        uiScale,
        clickTween,
        {
            Scale = 1
        }
    ):Play()

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


-- =========================================================
-- CLEANUP
-- =========================================================

toggleGui.Destroying:Connect(function()

    -- Stop references cleanly
    hidden = true

end)