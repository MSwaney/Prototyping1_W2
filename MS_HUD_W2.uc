//------------------------------------------------------------------------------------------------ 
// Author: Matthew Swaney
// Date: 01-10-2014
// Credit: Christopher Maxwell 
// Credit: https://dl.dropbox.com/s/nfect75ubi7ikb7/FSGDnBS_PT1_W1_01_HUD.wmv?&dl=1                 // Week 1
// Credit: https://dl.dropbox.com/s/44f6k13evo4gl0h/FSGDnBS_PT1_W1_02_HUD_DrawText.wmv?&dl=1        // Week 1
// Credit: https://dl.dropbox.com/s/9xpir4kvkh4rjm4/FSGDnBS_PT1_W1_03_HUD_DrawTile.wmv?&dl=1        // Week 1
// Credit: https://dl.dropbox.com/s/umu7fnx224i8lsd/FSGDnBS_PT1_W1_04_GameType_Timer.wmv?&dl=1      // Week 1
// Credit: UDN
// Credit: https://udn.epicgames.com/Three/HUDTechnicalGuide.html
// 
// Purpose: Create a custom HUD for the week 2 Assignment. 
//------------------------------------------------------------------------------------------------ 
class MS_HUD_W2 extends HUD;

//-Variables--------------------------------------------------------------------------------------

var Font m_font;
var Texture2D m_texture;
var string cameraName;

//------------------------------------------------------------------------------------------------ 
function DrawHUD()
{
	super.DrawHUD();

	drawScore();
	myTexture(850, 15);
	DrawTimers();
	DrawCameraName();
}

//------------------------------------------------------------------------------------------------ 
event PostRender()
{
	super.PostRender();
}

//------------------------------------------------------------------------------------------------ 
function drawScore()
{
	local MS_GameType_W2 rGame;

	rGame = MS_GameType_W2(WorldInfo.Game);
	if(rGame != none)
	{	
		Canvas.SetPos(15, 65);
		Canvas.SetDrawColor(65, 105, 225);
		Canvas.DrawText("Score: " @ rGame.nScore);
		Canvas.Font = m_font;
	}


}
//------------------------------------------------------------------------------------------------ 
function myTexture(float x, float y)
{
	Canvas.SetPos(x , y);
	Canvas.SetDrawColor(255, 255, 255);
	Canvas.DrawTile(m_texture, m_texture.SizeX / 4, m_texture.SizeY / 4, 0, 0, m_texture.SizeX, m_texture.SizeY);
}

// Draw the Game Timer and Play Timer to the HUD-------------------------------------------
function DrawTimers()
{
	local WorldInfo rWorldInfo;
	local MS_GameType_W2 rGame;
	local string rText;

	rWorldInfo = class'WorldInfo'.static.GetWorldInfo();
	if( rWorldInfo != none )
	{
		rGame = MS_GameType_W2( rWorldInfo.Game );
		if(rGame != none )
		{
			// Play Timer
			rText = "Play Time: " @ rGame.m_playTimer;
			rText = Left(rText, InStr(rText, ".") + 2);
			Canvas.SetPos( 15, 15);
			Canvas.Font = m_font;
			Canvas.SetDrawColor(65, 105, 225);
			Canvas.DrawText( rText, , 0.5, 0.5);

			// Game Timer
			rText = "GameTimer: " @ rGame.m_gameTimer;
			rText = Left(rText, InStr(rText, ".") + 2);
			Canvas.SetPos( 15, 40);
			Canvas.Font = m_font;
			if( rGame.m_gameTimer < 5)
			{
				Canvas.SetDrawColor(255, 0, 0);
			} 
			else
			{
				Canvas.SetDrawColor(65, 105, 225);
			}
			Canvas.DrawText( rText, , 0.5, 0.5);
		}
	}
}

//------------------------------------------------------------------------------------------------
function DrawCameraName()
{
	Canvas.SetPos(15, 90);
	Canvas.Font = m_font;
	Canvas.SetDrawColor(255, 0, 0);
	Canvas.DrawText("Camera:" @ cameraName);
}

//------------------------------------------------------------------------------------------------
DefaultProperties
{
	m_font = Font'UI_Fonts.Fonts.UI_Fonts_Positec36'
	m_texture = Texture2D'UDKHUD.ut3_minimap_compass'

	cameraName = "First Person"
}
