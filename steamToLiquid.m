function res = steamToLiquid(~, lazyParams)
    params = lazyParams.';
    specificHeatLiquid = params(5);
    specificHeatSteam = params(6);
    steamSA = params(11);
    steamLiquidCoefficient = params(12);
    steamEnergy = params(17);
    liquidEnergy = params(18);
    steamMass = params(16);
    liquidMass = params(19);
    deltaTemp = energyToTemperature(steamEnergy, steamMass, specificHeatSteam) - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
    flow = steamLiquidCoefficient * steamSA * deltaTemp; 
    newParams = zeros(1, length(params));
    newParams(18) = flow;
    newParams(17) = -flow;
    res = newParams.';
end
    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    