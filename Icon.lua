local Players = game:GetService("Players")

local Icon = {}
local Selected = true
local lastXPosition = -57
Icon.Attribute = true
local LabelChanged = false
local TweenService = game:GetService("TweenService")

local tweenInfo = TweenInfo.new(
	0.5, -- Time in seconds
	Enum.EasingStyle.Exponential, -- Easing style
	Enum.EasingDirection.Out, -- Easing direction
	0, -- Repeat count (0 = no repeat)
	false, -- Reverses (true = reverses the tween)
	0 -- Delay time
)

function Icon.new(player)
	if not player then
		error("Player cannot be nil")
	end

	local self = setmetatable({}, {__index = Icon})
	self.Selected = Selected
	
	local UI = player.PlayerGui:FindFirstChild("ActionBar")
	local HDAdminWorkspaceFolder = game.Workspace:FindFirstChild("HD Admin")
	
	if not UI then
		local TweenService = game:GetService("TweenService")
		local UI = Instance.new("ScreenGui")
		UI.Name = "ActionBar"
		UI.Parent = player:WaitForChild("PlayerGui")
		UI.IgnoreGuiInset = true
		UI.ResetOnSpawn = false
		local TopBars = Instance.new("Frame")
		TopBars.Position = script.Template.TopBar.Position
		TopBars.Size = script.Template.TopBar.Size
		TopBars.Name = "TopBars"
		TopBars.BackgroundTransparency = 1
		TopBars.Parent = UI
		
		task.wait(6)
		
		if HDAdminWorkspaceFolder then
			print("Detected HDAdmin, moving topbars...")
			local goal = {}
			goal.Position = UDim2.new(0, 229, 0, 12)
			
			local tweenInfo = TweenInfo.new(1)

			local tween = TweenService:Create(TopBars, tweenInfo, goal)
			tween:Play()
		end
	end
	
	self.Widget = script.Template.TopBar.TopBar:Clone()
	local PlayerGui = player:WaitForChild("PlayerGui")
	local UI = PlayerGui.ActionBar
	lastXPosition += 57
	self.Widget.Parent = UI.TopBars
	self.Widget.Position = UDim2.new(0, lastXPosition, 0, 0)
	
	self.Widget.Button.MouseButton1Click:Connect(function()
		if self.Selected == true then
			self.Selected = false
		elseif self.Selected == false then
			self.Selected = true
		end
	end)
	
	local function moveTopBars(x)
		for _, child in ipairs(self.Widget.Parent:GetChildren()) do
			if child:IsA("Frame") and child.Name == "TopBar" then
				if child.Position.X.Offset > self.Widget.Position.X.Offset then
					local ChildGoal = {}
					ChildGoal.Position = child.Position + UDim2.new(0, x, 0, 0)
					local tween = TweenService:Create(child, tweenInfo, ChildGoal)
					tween:Play()
				end
			end
		end
	end
	
	function self.MouseButton1Click(func)
		self.Widget.Button.MouseButton1Click:Connect(func)
	end
	
	function self.setImage(decalid, TYPE)
		if not decalid and not TYPE then
			self.Widget.Icon.Image = ""
			self.Widget.SelectedIcon.Image = ""
		elseif not decalid and TYPE == "" then
			self.Widget.Icon.Image = ""
			self.Widget.SelectedIcon.Image = ""
		elseif not decalid and TYPE == "deselected" then
			self.Widget.Icon.Image = ""
		elseif not decalid and TYPE == "selected" then
			self.Widget.SelectedIcon = ""
		elseif decalid == "" and not TYPE then
			self.Widget.Icon.Image = ""
			self.Widget.SelectedIcon.Image = ""
		elseif decalid == "" and TYPE == "" then
			self.Widget.Icon.Image = ""
			self.Widget.SelectedIcon.Image = ""
		elseif decalid == "" and TYPE == "deselected" then
			self.Widget.Icon.Image = ""
		elseif decalid == "" and TYPE == "selected" then
			self.Widget.SelectedIcon = ""
		else
			if not TYPE or TYPE == "" then
				self.Widget.Icon.Image = "rbxassetid://" .. decalid
				self.Widget.SelectedIcon.Image = "rbxassetid://" .. decalid
			elseif TYPE == "selected" then
				self.Widget.SelectedIcon.Image = "rbxassetid://" .. decalid
			elseif TYPE == "deselected" then
				self.Widget.Icon.Image = "rbxassetid://" .. decalid
			end
		end
	end
	
	function self.setLabel(text)
		if text == self.Widget.TextLabel.Text then
			print("Text is the same")
		else
			if self.Widget.PreviousText.Text == "asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd" and LabelChanged == true then
				self.Widget.PreviousText.Text = self.Widget.TextLabel.Text
			end
			self.Widget.TextLabel.Text = text
			if text == "" then
				local textSize = self.Widget.TextLabel.TextBounds
				local TopBarGoal = {}
				TopBarGoal.Size = UDim2.new(0, textSize.X + 44, 1, 0)
				local FrameGoal = {}
				FrameGoal.Size = UDim2.new(0, textSize.X + 36, 0, 36)
				local ButtonGoal = {}
				ButtonGoal.Size = UDim2.new(0, textSize.X + 36, 0, 36)
				local TextGoal = {}
				TextGoal.Position = UDim2.new(0.1, 2, 0.023, 0)

				local tween1 = TweenService:Create(self.Widget.TopBar, tweenInfo, TopBarGoal)
				local tween2 = TweenService:Create(self.Widget.Frame, tweenInfo, FrameGoal)
				local tween3 = TweenService:Create(self.Widget.Button, tweenInfo,ButtonGoal)
				local tween4 = TweenService:Create(self.Widget.TextLabel, tweenInfo, TextGoal)

				tween1:Play()
				tween2:Play()
				tween3:Play()
				tween4:Play()

				--self.Widget.TopBar.Size = UDim2.new(0, textSize.X + 44, 1, 0)
				--self.Widget.Frame.Size = UDim2.new(0, textSize.X + 34, 0, 34)
				--self.Widget.Button.Size = UDim2.new(0, textSize.X + 34, 0, 34)
				--self.Widget.TextLabel.Position = UDim2.new(0.1, 2, 0.023, 0)
				moveTopBars(textSize.X - 105)
			else
				if self.Widget.Icon.Image == "" and self.Widget.SelectedIcon.Image == "" then
					local textSize = self.Widget.TextLabel.TextBounds
					local TopBarGoal = {}
					TopBarGoal.Size = UDim2.new(0, textSize.X + 35, 1, 0)
					local FrameGoal = {}
					FrameGoal.Size = UDim2.new(0, textSize.X + 27, 0, 36)
					local ButtonGoal = {}
					ButtonGoal.Size = UDim2.new(0, textSize.X + 27, 0, 36)
					local TextGoal = {}
					TextGoal.Position = UDim2.new(0.1, 2, 0.023, 0)

					local tween1 = TweenService:Create(self.Widget.TopBar, tweenInfo, TopBarGoal)
					local tween2 = TweenService:Create(self.Widget.Frame, tweenInfo, FrameGoal)
					local tween3 = TweenService:Create(self.Widget.Button, tweenInfo,ButtonGoal)
					local tween4 = TweenService:Create(self.Widget.TextLabel, tweenInfo, TextGoal)

					tween1:Play()
					tween2:Play()
					tween3:Play()
					tween4:Play()

					--self.Widget.TopBar.Size = UDim2.new(0, textSize.X + 35, 1, 0)
					--self.Widget.Frame.Size = UDim2.new(0, textSize.X + 25, 0, 34)
					--self.Widget.Button.Size = UDim2.new(0, textSize.X + 25, 0, 34)
					--self.Widget.TextLabel.Position = UDim2.new(0.1, 2, 0.023, 0)
					if LabelChanged == false then
						moveTopBars(textSize.X - 10)
					elseif self.Widget.PreviousText.TextBounds.X > textSize.X then
						moveTopBars(textSize.X - 80)
					elseif self.Widget.PreviousText.TextBounds.X < textSize.X then
						moveTopBars(textSize.X - 80)
					end
				else
					local textSize = self.Widget.TextLabel.TextBounds
					local TopBarGoal = {}
					TopBarGoal.Size = UDim2.new(0, textSize.X + 70, 1, 0)
					local FrameGoal = {}
					FrameGoal.Size = UDim2.new(0, textSize.X + 62, 0, 36)
					local ButtonGoal = {}
					ButtonGoal.Size = UDim2.new(0, textSize.X + 62, 0, 36)
					local TextGoal = {}
					TextGoal.Position = UDim2.new(0.9, 0,0, 0)

					local tween1 = TweenService:Create(self.Widget.TopBar, tweenInfo, TopBarGoal)
					local tween2 = TweenService:Create(self.Widget.Frame, tweenInfo, FrameGoal)
					local tween3 = TweenService:Create(self.Widget.Button, tweenInfo,ButtonGoal)
					local tween4 = TweenService:Create(self.Widget.TextLabel, tweenInfo, TextGoal)

					tween1:Play()
					tween2:Play()
					tween3:Play()
					tween4:Play()

					--self.Widget.TopBar.Size = UDim2.new(0, textSize.X + 70, 1, 0)
					--self.Widget.Frame.Size = UDim2.new(0, textSize.X + 60, 0, 34)
					--self.Widget.Button.Size = UDim2.new(0, textSize.X + 60, 0, 34)
					--self.Widget.TextLabel.Position = UDim2.new(0.9, 0,0, 0)
					if LabelChanged == false then
						moveTopBars(textSize.X + 25)
					elseif self.Widget.PreviousText.TextBounds.X > textSize.X then
						moveTopBars(textSize.X - 80)
					elseif self.Widget.PreviousText.TextBounds.X < textSize.X then
						moveTopBars(textSize.X - 80)
					end
				end
			end
		end
		LabelChanged = true
	end
	
	function self.Destroy()
		self.Widget:Destroy()
	end

	return self
end

return Icon
