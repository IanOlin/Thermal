function res = steamToLiquid(steamEnergy, liquidEnergy, steamMass, liquidMass, params)
    specificHeatLiquid = params(5);
    specificHeatSteam = params(6);
    steamSA = params(11);
    steamLiquidCoefficient = params(12);
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
    