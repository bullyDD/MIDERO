with Hardware_Configuration;

package body Vehicle is   
   --  This must be done before any software commands 
   --  or accesses to those motors.
   procedure Initialize_Motors (M1, M2, M3, M4 : in out Motor);
   --  procedure Turn_Left;
   --  procedure Turn_Right;
   --  procedure Draw_Square;
   -----------------
   -- Test_Engage --
   -----------------
   procedure Test_Engage is
      Dir   : constant Directions := Forward;
      Power : constant Power_Level := 50;
   begin
      Motor_Bottom_Left.Engage (Direction  => Dir,
                                Power      => Power);
      Motor_Bottom_Right.Engage (Direction => Dir,
                                 Power     => Power);
      Motor_Top_Left.Engage (Direction  => Dir,
                             Power      => Power);
      Motor_Top_Right.Engage (Direction => Dir,
                              Power     => Power);
   end Test_Engage;
   ---------------
   -- Test_Stop --
   ---------------
   procedure Test_Stop is
   begin
      Motor_Bottom_Left.Stop;
      Motor_Bottom_Right.Stop;
      Motor_Top_Left.Stop;
      Motor_Top_Right.Stop;
   end Test_Stop;
   -----------------------
   -- Initialize_Motors --
   -----------------------
   procedure Initialize_Motors (M1, M2, M3, M4 : in out Motor) is
      use Hardware_Configuration;
   begin
      --  Motor Bottom Right
      M1.Initialize (Encoder_Input1       => Motor1_Encoder_Input1,
                     Encoder_Input2       => Motor1_Encoder_Input2,
                     Encoder_Timer        => Motor1_Encoder_Timer,
                     Encoder_AF           => Motor1_Encoder_AF,
                     PWM_Timer            => Motor1_PWM_Engine_TMR,
                     PWM_Output_Frequency => Motor_PWM_Freq,
                     PWM_AF               => Motor1_PWM_Output_AF,
                     PWM_Output           => Motor1_PWM_Engine,
                     PWM_Output_Channel   => Motor1_PWM_Channel,
                     Polarity1            => Motor1_Polarity1,
                     Polarity2            => Motor1_Polarity2);
      --  Motor Bottom Left  
      M2.Initialize (Encoder_Input1       => Motor2_Encoder_Input1,
                     Encoder_Input2       => Motor2_Encoder_Input2,
                     Encoder_Timer        => Motor2_Encoder_Timer,
                     Encoder_AF           => Motor2_Encoder_AF,
                     PWM_Timer            => Motor2_PWM_Engine_TMR,
                     PWM_Output_Frequency => Motor_PWM_Freq,
                     PWM_AF               => Motor2_PWM_Output_AF,
                     PWM_Output           => Motor2_PWM_Engine,
                     PWM_Output_Channel   => Motor2_PWM_Channel,
                     Polarity1            => Motor2_Polarity1,
                     Polarity2            => Motor2_Polarity2);
      --  Motor Top Left
      M3.Initialize (Encoder_Input1       => Motor3_Encoder_Input1,
                     Encoder_Input2       => Motor3_Encoder_Input2,
                     Encoder_Timer        => Motor3_Encoder_Timer,
                     Encoder_AF           => Motor3_Encoder_AF,
                     PWM_Timer            => Motor3_PWM_Engine_TMR,
                     PWM_Output_Frequency => Motor_PWM_Freq,
                     PWM_AF               => Motor3_PWM_Output_AF,
                     PWM_Output           => Motor3_PWM_Engine,
                     PWM_Output_Channel   => Motor3_PWM_Channel,
                     Polarity1            => Motor3_Polarity1,
                     Polarity2            => Motor3_Polarity2);
      --  Motor Top Right
      M4.Initialize (Encoder_Input1       => Motor4_Encoder_Input1,
                     Encoder_Input2       => Motor4_Encoder_Input2,
                     Encoder_Timer        => Motor4_Encoder_Timer,
                     Encoder_AF           => Motor4_Encoder_AF,
                     PWM_Timer            => Motor4_PWM_Engine_TMR,
                     PWM_Output_Frequency => Motor_PWM_Freq,
                     PWM_AF               => Motor4_PWM_Output_AF,
                     PWM_Output           => Motor4_PWM_Engine,
                     PWM_Output_Channel   => Motor4_PWM_Channel,
                     Polarity1            => Motor4_Polarity1,
                     Polarity2            => Motor4_Polarity2);
   end Initialize_Motors;
   ----------------
   -- Initialize --
   ----------------
   procedure Initialize is
   begin
      Initialize_Motors (M1 => Motor_Bottom_Right, M2 => Motor_Bottom_Left,
                         M3 => Motor_Top_Left,     M4 => Motor_Top_Right);
   end Initialize;
begin
   Initialize;
end Vehicle;
