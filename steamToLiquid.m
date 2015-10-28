function res = steamToLiquid(steamEnergy, liquidEnergy, steamMass, liquidMass, params)
    lengthBar = params(1) ;%length of bar in meters
    diameterBar = params(2) ;%length of side of bar in meters
    volumeBar = params(3); %volume
    specificHeatLiquid = params(5);
    specificHeatSteam = params(6);
    steamSA = (lengthBar + 2 * steamThickness) * (pi * (diameterBar + 2 * steamThickness)) + 2 * pi * (diameterBar/2 + steamThickness)^2;
    deltaTemp = energyToTemperature(steamEnergy, steamMass, specificHeatSteam) - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
    flow = steamLiquidCoefficient * steamSA * deltaTemp; 
    res = flow;
end
    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    