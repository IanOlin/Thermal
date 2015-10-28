function res = liquidHeatLoss(~, params)%params + liquidEnergy, liquidMass, liquidVolume
        airSA = (.04^2 * pi) - (.02^2 * pi); %surface area in contact with air
        mugSA = (.04^2 * pi) + (liquidVolume * 2 / .04);%contact area with mug
        mugThickness = params(9);
        thermalConductivity = params(8);
        specificHeatLiquid = params(5);
        liquidEnergy = params(18);
        liquidMass = params(19);
        liquidMass = params(20);
        thermalHeatCoefficient = 10;%shitshitshitshitshitshitshitshitshitshitshitshit
        conduction = thermalConductivity * mugSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid) - 290) / mugThickness;
        convection = thermalHeatCoefficient * airSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid) - 290);
        newParams = zeros(1, legnth(params));
        newParams(18) = conduction + convection;
        res = newParams;
end

     function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
     end
    
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    