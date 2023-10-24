RSC = peripheral.find("Create_RotationSpeedController")
SOM = peripheral.find("Create_Stressometer")
 
if term.isColour() then 
    shell.run("bg")
    term.setTextColour(colors.orange)
    print("Auto-Speed-Regulation activated")
else print("Auto-Speed-Regulation activated")
end
 
function Main()
    CurStress = SOM.getStress()
    TotalStress  = SOM.getStressCapacity()
    CurSpeed = RSC.getTargetSpeed()
    if(CurStress ~= TotalStress) then
        DeltaStressMult = CurStress/TotalStress
        PN = CurSpeed/math.abs(CurSpeed)
        Abs_TargetSpeed = math.abs(CurSpeed/DeltaStressMult)
        if Abs_TargetSpeed > 256 then Abs_TargetSpeed = 256
        -- elseif Abs_TargetSpeed < 32 then Abs_TargetSpeed = 32        
        end
        RSC.setTargetSpeed(Abs_TargetSpeed * PN)
    end
end
 
repeat
    Main()
    sleep(0.5)
until false
