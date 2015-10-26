function shit = steamToLiquid(steamEnergy, liquidEnergy, steamMass, liquidMass)
        lengthBar = .05 ;%length of bar in meters
        diameterBar = .04 ;%length of side of bar in meters
%         volumeBar = pi*(diameterBar/2)^2*lengthBar; %volume
        specificHeatSteam = 1865;%%specific heat in joules per kg kelvin
        specificHeatLiquid = 4186;%specific heat in joules per kg kelvin
        steamLiquidCoefficient = 2800;%W/(mK), is bullshit
        steamSA = (lengthBar + 2 * steamThickness) * (pi * (diameterBar + 2 * steamThickness)) + 2 * pi * (diameterBar/2 + steamThickness)^2;
        deltaTemp = energyToTemperature(steamEnergy, steamMass, specificHeatSteam) - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
        flow = steamLiquidCoefficient * steamSA * deltaTemp; 
        shit = flow;
end
    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    