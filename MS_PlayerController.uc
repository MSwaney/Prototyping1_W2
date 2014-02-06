//------------------------------------------------------------------------------------------------ 
// Author:  Matthew Swaney
// Date:    01-16-2014
// Credit:  Chris Maxwell - Week 2 Lecture
// Credit:  UDN
// Credit:  http://udn.epicgames.com/Three/CameraTechnicalGuide.html#Example
// 
// Purpose: Create player controller perspectives for Week 2 Assignment. 
//------------------------------------------------------------------------------------------------ 
class MS_PlayerController extends UTPlayerController;

state PlayerWalking
{
   function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
   {
      local MS_Pawn P;
      local Rotator tempRot;

          if( (Pawn != None) )
      {
         P = MS_Pawn(Pawn);
         if(P != none)
         {
            if(P.CameraType == CAM_SideScroller)
            {
               Pawn.Acceleration.X = -1 * PlayerInput.aStrafe * DeltaTime * 100 * PlayerInput.MoveForwardSpeed;
               Pawn.Acceleration.Y = 0;
               Pawn.Acceleration.Z = 0;
               
               tempRot.Pitch = P.Rotation.Pitch;
               tempRot.Roll = 0;
               if(Normal(Pawn.Acceleration) Dot Vect(1,0,0) > 0)
               {
                  tempRot.Yaw = 0;
                  P.SetRotation(tempRot);
               }
               else if(Normal(Pawn.Acceleration) Dot Vect(1,0,0) < 0)
               {
                  tempRot.Yaw = 32768;
                  P.SetRotation(tempRot);
               }
            }
            else
            {

               if ( (DoubleClickMove == DCLICK_Active) && (Pawn.Physics == PHYS_Falling) )
                  DoubleClickDir = DCLICK_Active;
               else if ( (DoubleClickMove != DCLICK_None) && (DoubleClickMove < DCLICK_Active) )
               {
                  if ( UTPawn(Pawn).Dodge(DoubleClickMove) )
                     DoubleClickDir = DCLICK_Active;
               }
               
               Pawn.Acceleration = newAccel;
            }

            if (Role == ROLE_Authority)
            {
               // Update ViewPitch for remote clients
               Pawn.SetRemoteViewPitch( Rotation.Pitch );
            }
         }

         CheckJumpOrDuck();
      }
   }
}

function UpdateRotation( float DeltaTime )
{
   local MS_Pawn P;
   local Rotator   DeltaRot, newRotation, ViewRotation;

   P = MS_Pawn(Pawn);

   ViewRotation = Rotation;
   if (p != none && P.CameraType != CAM_SideScroller)
   {
      Pawn.SetDesiredRotation(ViewRotation);
   }

   // Calculate Delta to be applied on ViewRotation
   if( P != none && P.CameraType == CAM_SideScroller )
   {
      DeltaRot.Yaw = Pawn.Rotation.Yaw;
   }
   else
   {
      DeltaRot.Yaw = PlayerInput.aTurn;
   }
   DeltaRot.Pitch = PlayerInput.aLookUp; 

   ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
   SetRotation(ViewRotation);

   ViewShake( deltaTime );

   NewRotation = ViewRotation;
   NewRotation.Roll = Rotation.Roll;

   if (P != None && P.CameraType != CAM_SideScroller )
      Pawn.FaceRotation(NewRotation, deltatime);
}

defaultproperties
{
}