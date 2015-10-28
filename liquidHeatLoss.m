function res = liquidHeatLoss(~, params)%params + liquidEnergy, liquidMass, liquidVolume
        params = params.';
        liquidEnergy = params(10);
        liquidMass = params(11);
        %this should use passed in variables
        airSA = (.04^2 * pi) - (.02^2 * pi); %surface area in contact with air
%         mugSA = (.04^2 * pi) + (liquidVolume * 2 / .04);%contact area with mug
    %this should be passed in
        mugSA = 10;%temp SA
        
        mugThickness = params(8);
        thermalConductivity = params(7);
        specificHeatLiquid = params(13);
        
        thermalHeatCoefficient = 10;%shitshitshitshitshitshitshitshitshitshitshitshit
        conduction = thermalConductivity * mugSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid) - 290) / mugThickness;
        convection = thermalHeatCoefficient * airSA * (energyToTemperature(liquidEnergy, liquidMass, specificHeatLiquid) - 290);
        flowParams = zeros(1, length(params));
        flowParams(10) = -(conduction + convection);
%         display(conduction);
%         display(convection);
        res = flowParams.';
end

     function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
     end
    
    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    