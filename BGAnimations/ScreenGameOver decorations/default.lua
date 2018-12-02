return Def.ActorFrame{
	LoadFont("Common normal")..{
		OnCommand=cmd(Center;settext,"Thanks for playing";sleep,5);
	};
}