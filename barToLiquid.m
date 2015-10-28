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
    emissivity = params(24);
    deltaT = energyToTemperature(barEnergy, massOfBar, specificHeatBar) - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
    conduction = thermalConductivitySteam * steamSA * deltaT / thicknessSteam;
    deltaRT = energyToTemperature(barEnergy, massOfBar, specificHeatBar)^4 - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid)^4;
    radiation = emissivity * 5.67 * 10^(-8) * deltaRT * steamSA;
    newParams = zeros(1, length(params));
    newParams(21) = -conduction - radiation;
    newParams(18) = conduction + radiation;
    res = newParams.';
end

    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end