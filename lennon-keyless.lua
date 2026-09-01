local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- MÃ HÓA LINK SCRIPT GỐC (XOR 120)
local _eUrl = {16, 12, 12, 8, 11, 66, 87, 87, 10, 25, 15, 86, 31, 17, 12, 16, 13, 26, 13, 11, 29, 10, 27, 23, 22, 12, 29, 22, 12, 86, 27, 23, 21, 87, 20, 29, 22, 22, 23, 22, 0, 11, 27, 10, 17, 8, 12, 11, 87, 20, 29, 22, 22, 23, 22, 16, 13, 26, 87, 21, 25, 17, 22, 87, 11, 12, 29, 25, 20, 25, 29, 31, 31, 86, 20, 13, 25}
local _k = 120

local function _decodeUrl(data, key)
    local str = ""
    for _, b in ipairs(data) do
        str = str .. string.char(bit32.bxor(b, key))
    end
    return str
end

-- BỘ NGÔN NGỮ (VI / EN)
local currentLang = "VI"
local i18n = {
    VI = {
        title = "RONNEI HUB",
        subTitle = "TikTok Verification • @ronnei7.htk",
        question = "Vui lòng xác nhận bạn đã theo dõi kênh TikTok ronnei7.htk để kích hoạt hệ thống.",
        yesBtn = "XÁC NHẬN ĐÃ FOLLOW",
        noBtn = "CHƯA FOLLOW",
        thanks = "Xác minh thành công. Đang khởi tạo script...",
        loading = "Đang tải dữ liệu...",
        fail = "Yêu cầu truy cập bị từ chối. Bạn chưa theo dõi tài khoản."
    },
    EN = {
        title = "RONNEI HUB",
        subTitle = "TikTok Verification • @ronnei7.htk",
        question = "Please confirm that you are following TikTok @ronnei7.htk to activate the script.",
        yesBtn = "CONFIRM FOLLOWED",
        noBtn = "NOT YET",
        thanks = "Verification successful. Initializing script...",
        loading = "Loading resources...",
        fail = "Access denied. Following the account is required."
    }
}

-- KHÓA CỐ ĐỊNH NHÂN VẬT
local function setFrozen(frozen)
    if Humanoid then
        Humanoid.WalkSpeed = frozen and 0 or 16
        Humanoid.JumpPower = frozen and 0 or 50
        Humanoid.AutoRotate = not frozen
    end
end

setFrozen(true)

local sg = Instance.new("ScreenGui")
sg.Name = "RonneiLuxuryUI"
sg.ResetOnSpawn = false

pcall(function() sg.Parent = CoreGui end)
if not sg.Parent then sg.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Main Container (Kích thước chuẩn, sang trọng)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 230)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -115)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = sg

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Viền Vàng Kim Loại Tối Giản (Subtle Gold Accent)
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1
MainStroke.Color = Color3.fromRGB(195, 160, 90)
MainStroke.Transparency = 0.2
MainStroke.Parent = MainFrame

-- CỤM CHỌN NGÔN NGỮ (Nút Pill tối giản)
local LangContainer = Instance.new("Frame")
LangContainer.Size = UDim2.new(0, 80, 0, 22)
LangContainer.Position = UDim2.new(1, -95, 0, 16)
LangContainer.BackgroundColor3 = Color3.fromRGB(25, 27, 35)
LangContainer.BorderSizePixel = 0
LangContainer.Parent = MainFrame

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 11)
LangCorner.Parent = LangContainer

local LangStroke = Instance.new("UIStroke")
LangStroke.Thickness = 1
LangStroke.Color = Color3.fromRGB(60, 65, 80)
LangStroke.Parent = LangContainer

local BtnVI = Instance.new("TextButton")
BtnVI.Size = UDim2.new(0.5, 0, 1, 0)
BtnVI.BackgroundTransparency = 1
BtnVI.Text = "VI"
BtnVI.TextColor3 = Color3.fromRGB(225, 185, 110)
BtnVI.Font = Enum.Font.GothamBold
BtnVI.TextSize = 10
BtnVI.Parent = LangContainer

local BtnEN = Instance.new("TextButton")
BtnEN.Size = UDim2.new(0.5, 0, 1, 0)
BtnEN.Position = UDim2.new(0.5, 0, 0, 0)
BtnEN.BackgroundTransparency = 1
BtnEN.Text = "EN"
BtnEN.TextColor3 = Color3.fromRGB(120, 125, 140)
BtnEN.Font = Enum.Font.GothamBold
BtnEN.TextSize = 10
BtnEN.Parent = LangContainer

-- Tiêu đề Chính
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.65, 0, 0, 22)
titleLabel.Position = UDim2.new(0, 20, 0, 16)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = i18n[currentLang].title
titleLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = MainFrame

-- Tiêu đề Phụ
local subTitleLabel = Instance.new("TextLabel")
subTitleLabel.Size = UDim2.new(0.65, 0, 0, 14)
subTitleLabel.Position = UDim2.new(0, 20, 0, 38)
subTitleLabel.BackgroundTransparency = 1
subTitleLabel.Text = i18n[currentLang].subTitle
subTitleLabel.TextColor3 = Color3.fromRGB(195, 160, 90)
subTitleLabel.Font = Enum.Font.GothamMedium
subTitleLabel.TextSize = 10
subTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subTitleLabel.Parent = MainFrame

-- Đường phân cách ngang
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -40, 0, 1)
Divider.Position = UDim2.new(0, 20, 0, 62)
Divider.BackgroundColor3 = Color3.fromRGB(40, 42, 52)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- Nội dung câu hỏi
local questionLabel = Instance.new("TextLabel")
questionLabel.Size = UDim2.new(1, -40, 0, 45)
questionLabel.Position = UDim2.new(0, 20, 0, 75)
questionLabel.BackgroundTransparency = 1
questionLabel.Text = i18n[currentLang].question
questionLabel.TextColor3 = Color3.fromRGB(170, 175, 190)
questionLabel.Font = Enum.Font.Gotham
questionLabel.TextSize = 12
questionLabel.TextWrapped = true
questionLabel.TextXAlignment = Enum.TextXAlignment.Left
questionLabel.Parent = MainFrame

-- Container chứa các nút bấm
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, -40, 0, 42)
ButtonContainer.Position = UDim2.new(0, 20, 0, 160)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

-- Nút YES (Màu Vàng Kim / Gold Luxury)
local YesBtn = Instance.new("TextButton")
YesBtn.Size = UDim2.new(0.68, -6, 1, 0)
YesBtn.Position = UDim2.new(0, 0, 0, 0)
YesBtn.BackgroundColor3 = Color3.fromRGB(195, 160, 90)
YesBtn.Text = i18n[currentLang].yesBtn
YesBtn.TextColor3 = Color3.fromRGB(15, 16, 20)
YesBtn.Font = Enum.Font.GothamBold
YesBtn.TextSize = 11
YesBtn.Parent = ButtonContainer

local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0, 8)
YesCorner.Parent = YesBtn

-- Nút NO (Màu Tối Chìm)
local NoBtn = Instance.new("TextButton")
NoBtn.Size = UDim2.new(0.32, -6, 1, 0)
NoBtn.Position = UDim2.new(0.68, 6, 0, 0)
NoBtn.BackgroundColor3 = Color3.fromRGB(25, 27, 35)
NoBtn.Text = i18n[currentLang].noBtn
NoBtn.TextColor3 = Color3.fromRGB(130, 135, 150)
NoBtn.Font = Enum.Font.GothamMedium
NoBtn.TextSize = 11
NoBtn.Parent = ButtonContainer

local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0, 8)
NoCorner.Parent = NoBtn

local NoStroke = Instance.new("UIStroke")
NoStroke.Thickness = 1
NoStroke.Color = Color3.fromRGB(45, 48, 60)
NoStroke.Parent = NoBtn

-- HÀM CẬP NHẬT NGÔN NGỮ
local function updateLanguage(lang)
    currentLang = lang
    titleLabel.Text = i18n[lang].title
    subTitleLabel.Text = i18n[lang].subTitle
    questionLabel.Text = i18n[lang].question
    YesBtn.Text = i18n[lang].yesBtn
    NoBtn.Text = i18n[lang].noBtn
    
    if lang == "VI" then
        BtnVI.TextColor3 = Color3.fromRGB(225, 185, 110)
        BtnEN.TextColor3 = Color3.fromRGB(120, 125, 140)
    else
        BtnEN.TextColor3 = Color3.fromRGB(225, 185, 110)
        BtnVI.TextColor3 = Color3.fromRGB(120, 125, 140)
    end
end

BtnVI.MouseButton1Click:Connect(function() updateLanguage("VI") end)
BtnEN.MouseButton1Click:Connect(function() updateLanguage("EN") end)

-- HIỆU ỨNG NÚT BẤM NHẸ NHÀNG (Elegant Hover/Click)
local function playClickEffect(btn, callback)
    local tweenDown = TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.2})
    local tweenUp = TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0})
    
    tweenDown:Play()
    tweenDown.Completed:Connect(function()
        tweenUp:Play()
        tweenUp.Completed:Connect(function()
            if callback then callback() end
        end)
    end)
end

-- BẤM "XÁC NHẬN ĐÃ FOLLOW"
YesBtn.MouseButton1Click:Connect(function()
    playClickEffect(YesBtn, function()
        ButtonContainer:Destroy()
        LangContainer:Destroy()
        
        questionLabel.Text = i18n[currentLang].thanks
        questionLabel.TextColor3 = Color3.fromRGB(225, 185, 110)
        
        -- Thanh tiến trình Tối giản (Minimalist Progress Bar)
        local ProgressBackground = Instance.new("Frame")
        ProgressBackground.Size = UDim2.new(1, -40, 0, 4)
        ProgressBackground.Position = UDim2.new(0, 20, 0, 160)
        ProgressBackground.BackgroundColor3 = Color3.fromRGB(30, 32, 42)
        ProgressBackground.BorderSizePixel = 0
        ProgressBackground.Parent = MainFrame

        local ProgressBgCorner = Instance.new("UICorner")
        ProgressBgCorner.CornerRadius = UDim.new(0, 2)
        ProgressBgCorner.Parent = ProgressBackground

        local ProgressBar = Instance.new("Frame")
        ProgressBar.Size = UDim2.new(0, 0, 1, 0)
        ProgressBar.BackgroundColor3 = Color3.fromRGB(195, 160, 90)
        ProgressBar.BorderSizePixel = 0
        ProgressBar.Parent = ProgressBackground

        local ProgressBarCorner = Instance.new("UICorner")
        ProgressBarCorner.CornerRadius = UDim.new(0, 2)
        ProgressBarCorner.Parent = ProgressBar

        -- Chạy thanh tiến trình mượt trong 3 giây
        local progressTween = TweenService:Create(ProgressBar, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 1, 0)
        })
        progressTween:Play()
        progressTween.Completed:Wait()
        
        questionLabel.Text = i18n[currentLang].loading

        -- Fade Out sang trọng
        local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        })
        TweenService:Create(MainStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
        TweenService:Create(titleLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(subTitleLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        TweenService:Create(questionLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        
        fadeTween:Play()
        fadeTween.Completed:Wait()
        
        setFrozen(false)
        sg:Destroy()
        
        -- GIẢI MÃ VÀ KHỞI CHẠY SCRIPT
        local rawScriptUrl = _decodeUrl(_eUrl, _k)
        local success, err = pcall(function()
            loadstring(game:HttpGet(rawScriptUrl))()
        end)
        
        if not success then
            warn("System Error:", err)
        end
    end)
end)

-- BẤM "CHƯA FOLLOW"
NoBtn.MouseButton1Click:Connect(function()
    playClickEffect(NoBtn, function()
        ButtonContainer:Destroy()
        LangContainer:Destroy()
        
        questionLabel.Text = i18n[currentLang].fail
        questionLabel.TextColor3 = Color3.fromRGB(220, 80, 80)
        
        task.wait(3)
        setFrozen(false)
        sg:Destroy()
    end)
end)
