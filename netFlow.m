function res = netFlow(~, params) %doesn't account for mass loss because we are bad and everything sucks.
    params = params.';
    airSA = (.04^2 * pi) - (.02^2 * pi); %surface area in contact with air
    mugSA = airSA*1.2;%temp SA

    massOfBar = params(1);
    
    barEnergy = params(3);
    emissivity = params(4);
    specificHeatBar = params(5);
    thermalConductivity = params(7);
    mugThickness = params(8);
    
    liquidEnergy = params(10);
    liquidMass = params(11);
    specificHeatLiquid = params(13);
    thermalConductivitySteam = params(14);
    thicknessSteam = params(15);
    steamSA = params(16);
    
    barTemp = energyToTemperature(barEnergy, massOfBar, specificHeatBar);
    liquidTemp = energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
    
    
    
    thermalHeatCoefficient = 10;%shitshitshitshitshitshitshitshitshitshitshitshit
    conductionLHL = thermalConductivity * mugSA * ( liquidTemp - 290) / mugThickness;
    convectionLHL = thermalHeatCoefficient * airSA * (liquidTemp - 290);
    flowParams = zeros(1, length(params));
    flowParamsLHL = -(conductionLHL + convectionLHL);

    deltaT = energyToTemperature(barEnergy, massOfBar, specificHeatBar) - energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid);
    conductionBTL = thermalConductivitySteam * steamSA * deltaT / thicknessSteam;

    deltaRT = barTemp^4 - liquidTemp^4;
    radiation = emissivity * 5.67 * 10^(-8) * deltaRT * steamSA * .9;%not all radiation goes directly to water

    
    deltaEnergy = liquidEnergy - temperatureToEnergy(373, liquidMass, specificHeatLiquid);
    massChange = [0, 0];
    if deltaEnergy > 0
        massChange = -phaseChange(deltaEnergy, params);
    end
    

    
    flowParams(3) = (-conductionBTL - radiation);
    flowParams(10) = (conductionBTL + radiation + flowParamsLHL + massChange(1));
    flowParams(11) = massChange(2);
    res = flowParams.';
%     display(conductionBTL);
%     display(radiation);
%     display(massChange(1));
    display(liquidTemp);
    display(conductionLHL);
%     display(convectionLHL);
end

    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
     end

    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    
    function res = temperatureToEnergy( T, m, c)
        res = T * heatCapacity(m,c);
    end