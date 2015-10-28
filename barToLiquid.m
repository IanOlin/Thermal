function res = barToLiquid (~, params)
    params = params.';
    barEnergy = params(21);
    liquidEnergy = params(18);
    thermalConductivitySteam = params(22);
    thicknessSteam = params(23);
    steamSA = params(11);
    specificHeatBar = params(7);
    specificHeatLiquid = params(5);
    liquidMass = params(19;
    massOfBar = params(14);
    deltaT = energyToTemperature(barEnergy, massOfBar, specificHeatBar) - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
    conduction = thermalConductivitySteam * steamSA * deltaT / thicknessSteam;
    newParams = zeros(1, length(params));
    newParams(21) = -conduction;
    newParams(18) = conduction;
    res = newParams.';
end

    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end