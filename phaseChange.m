function res = phaseChange(netHeat, params)%Out of date, did not up date, please use real variables. no
        %q=m*heatofvaporization
        specificHeatLiquid = params(13);
        liquidMass = params(11);
        latentHeat = params(9);
        energyTransfer = netHeat;
%         energyTransfer = specificHeatLiquid * liquidMass * energyToTemperature(netHeat, netHeat/(specificHeatLiquid * 373), specificHeatLiquid);%transfer from water to steam, dQ = c*m*dt where c is specific heat, because water is at boiling point mass is energy/(c*373K)
        massTransfer = netHeat/latentHeat;
        res = [energyTransfer, massTransfer];
        display(massTransfer);
        
end
    
function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end

    function res = temperatureToEnergy( T, m, c)
        res = T * heatCapacity(m,c);
    end

    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end