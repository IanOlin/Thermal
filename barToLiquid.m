function res = barToLiquid (~, params)%models bar losing heat to liquid through leidenfrost effect with steam, includes film boiling
    params = params.';
    
    barEnergy = params(3);
    liquidEnergy = params(11);
    thermalConductivitySteam = params(14);
    thicknessSteam = params(15);
    steamSA = params(16);
    specificHeatBar = params(5);
    specificHeatLiquid = params(13);
    liquidMass = params(11);
    massOfBar = params(1);
    emissivity = params(4);
    
    deltaT = energyToTemperature(barEnergy, massOfBar, specificHeatBar) - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
    conduction = thermalConductivitySteam * steamSA * deltaT / thicknessSteam;
    deltaRT = energyToTemperature(barEnergy, massOfBar, specificHeatBar)^4 - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid)^4;
    radiation = emissivity * 5.67 * 10^(-8) * deltaRT * steamSA * .9;%not all radiation goes directly to water
    flowParams = zeros(1, length(params));
    flowParams(3) = -conduction - radiation;
    flowParams(11) = conduction + radiation;
    res = flowParams.';
    display(radiation);
    display(conduction); %fuk u matlab
end

    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    