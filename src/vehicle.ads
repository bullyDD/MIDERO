-------------------------------------------------------------------------------
--  This package represents the physical plant, ie the car itself. As such,   -
--  it contains the declarations for the four DC motors.                      -
--  The motors are used for propulsion and steering. Other physical artifacts -
--  are also provided here, such as the mapping of turning directions to motor-
--  rotation direction, the wheel size and gear ratio, and so forth.          -
--  Finally, the package provides runtime information about the car, such as  -
--  the current speed (in centimeters/sec).                                   -
-------------------------------------------------------------------------------

with Engine;

package Vehicle is
   pragma Elaborate_Body;
   use Engine;   
   --  Instantiate 4 Motors and store them in an array of object motor
   Motor_Top_Left     : Motor;
   Motor_Top_Right    : Motor;
   Motor_Bottom_Left  : Motor;
   Motor_Bottom_Right : Motor;
   -----------------------
   -- Vehicle utilities --
   -----------------------
   procedure Initialize;
   procedure Test_Engage with 
     Pre => 
       (Encoder_Count (Motor_Bottom_Left) = 0 and then 
          Throttle (Motor_Bottom_Left) = 0) or else 
       (Encoder_Count (Motor_Bottom_Right) = 0 and then 
          Throttle (Motor_Bottom_Right) = 0);
   procedure Test_Stop;
   --  procedure Move_Forward;
   --  procedure Draw_Square;
end Vehicle;
