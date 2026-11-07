local Players = game:GetService("Players")

local BOOST_SPEED = 28
local NORMAL_SPEED = 16
local BOOST_DURATION = 3
local BOOST_INTERVAL = 10
local MOVEMENT_THRESHOLD = 0.1

local activeCharacters = {}

local function stopBoost(character, humanoid)
	local state = activeCharacters[character]
	if not state then
		return
	end

	state.token += 1
	activeCharacters[character] = nil

	if humanoid and humanoid.Parent then
		humanoid.WalkSpeed = state.originalSpeed or NORMAL_SPEED
	end
end

local function startBoost(character, humanoid)
	if activeCharacters[character] then
		return
	end

	local state = {
		originalSpeed = humanoid.WalkSpeed,
		token = 0,
	}
	activeCharacters[character] = state

	humanoid.WalkSpeed = BOOST_SPEED
	local boostToken = state.token

	task.delay(BOOST_DURATION, function()
		local currentState = activeCharacters[character]
		if currentState ~= state or currentState.token ~= boostToken then
			return
		end

		activeCharacters[character] = nil
		if humanoid.Parent then
			humanoid.WalkSpeed = state.originalSpeed or NORMAL_SPEED
		end
	end)
end

local function setupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")
	local nextBoostAt = 0
	local movementConnection
	local ancestryConnection

	local function cleanup()
		if movementConnection then
			movementConnection:Disconnect()
			movementConnection = nil
		end
		if ancestryConnection then
			ancestryConnection:Disconnect()
			ancestryConnection = nil
		end
		stopBoost(character, humanoid)
	end

	movementConnection = humanoid.Running:Connect(function(speed)
		local now = os.clock()
		if speed <= MOVEMENT_THRESHOLD or now < nextBoostAt then
			return
		end

		nextBoostAt = now + BOOST_INTERVAL
		startBoost(character, humanoid)
	end)

	ancestryConnection = character.AncestryChanged:Connect(function(_, parent)
		if parent == nil then
			cleanup()
		end
	end)

	humanoid.Died:Connect(cleanup)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(setupCharacter)
	if player.Character then
		setupCharacter(player.Character)
	end
end)

for _, player in Players:GetPlayers() do
	player.CharacterAdded:Connect(setupCharacter)
	if player.Character then
		setupCharacter(player.Character)
	end
end
