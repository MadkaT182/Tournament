return Def.ActorFrame {
    OffCommand=function(self)
    	PushScores();
        SCREENMAN:SystemMessage("Scores Saved!");
    end;
};