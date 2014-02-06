//------------------------------------------------------------------------------------------------ 
// Author:  Matthew Swaney
// Date:    01-10-2014
// Credit:  Christopher Maxwell 
// Credit:  https://dl.dropbox.com/s/qme1xcb294groef/FSGDnBS_PT1_W2_02_Camera_Action_HUD.wmv?&dl=1
// Credit:  UDN
// Credit:  http://udn.epicgames.com/Three/CameraTechnicalGuide.html#Camera%20Technical%20Guide
// 
// Purpose: Create a kismet action that switches between camera angles for the Week 2 Assignment. 
//------------------------------------------------------------------------------------------------ 
// extend UIAction if this action should be UI Kismet Action instead of a Level Kismet Action
class MS_CameraAction extends SequenceAction;

//-Variables--------------------------------------------------------------------------------------
var Actor ActorObj;

//------------------------------------------------------------------------------------------------
event Activated()
{
	// Third Person Perspective
	if(InputLinks[0].bHasImpulse)
	{
		changeCamera(0);
		updateCameraName("Third Person");
	}
	// Top Down Perspective
	else if(InputLinks[1].bHasImpulse)
	{
		changeCamera(1);
		updateCameraName("Top Down");
	}
	// Sidescroller Perspective
	else if(InputLinks[2].bHasImpulse)
	{
		changeCamera(2);
		updateCameraName("SideScroller");
	}
	// Isometric Perspective
	else if(InputLinks[3].bHasImpulse)
	{
		changeCamera(3);
		updateCameraName("Isometric");
	}
}

//------------------------------------------------------------------------------------------------
function updateCameraName(string cameraName)
{
	// Local variables
	local MS_Pawn rPawn;
	local MS_PlayerController rController;
	local MS_HUD_W2 rHUD;

	// Make sure a valid actor was supplied
	if(ActorObj != none)
	{
		// Try to convert class member variable directly to pawn type.
		rPawn = MS_Pawn(ActorObj);
		if(rPawn != none)
		{
			// Convert the pawn's controller to custom controller type.
			rController = MS_PlayerController( rPawn.Controller );
		}
		// If the conversion failed, try to convert it to custom controller type.
		else
		{
			rController = MS_PlayerController(ActorObj);
		}

		// Check to see if either of the conversions above succeeded.
		if(rController != none)
		{
			// Try and convert the controller's HUD member to custom HUD type.
			rHUD = MS_HUD_W2(rController.myHUD);
			if (rHUD != none)
			{
				// Access the HUD and apply the class member string value.
				rHUD.cameraName = cameraName;
			}
		}
	}
}

//------------------------------------------------------------------------------------------------
function changeCamera(int cameraID)
{
	// Local variables
	local MS_Pawn rPawn;
	local MS_PlayerController rController;

	// Make sure a valid actor was supplied
	if(ActorObj != none)
	{
		// First try and convert the attached actor variable to the controller.
		rController = MS_PlayerController(ActorObj);
		if(rController != none)
		{
			rPawn = MS_Pawn(rController.Pawn);
		}
		
		// If the actor failed to be converted to a controller or the controller's pawn
		// is null, then try to convert the actor to the custom pawn type.
		if(rPawn == none)
		{
			rPawn = MS_Pawn(ActorObj);
		}

		// If the actor has been successfully populated & converted,
		// change its camera mode.
		if(rPawn != none)
		{
			// Third Person
			if(cameraID == 0)
			{
				rPawn.CameraMode(CAM_ThirdPerson);
			}
			// Top Down
			else if(cameraID == 1)
			{
				rPawn.CameraMode(CAM_TopDown);
			}
			// Side Scroller
			else if(cameraID == 2)
			{
				rPawn.CameraMode(CAM_SideScroller);
			}
			// Isometric
			else if(cameraID == 3)
			{
				rPawn.CameraMode(CAM_Isometric);
			}
			// Log Errors
			else
			{
				`log("Bad camera ID: " @ cameraID);
			}
		}
	}
}

defaultproperties
{
	ObjName="MS_CameraAction"
	ObjCategory="MyUdkProject2010 Actions"

	// Empy Inputs
	InputLinks.empty

	// Create my own inputs
	InputLinks(0) = (LinkDesc="Third-Person");
	InputLinks(1) = (LinkDesc="Top-Down");
	InputLinks(2) = (LinkDesc="SideScroller");
	InputLinks(3) = (LinkDesc="Isometric");
	
	// Empy Variables
	VariableLinks.empty

	// Create my own variables
	VariableLinks(0) = (ExpectedType = class'SeqVar_Object', LinkDesc= "Player", PropertyName = ActorObj);

	ActorObj = none

	bCallHandler = false

	bAutoActivateOutputLinks = false
}
