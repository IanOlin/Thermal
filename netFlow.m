function res = netFlow(~, params) %doesn't account for mass loss because we are bad and everything sucks.
    params = params.';
    airSA = (.04^2 * pi) - (.02^2 * pi); %surface area in contact with air
    mugSA = 10;%temp SA

    mugThickness = params(8);
    thermalConductivity = params(7);
    barEnergy = params(3);
    liquidEnergy = params(10);
    thermalConductivitySteam = params(14);
    thicknessSteam = params(15);
    steamSA = params(16);
    specificHeatBar = params(5);
    specificHeatLiquid = params(13);
    liquidMass = params(11);
    massOfBar = params(1);
    emissivity = params(4);

    thermalHeatCoefficient = 10;%shitshitshitshitshitshitshitshitshitshitshitshit
    conductionLHL = thermalConductivity * mugSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid) - 290) / mugThickness;
    convectionLHL = thermalHeatCoefficient * airSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid) - 290);
    flowParams = zeros(1, length(params));
    flowParamsLHL = -(conductionLHL + convectionLHL);



    deltaT = energyToTemperature(barEnergy, massOfBar, specificHeatBar) - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
    conductionBTL = thermalConductivitySteam * steamSA * deltaT / thicknessSteam;
    deltaRT = energyToTemperature(barEnergy, massOfBar, specificHeatBar)^4 - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid)^4;
    radiation = emissivity * 5.67 * 10^(-8) * deltaRT * steamSA * .9;%not all radiation goes directly to water
    
    flowParams(3) = -conductionBTL - radiation;
    flowParams(10) = conductionBTL + radiation + flowParamsLHL;
    res = flowParams.';
end

    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
     end

    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    