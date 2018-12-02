local t = Def.ActorFrame {};
local players = GAMESTATE:GetNumSidesJoined();

for player in ivalues(GAMESTATE:GetHumanPlayers()) do
	--Vars
	local Score = string.format("% 7d",STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetScore());
	local Combo = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):MaxCombo();
	local Marvelous = string.format("% 5d",STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W1"));
	local Perfect = string.format("% 5d",STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W2"));
	local Great = string.format("% 5d",STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W3"));
	local Good = string.format("% 5d",STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W4"));
	local Ok = string.format("% 5d",STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetHoldNoteScores("HoldNoteScore_Held"));
	local Miss = string.format("% 5d",STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_Miss"));
	local Almost = string.format("% 5d",STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W5"));
	local NG = string.format("% 5d",STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetHoldNoteScores("HoldNoteScore_LetGo"));
	local EXScore = (Marvelous * 3) + (Perfect * 2) + Great + (Ok * 3);

	--Set score var for saving
	if ThemePrefs.Get("ExResult") then
		--DDREX Score
		if player == PLAYER_1 then
			ScoreP1 = EXScore;
		else
			ScoreP2 = EXScore;
		end
	else
		--ITG Percent
		local percent = FormatPercentScore(STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints());
		if player == PLAYER_1 then
			ScoreP1 = string.gsub(percent, "%%", "");
		else
			ScoreP2 = string.gsub(percent, "%%", "");
		end
	end

	t[#t+1] = Def.ActorFrame{
		--Stats BG
		InitCommand=function(self)
			self:y(SCREEN_CENTER_Y-60);
			if players > 1 then
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-180 or SCREEN_CENTER_X+180);
			else
				self:x(SCREEN_CENTER_X);
			end
		end;
		--Player label
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:settext(player == PLAYER_1 and "PLAYER 1" or "PLAYER 2");
				self:zoom(.45);
				self:x(-140);
				self:y(-79);
				self:diffuse(color("#BDBCBE"));
			end;
		};
		--Stats
		--Score
		LoadFont("Common normal")..{
			Text="SCORE EX";
			InitCommand=cmd(x,-155;y,-58;zoom,.65;horizalign,left;diffuse,color("#BDBCBE"));
			Condition=ThemePrefs.Get("ExResult");
		};
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:x(13);
				self:y(-58);
				self:zoom(.65);
				self:horizalign(right);
				self:diffuse(color("#BDBCBE"));
				self:settext(EXScore);
			end;
			Condition=ThemePrefs.Get("ExResult");
		};
		LoadFont("Common normal")..{
			Text="SCORE";
			InitCommand=cmd(x,-155;y,-58;zoom,.65;horizalign,left;diffuse,color("#BDBCBE"));
			Condition=not ThemePrefs.Get("ExResult");
		};
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:x(13);
				self:y(-58);
				self:zoom(.65);
				self:horizalign(right);
				self:diffuse(color("#BDBCBE"));
				self:settext(FormatPercentScore(STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()));
			end;
			Condition=not ThemePrefs.Get("ExResult");
		};
		LoadFont("Common normal")..{
			Text="COMBO";
			InitCommand=cmd(x,-155;y,-38;zoom,.65;horizalign,left;diffuse,color("#BDBCBE"));
		};
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:x(13);
				self:y(-38);
				self:zoom(.65);
				self:horizalign(right);
				self:diffuse(color("#BDBCBE"));
				self:settext(Combo);
			end;
		};
		LoadFont("Common normal")..{
			Text="MARVELOUS!";
			InitCommand=cmd(x,-156;y,-20;zoom,.55;horizalign,left);
		};
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:x(13);
				self:y(-20);
				self:zoom(.55);
				self:horizalign(right);
				self:settext(Marvelous);
			end;
		};
		LoadFont("Common normal")..{
			Text="PERFECT";
			InitCommand=cmd(x,-156;y,-4;zoom,.55;horizalign,left;diffuse,color("#FFFF80"));
		};
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:x(13);
				self:y(-4);
				self:zoom(.55);
				self:horizalign(right);
				self:diffuse(color("#FFFF80"));
				self:settext(Perfect);
			end;
		};
		LoadFont("Common normal")..{
			Text="GREAT";
			InitCommand=cmd(x,-156;y,12;zoom,.55;horizalign,left;diffuse,color("#80FF80"));
		};
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:x(13);
				self:y(12);
				self:zoom(.55);
				self:horizalign(right);
				self:diffuse(color("#80FF80"));
				self:settext(Great);
			end;
		};
		LoadFont("Common normal")..{
			Text="GOOD";
			InitCommand=cmd(x,-156;y,28;zoom,.55;horizalign,left;diffuse,color("#66EEFC"));
		};
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:x(13);
				self:y(28);
				self:zoom(.55);
				self:horizalign(right);
				self:diffuse(color("#66EEFC"));
				self:settext(Good);
			end;
		};
		LoadFont("Common normal")..{
			Text="BOO";
			InitCommand=cmd(x,-156;y,44;zoom,.55;horizalign,left;diffuse,color("#F8656D"));
		};
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:x(13);
				self:y(44);
				self:zoom(.55);
				self:horizalign(right);
				self:diffuse(color("#F8656D"));
				self:settext(Almost);
			end;
		};
		LoadFont("Common normal")..{
			Text="MISS";
			InitCommand=cmd(x,-156;y,60;zoom,.55;horizalign,left;diffuse,color("#FF0000"));
		};
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:x(13);
				self:y(60);
				self:zoom(.55);
				self:horizalign(right);
				self:diffuse(color("#FF0000"));
				self:settext(Miss+NG);
			end;
		};
		LoadFont("Common normal")..{
			Text="OK";
			InitCommand=cmd(x,-156;y,76;zoom,.55;horizalign,left);
		};
		LoadFont("Common normal")..{
			InitCommand=function(self)
				self:x(13);
				self:y(76);
				self:zoom(.55);
				self:horizalign(right);
				self:settext(Ok);
			end;
		};
	};

end

return t;