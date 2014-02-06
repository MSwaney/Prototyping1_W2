//------------------------------------------------------------------------------------------------ 
// Author:  Matthew Swaney
// Date:    01-10-2014
// Credit:  Chris Maxwell
// Credit:  https://www.dropbox.com/sh/mx28go8wtma0k9a/tPKR3gjnsq?lst#lh:null-FSGDnBS_PT1_W2_05_Kismet_Event_Outputlinks.wmv
// Credit:  https://www.dropbox.com/sh/mx28go8wtma0k9a/tPKR3gjnsq?lst#lh:null-FSGDnBS_PT1_W2_04_Kismet_Event.wmv
// 
// Purpose: Create a custom event for Week 2 Assignment. 
//------------------------------------------------------------------------------------------------ 
// extend UIEvent if this event should be UI Kismet Event instead of a Level Kismet Event
class MS_Event extends SequenceEvent;

event activated()
{
	`log("It worked");
}

defaultproperties
{
	ObjName="MS_Event"
	ObjCategory="MS Events"
	
	// Empty the Outputs
	OutputLinks.empty

	// Set my own Outputs
	OutputLinks(0) = (LinkDesc = "Out_A")
	OutputLinks(1) = (LinkDesc = "Out_B")

	bPlayerOnly = false
	MaxTriggerCount = 0 // Allows the event to fire an infinite number of times
	bAutoActivateOutputLinks = true // Activate all of the output links
}
