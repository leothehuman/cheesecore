; #######################################################################
; ###### RRF3 Configuration file for RailcoreII ZL Series Printers ######
; #######################################################################

; #### Debugging
M111 S0                     ; Debug off
M929 P"eventlog.txt" S1     ; Start logging to file eventlog.txt
M550 P"RailCore"            ; Machine name and Netbios name (can be anything you like)

M540 PDE:AD:BE:EF:CA:FE     ; Set MAC address (unused on DuetWifi)
M552 S1                     ; Enable networking
M552 P0.0.0.0               ; Use DHCP

; #### General preferences
M555 P2                     ; Set output to look like Marlin
M575 P1 B57600 S1           ; Comms parameters for PanelDue
G21                         ; Work in millimetres
G90                         ; Send absolute coordinates...
M83                         ; ...but relative extruder moves

; #### Networking and Communications
M552 S1                     ; Enable WiFi
M586 P1 S1                  ; Enable  FTP (default) S0 to disable
;M551 P"myrap"              ; Machine password (used for FTP), leave disabled for anonymous login on a local network.
M586 P2 S1                  ; Enable Telnet (default) S1 to disable

; #### Axis and motor configuration
M669 K1                     ; CoreXY mode
M350 X16 Y16 Z16 E16 I1     ; Set 16x microstepping for axes & extruder, with interpolation.
M92 X200 Y200               ; Set 200 steps/mm for XY (0.9 deg/step . 16 tooth pulley and GT2 belt)

; #### Drives
M584 X0 Y1 Z5:6:7 E3:4:8:9  ; Map Z to drivers 5, 6, 7. Define unused drivers 3,4,8 and 9 as extruders
M569 P0 S0                  ; Drive 0 goes forwards (change to S0 to reverse it)| X stepper
M569 P1 S1                  ; Drive 1 goes backwards(change to S1 to reverse it)| Y Stepper
M569 P2 S1                  ; Drive 2 goes forwards                             | Unused
M569 P3 S1                  ; Drive 3 goes forwards                             | Extruder S1 for Bondtech, S0 for Titan
M569 P4 S1                  ; Drive 4 goes forwards                             | Extruder (unused)
M569 P5 S0                  ; Drive 5 goes backwards                            | Front Left Z
M569 P6 S0                  ; Drive 6 goes backwards                            | Rear Left Z
M569 P7 S0                  ; Drive 7 goes backwards                            | Right Z

; #### Leadscrew locations
;Front left,(-10,22.5) Rear Left (-10.,227.5) , Right (333,160) S10 is the max correction - measure your own offsets, to the bolt for the yoke of each leadscrew
M671 X-10:-10:333 Y22.5:277.5:150 S10

; #### Endstop Configuration - sensorless
M574 X1 S3                                ; _RRF3_ set X endstop to xstop port sensorless
M574 Y1 S3                                ; _RRF3_ set Y endstop to ystop port sensorless
M915 P0:1 S3 R0 F0                        ; Both motors because corexy; Sensitivity 3, don’t take action, don’t filter

; #### Endstop Configuration - microswitches
;M574 X1 S1 P"xstop"                      ; _RRF3_ set X endstop to xstop port (switch/active high)
;M574 Y1 S1 P"ystop"                      ; _RRF3_ set Y endstop to ystop port (switch/active high)

; #### Current, speeds and Z/E step settings
; Fully commissioned speeds.
M906 X1300 Y1300 Z1200 E560 I20   ; Set motor currents (mA) and idle at 10%
M201 X4000 Y4000 Z100 E1500       ; Accelerations (mm/s^2)
M204 P1400 T4000                  ; General maximum acceleration P(print) T(travel)
M203 X24000 Y24000 Z800 E3600     ; Maximum speeds (mm/min)
M566 X1000 Y1000 Z100 E1500       ; Maximum jerk speeds mm/minute
M92 Z800                          ; Leadscrew motor axis steps/mm for Z - TR8*4 / 1.8 deg stepper or TR8*8 / 0.9 deg stepper
M92 E415                          ; Extruder steps/mm - 1.8 deg/step Steps/mm (Standard BMG pancake stepper 17HS10-0704S)

;M92 Z1600                        ; Steps/mm for Z - TR8*2 / 1.8 deg stepper or TR8*4 / 0.9 deg stepper
;M92 E837                         ; Extruder - 0.9 deg/step (ProjectR3D kit with E3D stepper MT-1701HSM140AE or Standard Titan stepper 42BYGHM208P4.5-15-X2)

; Conservative speeds
;M906 X850 Y850 Z600 E700 I60     ; Motor currents (mA) - WARNING: Conservative - May trigger stallguard (and prematurely during homing) if sensorless.
;M201 X500 Y500 Z02 E500          ; Accelerations (mm/s^2) - WARNING: Conservative
;M203 X3000 Y3000 Z50 E1800       ; Maximum speeds (mm/min) - WARNING: Conservative
;M566 X200 Y200 Z5 E10            ; Maximum jerk speeds mm/minute - WARNING: Conservative

; ####  Set axis minima:maxima switch positions
; Adjust to suit your machine and to make X=0 and Y=0 the edges of the bed
;M208 X0:250 Y0:250 Z-0.2:230     ; Conservative 300ZL/T settings (or 250ZL) ; These values are conservative to start with, adjust during commissioning.
M208 X0:300 Y-8:300 Z0:610        ; 300ZLT


; #### Heaters
;M570 S360                       ; Print will be terminated if a heater fault is not reset within 360 minutes.
M143 H0 S80                      ; Maximum H0 (Bed) heater temperature (Conservative)
M143 H1 S230                     ; Maximum H1 (Extruder) heater temperature (Conservative and in case extruder has PTFE lining)
M140 S-273.1 R-273.1             ; Standby and initial Temp for bed as "off" (-273.1 = "off")


; #### Fans
M950 F0 C"nil" Q500              ;_RRF3_ define fan0 (free pin as dead fan)
M950 F1 C"fan1" Q500             ;_RRF3_ define fan1
M950 F2 C"fan2" Q500             ;_RRF3_ define fan2
M950 F6 C"duex.fan6"             ;_RRF3_ define fan6
M950 F7 C"duex.fan7"             ;_RRF3_ define fan7
M950 F8 C"duex.fan8"             ;_RRF3_ define fan8

M106 P0 H-1                      ; Disable thermostatic mode for fan 0
M106 P1 H-1                      ; Disable thermostatic mode for fan 1

M106 P0 S0                       ; Turn off fan0
M106 P1 S0                       ; Turn off fan1
M106 P2 S0                       ; Turn off fan2


; #### Tool definitions
; #### Tool E0 / Heater 1 - E3D Gold
M950 H1 C"e0heat" T1                        ;_RRF3_ define Hotend heater is on e0heat
M308 S1 P"e0temp" Y"thermistor" A"e0_heat" T100000 B4725 R4700 C7.06e-8 H0 L0 ;_RRF3_ E0 thermistor,
M563 P0 D0 H1                               ; Define tool 0
G10 P0 S0 R0                                ; Set tool 0 operating and standby temperatures
M563 P0 S"E3Dv6 Gold" D0 H1 F2              ; Define tool 0 uses extruder 0, heater 1 ,Fan 2
G10 P0 X0 Y0 Z0                             ; Set tool 0 axis offsets
M143 H1 S295                                ; Maximum Extruder 0 temperature (E3D requires 285C to change nozzle)
M570 H1 P5 T25                              ; Configure heater fault detection
                                            ; Hnnn Heater number
                                            ; Pnnn Time in seconds for which a temperature anomaly must persist on this heater before raising a heater fault.
                                            ; Tnnn Permitted temperature excursion from the setpoint for this heater (default 15C);
M106 P6 S1 H1 T45 C"Hotend"                 ; Set fan 1. Thermostatic control is ON for Heater 1 (Hotend fan)
M106 P2 S0 H-1 C"Part"                      ; (Part cooling fan) Set fan 2 value, Thermostatic control is OFF

; #### Z probe
; #### Z probe and compensation definition
M558 P1 C"^zprobe.in"                       ; _RRF3_ IR Probe connected to Z probe IN pin
M558 H10 A1 T3000 S0.02                     ; Z probe - raise probe height.
                                            ; H10 - dive height
                                            ; A bigger dive height prevents a situation where the bed is out of alignment by more than the dive 
                                            ; height on any corner, which can crash the hot-end into the bed while moving the head in XY.
                                            ; Probing speed and travel speed are similarly reduced in case the Z probe is not connected properly 
                                            ; (or disconnects later after moving to a point) giving the user more time to stop.

; #### Probing configuration
M558 P1                                     ; IR probe
G31 X0 Y35 P500                             ; Probe offset and "stop" value.
G31 Z0.58                                   ; Probe Z height (papertest)
M558 A1 S0.01                               ; Probing : (A) number of probes  (S) accuracy over multiple probes.
                                            ; (T) travel speed and (H) height are set in sys/macros
; ##### Mesh
;M557 X50:200 Y50:200 S150 S150             ; Set Default Mesh (conservative)
M557 X30:280 Y30:280 P2                     ; Set Mesh for probe

; #### Filament runout
; M591 D0 P1 C3 S1                          ; Enable Sunhokey filament sensor runout (disabled)
; Configure filament sensing
; D0 - Extruder 0
; P - Sensor type - 1=simple sensor (high signal when filament present)
; C - Which input the filament sensor is connected to. On Duet electronics: 3=E0 endstop input
; S - 1 = enable filament monitoring when printing from SD card.

; #### Bed - Heater 0
M950 H0 C"bedheat" T0                                                           ;_RRF3_ define Bed heater is on bedheat
M308 S0 P"exp.thermistor6" Y"thermistor" A"bed_heat" T100000 B3950 R4700 H0 L0  ;_RRF3_ Bed thermistor, connected to bedtemp on Duet2
M143 H0 S130                                                                    ; Maximum bed temperature
M308 S8 P"exp.thermistor7" Y"thermistor" A"keenovo" T100000 B3950 R4700  H0 L0  ; Silicone heater thermistor on x7

; #### Chamber - Heater 3 - (not enabled yet)
;M141 H3                        
;M950 H3 C"exp.heater3" T3                                                           ; heater 3 is the chamber heater 
;M308 S3 P"exp.thermistor3" Y"thermistor" A"keenovo" T100000 B3950 R4700  H0 L0  ; Set Sensor 3 as 100K thermistor with B=3950 and a 4.7K series resistor
;M301 H3 B1                                                                      ; use bang-bang control for the chamber heater
;M106 P3 S1 H1 T50:80 C"Chamber"

; #### Electronics Cabinet
M308 S10 Y"mcu-temp" A"mcu-temp" ; Set MCU on Sensor 10
M106 P7 T35:55 H10 C"Elec.Cab.1" ; Electronics cooling fan that starts to turn on when the MCU temperature (virtual heater 100) reaches 45C
M106 P8 T35:55 H10 C"Elec.Cab.2" ; and reaches full speed when the MCU temperature reaches 55C or if any TMC2660 drivers
                                          ; (N.B. If a fan is configured to trigger on a virtual heater whose sensor represents TMC2660 driver over-temperature
                                          ; flags, then when the fan turns on it will delay the reporting of an over-temperature warning for the corresponding drivers
                                          ; for a few seconds, to give the fan time to cool the driver down.)

; #### Compensation
;M556 S80 X0.8 Y0.3 Z0.72                 ; Axis compensation (measured with Orthangonal Axis Compensation piece)
M579 X1.0027 Y1.0027 Z1.0011              ; Scale Cartesian axes
M572 D0 S0.05                             ; Pressure advance compensation

; #### Default heater model (Overridden by config-override.g, but here in case config-override.g fails)
;M307 H0 A270.7 C90.4 D6.7 B0 S1.0          ; 700W Bed Heater settings.
M307 H0 A186.9 C972.5 D5.3 S1.00 V24.2 B0   ; 300W Bed Heater settings.
M307 H1 A508.1 C249.0 D3.8 S1.00 V24.2 B0   ; E3D Gold hotend settings.


; #### Finish startup
G91 G1 Z0.001 F99999 S2                   ; engage motors to prevent bed from moving after power on.

;M98 P"/sys/config-user.g"                 ; Load custom user config (designed to be able to be empty, so feel free to comment out)
M501                                      ; Load saved parameters from non-volatile memory
