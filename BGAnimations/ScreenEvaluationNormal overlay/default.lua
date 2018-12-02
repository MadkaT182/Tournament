return Def.ActorFrame {
	LoadFont("Common normal")..{
		OnCommand=function(self)
			self:settext("RESULTS");
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_TOP+34);
		end;
	};
	LoadActor("stats");
}