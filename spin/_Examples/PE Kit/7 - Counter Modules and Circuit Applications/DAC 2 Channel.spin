''This code example is from Propeller Education Kit Labs: Fundamentals, v1.2.
''A .pdf copy of the book is available from www.parallax.com, and also through
''the Propeller Tool software's Help menu (v1.2.6 or newer).
''
''DAC 2 Channel.spin
''2 channel DAC object.  Each channel is configurable for both I/O pin and
''resolution (bits).

VAR
  ' Stores values that function as LSB scalars for the FRQ registers.
  long lsb[2]
  
PUB Init(channel, ioPin, bits, level)
{{
Initialize a DAC.
  • channel - 0 or 1
  • ioPin   - Choose DAC I/O pin
  • bits    - Resolution (8 bits, 10 bits, etc.)
                                                       bits
  • level   - Initial voltage level = 3.3 V * level ÷ 2 
}}                                                
  dira[ioPin]~                                   ' Set I/O pin to input
  spr[8 + channel] := (%00110 << 26) + ioPin     ' Configure CTR for duty mode and 
                                                 ' I/O pin
  lsb[channel] := |< (32 - bits)                 ' Define LSB for FRQ register
  Update(channel, level)                         ' Set inital duty
  dira[ioPin] ~~                                 ' Set I/O pin to output

PUB Update(channel, level)
'' Update the level transmitted by DAC channel to:
''                            bits 
''   level = 3.3 V * level ÷ 2     
  spr[10 + channel] := level * lsb[channel]      ' Update DAC output

PUB Remove(channel)
''Reclaim the counter module and set the associated I/O pin to input. 
  dira[spr[8+channel] & %111111]~                ' Set I/O pin to input
  spr[8+channel]~                                ' Clear channel's CTR register