function res = phaseChange(netHeat, params)%Doesn't work with ODE but almost could
        %q=m*heatofvaporization
        specificHeatLiquid = params(13);
        liquidMass = params(11);
        heatOfVaropization = params(9);
        energyTransfer = netHeat;
%         energyTransfer = specificHeatLiquid * liquidMass * energyToTemperature(netHeat, netHeat/(specificHeatLiquid * 373), specificHeatLiquid);%transfer from water to steam, dQ = c*m*dt where c is specific heat, because water is at boiling point mass is energy/(c*373K)
        massTransfer = netHeat/heatOfVaropization;
        flowParams = zeros(1, length(params));
        flowParams(11) = massTransfer;
        res = flowParams.';
                
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