function thermal()  
        %% iron bar
    specificHeatBar = 475 ; %specific heat in joules per kg kelvin
    densityBar = 7850; %density in kg per meter cubed

    
        %% size in contact with liquid
    lengthBar = 5/100 ;%length of bar in meters
    diameterBar = 4/100 ;%length of side of bar in meters
    volumeBar = pi*(diameterBar/2)^2*lengthBar; %volume
    surfaceAreaBar = pi * diameterBar * lengthBar + pi * (diameterBar/2)^2;
    massOfBar = densityBar * volumeBar;
    
        %% size of mug
    diameterCider = 8/100; %meters
    heatOfVaporization = 2256*10^3; %J/kG
    heightCider = 10/100; 
    thicknessMug = 0.7/100;
    

    
    %% steam surface area
    thicknessSteam = 1/100;
    steamSA = (lengthBar + thicknessSteam) * (pi * (diameterBar + 2 * thicknessSteam)) + 2 * pi * (diameterBar/2 + thicknessSteam)^2;

    thermalConductivityMug =1.5; %W/(m*K)

    specificHeatSteam = 1865;%%specific heat in joules per kg kelvin
    specificHeatLiquid = 4186;%specific heat in joules per kg kelvin
    densityOfSteam = 0.590; %kg/m^3
    volumeSteam = steamSA * thicknessSteam;
    massOfSteam = volumeSteam * densityOfSteam;
    barSteamTransferCoefficient = 50; %this is shit

    barTemp = 1500;
    liquidDensity = 1000;
    liquidTemp = 290;
    liquidVolume = (pi * (diameterCider/2)^2) * heightCider - (volumeBar + volumeSteam);
    liquidMass = liquidVolume * liquidDensity;

    barEnergy = temperatureToEnergy(barTemp, massOfBar, specificHeatBar);
    liquidEnergy = temperatureToEnergy(liquidTemp, liquidMass, specificHeatLiquid);
        %% time settings

    initialTime = 0;
    finalTime = 5000;
    emissivityCoefficient = .25; %lol magic space rays
    thermalConductivitySteam = .00185;
        
        %% params
    params(1) = massOfBar;
    params(2) = surfaceAreaBar;
    params(3) = barEnergy;
    params(4) = emissivityCoefficient;
    params(5) = specificHeatBar;
    params(6) = barSteamTransferCoefficient;

    params(7) = thermalConductivityMug;
    params(8) = thicknessMug;
    params(9) = heatOfVaporization;
    params(10) = liquidEnergy;
    params(11) = liquidMass;
    params(12) = 0;% was liquidVolume
    params(13) = specificHeatLiquid;

    params(14) = thermalConductivitySteam;
    params(15) = thicknessSteam;
    params(16) = steamSA;

        

        %% main
<<<<<<< HEAD
            tspan = 0:1:finalTime;
            [T, Y] = ode23(@netFlow, tspan, params.');
            T = T.';
            Y = Y.';
=======
        %used ode45

            
         %use for loop
%             T = zeros(1, 1000);
%             Y = zeros(1, 1000);
%             for n = 1:1000
%                 temp = barToLiquid(6969, params.');
%                 params = params + temp.';
%                 T(n) = n;
%                 Y(n) = energyToTemperature(params(10), params(11), params(13));
%                 deltaEnergy = params(10) - temperatureToEnergy(373, params(11), params(13)); %energy differency between liquid and boiling point, for phase change
%                 temp2 = [0 0];
%                 if(deltaEnergy > 0)
%                     temp2 = phaseChange(deltaEnergy, params);
% %                     display(temp2);
%                 end
%                 params(10) = params(10) - temp2(1);
%                 params(11) = params(11) - temp2(2);
%             end
%             plot(T,Y);
        %% commented out code
            [T, Y] = ode45(@barToLiquid, [initialTime, 10000], params.');
            T = T.';
            Y = Y.';

>>>>>>> shit
            blah = zeros(1, length(T));
            for n = 1:length(T)
                blah(n) = Y(3, n);
            end
<<<<<<< HEAD
            plot(T, energyToTemperature(blah, massOfBar, specificHeatBar), 'b-');
=======
            plot(T, energyToTemperature(blah, massOfBar, specificHeatBar), 'r+-');
%             plot(T, blah, 'b');
>>>>>>> shit
            hold on;
            blah2 = zeros(1, length(T));
            for n = 1:length(T)
                blah2(n) = Y(10, n);
            end
<<<<<<< HEAD
            plot(T, energyToTemperature(blah2, liquidMass, specificHeatLiquid), 'b-');
            figure
            blah3 = zeros(1, length(T));
            for n = 1:length(T)
                blah3(n) = Y(11, n);
            end
            plot(T,blah3);
            
=======
            plot(T, energyToTemperature(blah2, liquidMass, specificHeatLiquid), 'b+-');
            
            
            
            
% %             [T, Y] = ode45(@steamToLiquid, [initialTime, 10], params.'); %works perfectly
% %             T = T.';
% %             Y = Y.';
% %             blah = zeros(1, length(T));
% %             for n = 1:length(T)
% %                 blah(n) = Y(18, n);
% %             end
% %             plot(T, blah, 'b');


%             [T, Y] = ode45(@barToSteam, [initialTime, 10], params.');
%             T = T.';
%             Y = Y.';
%             blah = zeros(1, length(T));
%             for n = 1:length(T)
%                 blah(n) = Y(21, n);
%             end
%             plot(T, energyToTemperature(blah, massOfBar, specificHeatBar), 'b');
% %             plot(T, blah, 'b');
%             hold on;
%             blah2 = zeros(1, length(T));
%             for n = 1:length(T)
%                 blah2(n) = Y(17, n);
%             end
%             plot(T, energyToTemperature(blah2, massOfSteam, specificHeatSteam), 'b');
%             
%             hold on;
>>>>>>> shit
            
        
end

%% helpers
    function res = energyToTemperature(U, m, c)
        res = U / heatCapacity(m,c);
    end

    function res = temperatureToEnergy( T, m, c)
        res = T * heatCapacity(m,c);
    end

    function res = heatCapacity(mass, specificHeat)
        res = mass * specificHeat;
    end
    
    