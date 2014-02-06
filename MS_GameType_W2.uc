//------------------------------------------------------------------------------------------------ 
// Author: Matthew Swaney
// Date: 01-10-2014
// Credit: Christopher Maxwell 
// Credit: https://dl.dropbox.com/s/616u3txmr1wzi9e/FSGDnBS_PT1_W1_00_GameType.wmv?&dl=1    // Week 1
// Credit: UDN
// Credit: http://udn.epicgames.com/Three/GametypeTechnicalGuide.html
// 
// Purpose: Create a custom game type for the Week 2 Assignment. 
//------------------------------------------------------------------------------------------------ 
class MS_GameType_W2 extends UTGame;

//-Variables--------------------------------------------------------------------------------------  
var int nScore;
var float m_gameTimer;
var float m_playTimer;
var bool eventFireA;
var bool eventFireB;

//------------------------------------------------------------------------------------------------ 
function PostBeginPlay()
{
	super.PostBeginPlay();
}

//------------------------------------------------------------------------------------------------ 
function tick(float deltaTime)
{
	m_playTimer += deltaTime;

	m_gameTimer -= deltaTime;
	if(m_gameTimer < 0)
	{
		m_gameTimer = 0;
	}
	if(m_gameTimer > 5 && eventFireB == false)
	{
		TriggerGlobalEventClass(class'MS_Event', self);
	}
}

//------------------------------------------------------------------------------------------------ 
DefaultProperties
{
	HUDType=class'Swaney_Matthew_W2_src.MS_HUD_W2'

	// The "body"
	DefaultPawnClass = class'MS_Pawn'

	// The "brain"
	PlayerControllerClass = class'MS_PlayerController'

	// Disable the Scaleform (flash) hud in tshe UTGame. See: GenericPlayerInitialization
	bUseClassicHUD = true

	nScore = 0

	m_gameTimer = 10;

	eventFireA = false;
	eventFireB = false;
}
