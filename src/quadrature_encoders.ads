------------------------------------------------------------------------------
--                                                                          --
--                    Copyright (C) 2017, AdaCore                           --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
------------------------------------------------------------------------------

--  This package provides an interface to a quadrature motor encoder (so
--  stricly speaking it is a decoder). It uses the specific capabilities of
--  selected ST Micro timers to perform this function, thereby relieving the
--  MCU of having to do so (eg via interrupts). The timer essentially acts as
--  an externally clocked counter, driven by the two discrete inputs. All that
--  clients must do, after initialization, is query the counter value. The
--  counter automatically follows the speed and direction of the motor. See
--  especially Application Note AN4013 (DM00042534). See also the RM (RM0090),
--  section 18.3.12 for discussion.
--
--  Note that the encoder count is provided as a value of type UInt32, ie
--  32 bits, but the value may only be 16-bits wide, depending on the timer
--  selected when calling Initialize. We ensure that 32 bits are actually
--  provided by the timer via the precondition on the initialization routine.
--  This implementation comes from Robotic with Ada from Pat Rogers.

with STM32;
with STM32.Device;
with STM32.GPIO;
with STM32.Timers;
with HAL;
with Beta_Types;

package Quadrature_Encoders is

   pragma Elaborate_Body;
   use Beta_Types;
   use HAL;
   use STM32.Device;
   use STM32.GPIO;
   use STM32.Timers;
   
   type Rotary_Encoder is limited private;
   --  Rotary Encoder utilities 
   function  Current_Count (This : Rotary_Encoder) return UInt32 with Inline;
   procedure Reset_Count   (This : in out Rotary_Encoder) with 
     Inline,
     Post => Current_Count (This ) = UInt32'(0);
   type Counting_Direction is (Up, Down);
   function Current_Direction (This : Rotary_Encoder) return Counting_Direction
     with Inline;
   function  Bidirectional (This : Timer) return Boolean;
   procedure Initialize_Encoder (This          : in out Rotary_Encoder;
                                 Encoder_TI1   : GPIO_Point;  -- timer input discrete #1
                                 Encoder_TI2   : GPIO_Point;  -- timer input discrete #2
                                 Encoder_Timer : not null access Timer;
                                 Encoder_AF    : STM32.GPIO_Alternate_Function);
private
   type Rotary_Encoder is access all Timer with Storage_Size => 0;

end Quadrature_Encoders;
