local t = Def.ActorFrame{};

function Arrange(self)
	table.sort( Rankings, compare);
end;

function compare(a, b)    
    if tonumber(a) > tonumber(b) then    
        return true    
    end
end

t[#t+1] =  Def.ActorFrame {
	LoadFont("Common normal")..{
		OnCommand=function(self)
			local percent = (#Rankings*100)/PlayerMax;

			if percent > 100 then
				percent = 100;
			end
			self:x(SCREEN_WIDTH/4);
			self:y(SCREEN_HEIGHT/4);
			self:settext("Stage:"..ActualRound.." - "..percent.."%".."\n"..GetRoundSong(ActualRound));
		end
	};
	LoadFont("Common normal")..{
		OnCommand=function(self)
			self:x(SCREEN_LEFT+10);
			self:y(25);
			self:horizalign(left);
			self:playcommand("Set");
		end;
		SetCommand=function(self)
			self:settext(MonthToString(MonthOfYear()).."/"..DayOfMonth().."/"..Year());
		end;
	};
	LoadFont("Common normal")..{
		OnCommand=function(self)
			self:x(SCREEN_LEFT+10);
			self:y(50);
			self:horizalign(left);
			self:playcommand("Set");
		end;
		SetCommand=function(self)
			self:settext(string.format('%02i:%02i:%02i', Hour(), Minute(), Second()));
			self:queuecommand("Repeat");
		end;
		RepeatCommand=cmd(sleep,1;playcommand,"Set");
	};
	Def.Quad{
		OnCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y;horizalign,right;diffuse,color("#000000");diffusealpha,.5;zoomto,SCREEN_WIDTH/3,SCREEN_HEIGHT);
	};
	LoadFont("Common normal")..{
		OnCommand=function(self)
			self:x(SCREEN_RIGHT-SCREEN_WIDTH/6);
			self:y(50);
			self:settext("Leaderboards:");
		end
	};
	Def.ActorFrame {
		CodeMessageCommand = function(self, params)
			if params.Name == 'Next' then
				SCREENMAN:SystemMessage("Start Playing!");
				--Set song
				local newSong = SONGMAN:FindSong(GetRoundSong(ActualRound));
				
				local newStep = newSong:GetOneSteps('StepsType_Dance_Single',GetRoundDifficulty(ActualRound));
				--local newStep = newSong:GetOneSteps('StepsType_Dance_Single','Difficulty_Challenge');

				if newSong then
					GAMESTATE:SetCurrentSong(newSong);
					for player in ivalues(GAMESTATE:GetHumanPlayers()) do
						GAMESTATE:AddStageToPlayer(player);
						GAMESTATE:ResetPlayerOptions(player);
						GAMESTATE:SetCurrentSteps(player,newStep);
						SCREENMAN:GetTopScreen():PostScreenMessage("SM_GoToNextScreen",0.1);
					end
					SOUND:PlayOnce(THEME:GetPathS("Common","Start"));
					SCREENMAN:SystemMessage("Song found!");
				else
					SCREENMAN:SystemMessage("No song found!");
				end
			elseif params.Name == 'Continue' then
				NextStage();
				if ActualRound > RoundMax then
					SCREENMAN:GetTopScreen():SetNextScreenName("ScreenGameOver");
				else
					SCREENMAN:GetTopScreen():SetNextScreenName("ScreenLobby");
				end
				SCREENMAN:GetTopScreen():PostScreenMessage("SM_GoToNextScreen",0.1);
			end
		end;
	};
	--SM(Rankings);
	Arrange();
	--Help text
	LoadFont("Common normal")..{
		OnCommand=function(self)
			local percent = (#Rankings*100)/PlayerMax;
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_BOTTOM-30);

			if percent>=100 then
				self:settext("Can advance to the next stage!");
			end
		end
	};
};

for i=1,#Rankings do
	t[#t+1] =  Def.ActorFrame {
		LoadFont("Common normal")..{
			OnCommand=function(self)
				self:x(SCREEN_RIGHT-50);
				self:y(80+(25*i));
				self:horizalign(right);
				self:settext(Rankings[i]);
				if #Rankings >= PlayerMax then
					if i == 1 then
						self:rainbowscroll(true);
					elseif tonumber(Rankings[i]) <= 0 then
						self:diffuse(color("#FF0000"));
					else
						self:diffuse(color("#00FFFF"))
					end
					--Turn red the lower half
					if i > math.ceil(#Rankings/2) then
						self:diffuse(color("#FF0000"));
					end
				else
					self:diffuse(color("#FFFFFF"))
				end
			end
		};
	};
end

return t;