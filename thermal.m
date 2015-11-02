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
    steamTemp = 380;
    liquidDensity = 1000;
    liquidTemp = 290;
    liquidVolume = (pi * (diameterCider/2)^2) * heightCider - (volumeBar + volumeSteam);
    liquidMass = liquidVolume * liquidDensity;

    barEnergy = temperatureToEnergy(barTemp, massOfBar, specificHeatBar);
    steamEnergy = temperatureToEnergy(steamTemp, massOfSteam, specificHeatSteam);
    liquidEnergy = temperatureToEnergy(liquidTemp, liquidMass, specificHeatLiquid);
        %% time settings

    initialTime = 1;
    finalTime = 2500;
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

        %% depriciated variables
            thermalConductivitySteam = .00185;
            %steam heat transfer coefficient
%     steamHeatTransfer = stuff;
    %thermalConductivityBar = 46.6;% Thermal conductivity watts/meter kelvin
        
        %initial teamp values (K)
%             steamLiquidCoefficient = 2800;%W/(mK), is bullshit
        
                %shitload of variables for bar
    %type of iron is 5160 medium carbon steel (.55-.65% carbon)
    %http://www.matweb.com/search/datasheet.aspx?MatGUID=972ec49b746d47c2a31db406e9213247
    %http://www.wolframalpha.com/input/?i=5160+steel
    %TI = 2200
%         params(16) = massOfSteam; %using barToLiquid makes this depreciated
%         params(17) = steamEnergy;%using barToLiquid makes this depreciated
%         params(12) = steamLiquidCoefficient;%using barToLiquid makes this depreciated
%         params(6) = specificHeatSteam;%using barToLiquid makes this depreciated


        %% stocks

    stocks(1) = barEnergy;
    stocks(2) = steamEnergy;
    stocks(3) = liquidEnergy;

        

        %% main
        %used ode45

            
         %use for loop for liquid energy, includes mass changes
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
            [T, Y] = ode45(@netFlow, [initialTime, finalTime], params.');
            T = T.';
            Y = Y.';
            blah = zeros(1, length(T));
            for n = 1:length(T)
                blah(n) = Y(3, n);
            end
            plot(T, energyToTemperature(blah, massOfBar, specificHeatBar), 'b');
%             plot(T, blah, 'b');
            hold on;
            blah2 = zeros(1, length(T));
            for n = 1:length(T)
                blah2(n) = Y(10, n);
            end
            plot(T, energyToTemperature(blah2, liquidMass, specificHeatLiquid), 'b');
            
            
            
            
%             [T, Y] = ode45(@netFlow, [initialTime, 1000], params.'); %works perfectly
%             T = T.';
%             Y = Y.';
%             blah = zeros(1, length(T));
%             for n = 1:length(T)
%                 blah(n) = Y(10, n);
%             end
%             plot(T, blah, 'b');


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
            
%             [T, Y] = ode45(@liquidHeatLoss, [initialTime, 10], params.');
%             T = T.';
%             Y = Y.';
%             blah = zeros(1, length(T));
%             for n = 1:length(T)
%                 blah(n) = Y(18, n);
%             end
%             plot(T, blah, 'b');


    %%fuk u matlab, it works

%         liquidEnergies = zeros(1, 100);
%         for n = 1:100
%             tempParams = barToSteam(1, params);
%             liquidEnergies(n) = params(17) + tempParams(17)/100;
%             params(17) = liquidEnergies(n);
%         end
%         plot(energyToTemperature(liquidEnergies, liquidMass, 4186));
%         display(params(18));

%             [T, Y] = ode45(@phaseChange, [initialTime, 10], params.');
%             T = T.';
%             Y = Y.';
%             blah = zeros(1, length(T));
%             for n = 1:length(T)
%                 blah(n) = Y(21, n);
%             end
%             plot(T, energyToTemperature(blah, massOfBar, specificHeatBar), 'b');
%             hold on;
%             blah2 = zeros(1, length(T));
%             for n = 1:length(T)
%                 blah2(n) = Y(17, n);
%             end
%             plot(T, energyToTemperature(blah2, massOfSteam, specificHeatSteam), 'b');
        
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
    
    