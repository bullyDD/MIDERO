with System;        use System;
--  with STM32.Device;  use STM32.Device;
with STM32_SVD;     use STM32_SVD;

package body Quadrature_Encoders is

   -----------------------
   -- Current_Direction --
   -----------------------
   function Current_Direction (This : Rotary_Encoder) return Counting_Direction
   is
   begin
      case Current_Counter_Mode (This.all) is
         when Up => return Up;
         when Down => return Down;
         when others => raise Program_Error;
      end case;
   end Current_Direction;
   -----------------
   -- Reset_Count --
   -----------------
   procedure Reset_Count (This : in out Rotary_Encoder) is
   begin
      Set_Counter (This.all, UInt16'(0));
   end Reset_Count;
   -------------------
   -- Current_Count --
   -------------------
   function Current_Count (This : Rotary_Encoder) return UInt32 is
     (Current_Counter (This.all));
   ------------------------
   -- Initialize_Encoder --
   ------------------------
   procedure Initialize_Encoder (This          : in out Rotary_Encoder;
                                 Encoder_TI1   : GPIO_Point;
                                 Encoder_TI2   : GPIO_Point;
                                 Encoder_Timer : not null access Timer;
                                 Encoder_AF    : STM32.GPIO_Alternate_Function)
   is
      Config           : GPIO_Port_Configuration (Mode_AF);
      Debouncer_Filter : Timer_Input_Capture_Filter := 6;
   begin
      null;
   end Initialize_Encoder;
   -------------------
   -- Bidirectional --
   -------------------
   function Bidirectional (This : Timer) return Boolean is
     (This'Address = TIM1_Base or else
      This'Address = TIM2_Base or else
      This'Address = TIM3_Base or else
      This'Address = TIM4_Base or else
      This'Address = TIM5_Base or else
      This'Address = TIM8_Base);

end Quadrature_Encoders;
