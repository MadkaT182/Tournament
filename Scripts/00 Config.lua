function InitVars()
	--Config you tournament
	--Amount of players
	PlayerMax=5
	--Number of rounds to play
	RoundMax=3
	ActualRound=1
	--Scores for every player
	ScoreP1 = 0
	ScoreP2 = 0
	--Create leaderboards for every round
	CreateLeaderBoards();
	SCREENMAN:SystemMessage("Settings Initialized!");
end

function GetRoundSong(round)
	local Songs = {
		[1] = "KarateMan",
		[2] = "Sunlight",
		[3] = "HELL SCAPER -Last Escape Remix-"
	};
	return Songs[round] or "fallback"
end

function GetRoundDifficulty(round)
	local Difficulties = {
		[1] = "Difficulty_Challenge",
		[2] = "Difficulty_Hard",
		[3] = "Difficulty_Hard"
	};
	return Difficulties[round] or "Difficulty_Hard"
end

function CreateLeaderBoards()
	Rankings = {};
end

function PushScores()
	for player in ivalues(GAMESTATE:GetHumanPlayers()) do
		if player == PLAYER_1 then
			Rankings[#Rankings+1]=ScoreP1;
		elseif player == PLAYER_2 then
			Rankings[#Rankings+1]=ScoreP2;
		end
	end
end

function GetStyle(index)
	local Style = {
		[1] = "single",
		[2] = "versus",
		[3] = "double"
	};
	return Style[index] or "versus"
end

function NextStage()
	ActualRound = ActualRound +1;
	PlayerMax = math.ceil(#Rankings/2)
	ScoreP1 = 0
	ScoreP2 = 0
	Rankings = {};
end