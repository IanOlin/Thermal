function res = liquidHeatLoss(~, params)%params + liquidEnergy, liquidMass, liquidVolume
        params = params.';
        liquidEnergy = params(18);
        liquidMass = params(19);
        liquidVolume = liquidMass / 1000; %m^3
        airSA = (.04^2 * pi) - (.02^2 * pi); %surface area in contact with air
%         mugSA = (.04^2 * pi) + (liquidVolume * 2 / .04);%contact area with mug
        mugSA = 10;%temp SA
        mugThickness = params(9);
        thermalConductivity = params(8);
        specificHeatLiquid = params(5);
        
        thermalHeatCoefficient = 10;%shitshitshitshitshitshitshitshitshitshitshitshit
        conduction = thermalConductivity * mugSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid) - 290) / mugThickness;
        convection = thermalHeatCoefficient * airSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid) - 290);
        newParams = zeros(1, length(params));
        newParams(18) = -(conduction + convection);
%         display(conduction);
%         display(convection);
        res = newParams.';
end

     function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
     end
    
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    