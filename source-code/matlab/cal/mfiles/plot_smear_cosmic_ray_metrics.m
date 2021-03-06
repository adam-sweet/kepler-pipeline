function plot_smear_cosmic_ray_metrics(calIntermediateStruct, numMsmearCrEventsArray, numVsmearCrEventsArray)
% function plot_smear_cosmic_ray_metrics(calIntermediateStruct, numMsmearCrEventsArray, numVsmearCrEventsArray)
%
% function to plot cosmic ray metrics if any cosmic rays are detected in
% masked and/or virtual smear.
%
% cosmic ray hits data is in:
% calIntermediateStruct.cosmicRayEvents.maskedSmear or .virtualSmear
%
% 1xnHits struct array with fields:
%     delta
%     rowOrColumn
%     mjd
%
% cosmic ray metrics are in calIntermediateStruct.maskedSmearCosmicRayMetrics:
%                          exists: 1
%                        hitRates: [nCadencex1 double]
%            hitRateGapIndicators: [nCadencex1 logical]
%                      meanEnergy: [nCadencex1 double]
%         meanEnergyGapIndicators: [nCadencex1 logical]
%                  energyVariance: [nCadencex1 double]
%     energyVarianceGapIndicators: [nCadencex1 logical]
%                  energySkewness: [nCadencex1 double]
%     energySkewnessGapIndicators: [nCadencex1 logical]
%                  energyKurtosis: [nCadencex1 double]
%     energyKurtosisGapIndicators: [nCadencex1 logical]
%
%  Note: at least two points are needed to compute the energy variance,
%  three events are needed to compute the skewness metric, and at least
%  four events are needed for the kurtosis metric.  The hit rates, mean
%  energy, and energy variance are plotted only if more than one event is
%  detected, and the remaining metrics are plotted only if more than three
%  cosmic rays are detected for each the masked and virtual smear regions.
% 
% Copyright 2017 United States Government as represented by the
% Administrator of the National Aeronautics and Space Administration.
% All Rights Reserved.
% 
% NASA acknowledges the SETI Institute's primary role in authoring and
% producing the Kepler Data Processing Pipeline under Cooperative
% Agreement Nos. NNA04CC63A, NNX07AD96A, NNX07AD98A, NNX11AI13A,
% NNX11AI14A, NNX13AD01A & NNX13AD16A.
% 
% This file is available under the terms of the NASA Open Source Agreement
% (NOSA). You should have received a copy of this agreement with the
% Kepler source code; see the file NASA-OPEN-SOURCE-AGREEMENT.doc.
% 
% No Warranty: THE SUBJECT SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY
% WARRANTY OF ANY KIND, EITHER EXPRESSED, IMPLIED, OR STATUTORY,
% INCLUDING, BUT NOT LIMITED TO, ANY WARRANTY THAT THE SUBJECT SOFTWARE
% WILL CONFORM TO SPECIFICATIONS, ANY IMPLIED WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR FREEDOM FROM
% INFRINGEMENT, ANY WARRANTY THAT THE SUBJECT SOFTWARE WILL BE ERROR
% FREE, OR ANY WARRANTY THAT DOCUMENTATION, IF PROVIDED, WILL CONFORM
% TO THE SUBJECT SOFTWARE. THIS AGREEMENT DOES NOT, IN ANY MANNER,
% CONSTITUTE AN ENDORSEMENT BY GOVERNMENT AGENCY OR ANY PRIOR RECIPIENT
% OF ANY RESULTS, RESULTING DESIGNS, HARDWARE, SOFTWARE PRODUCTS OR ANY
% OTHER APPLICATIONS RESULTING FROM USE OF THE SUBJECT SOFTWARE.
% FURTHER, GOVERNMENT AGENCY DISCLAIMS ALL WARRANTIES AND LIABILITIES
% REGARDING THIRD-PARTY SOFTWARE, IF PRESENT IN THE ORIGINAL SOFTWARE,
% AND DISTRIBUTES IT "AS IS."
% 
% Waiver and Indemnity: RECIPIENT AGREES TO WAIVE ANY AND ALL CLAIMS
% AGAINST THE UNITED STATES GOVERNMENT, ITS CONTRACTORS AND
% SUBCONTRACTORS, AS WELL AS ANY PRIOR RECIPIENT. IF RECIPIENT'S USE OF
% THE SUBJECT SOFTWARE RESULTS IN ANY LIABILITIES, DEMANDS, DAMAGES,
% EXPENSES OR LOSSES ARISING FROM SUCH USE, INCLUDING ANY DAMAGES FROM
% PRODUCTS BASED ON, OR RESULTING FROM, RECIPIENT'S USE OF THE SUBJECT
% SOFTWARE, RECIPIENT SHALL INDEMNIFY AND HOLD HARMLESS THE UNITED
% STATES GOVERNMENT, ITS CONTRACTORS AND SUBCONTRACTORS, AS WELL AS ANY
% PRIOR RECIPIENT, TO THE EXTENT PERMITTED BY LAW. RECIPIENT'S SOLE
% REMEDY FOR ANY SUCH MATTER SHALL BE THE IMMEDIATE, UNILATERAL
% TERMINATION OF THIS AGREEMENT.
%


% hard coded constants
TITLE_FONTSIZE = 14;
AXIS_LABEL_FONTSIZE = 12;
AXIS_NUMBER_FONTSIZE = 12;

if (~isempty(calIntermediateStruct.cosmicRayEvents.maskedSmear))
    
    nMsmearEvents = length([calIntermediateStruct.cosmicRayEvents.maskedSmear.delta]);
    
    if (nMsmearEvents > 1)
        
%         numMsmearCrEventsArray = calIntermediateStruct.numMsmearCrEventsArray;
        
        hitRates = calIntermediateStruct.maskedSmearCosmicRayMetrics.hitRates;
        hitRateGapIndicators = calIntermediateStruct.maskedSmearCosmicRayMetrics.hitRateGapIndicators;
        validHitRates = hitRates(~hitRateGapIndicators);
        validHitRatesIdx = find(~hitRateGapIndicators);
        
        meanEnergy = calIntermediateStruct.maskedSmearCosmicRayMetrics.meanEnergy;
        meanEnergyGapIndicators = calIntermediateStruct.maskedSmearCosmicRayMetrics.meanEnergyGapIndicators;
        validMeanEnergy = meanEnergy(~meanEnergyGapIndicators);
        validMeanEnergyIdx = find(~meanEnergyGapIndicators);
        
        energyVariance = calIntermediateStruct.maskedSmearCosmicRayMetrics.energyVariance;
        energyVarianceGapIndicators = calIntermediateStruct.maskedSmearCosmicRayMetrics.energyVarianceGapIndicators;
        validEnergyVariance = energyVariance(~energyVarianceGapIndicators);
        validEnergyVarianceIdx = find(~energyVarianceGapIndicators);
        
        energySkewness = calIntermediateStruct.maskedSmearCosmicRayMetrics.energySkewness;
        energySkewnessGapIndicators = calIntermediateStruct.maskedSmearCosmicRayMetrics.energySkewnessGapIndicators;
        validEnergySkewness = energySkewness(~energySkewnessGapIndicators);
        validEnergySkewnessIdx = find(~energySkewnessGapIndicators);
        
        energyKurtosis = calIntermediateStruct.maskedSmearCosmicRayMetrics.energyKurtosis;
        energyKurtosisGapIndicators = calIntermediateStruct.maskedSmearCosmicRayMetrics.energyKurtosisGapIndicators;
        validEnergyKurtosis = energyKurtosis(~energyKurtosisGapIndicators);
        validEnergyKurtosisIdx = find(~energyKurtosisGapIndicators);
        
        
        %--------------------------------------------------------------------------
        % create figure
        %--------------------------------------------------------------------------
        close all;
        paperOrientationFlag = true;
        
        h = figure;
        
        subplot(3, 1, 1)
        plot(numMsmearCrEventsArray, 'rx-')
        title(['[CAL] Masked smear pixels: ', num2str(nMsmearEvents), ' cosmic ray hits detected'], 'fontsize', TITLE_FONTSIZE);
%         xlabel(' Cadence ', 'fontsize', AXIS_LABEL_FONTSIZE);
        ylabel('Number', 'fontsize', AXIS_LABEL_FONTSIZE);
        grid on;
        set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
        
        subplot(3, 1, 2)
        plot(validHitRatesIdx, validHitRates, 'gx-')
%         xlabel(' Cadence ', 'fontsize', AXIS_LABEL_FONTSIZE);
        ylabel('Hit Rate (CR/cm^2/sec)', 'fontsize', AXIS_LABEL_FONTSIZE);
        grid on;
        set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
        
        subplot(3, 1, 3)
        plot(validMeanEnergyIdx, validMeanEnergy, 'bx-')
        xlabel('Cadence', 'fontsize', AXIS_LABEL_FONTSIZE);
        ylabel('Mean Energy (e-)', 'fontsize', AXIS_LABEL_FONTSIZE);
        grid on;       
        set(h, 'PaperPositionMode', 'auto');
        set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
        
        plot_to_file('cal_msmear_cosmic_ray_metrics_I', paperOrientationFlag);
        close all;
    end
    
    if (nMsmearEvents > 3)
        if (~isempty(validEnergySkewness) && length(validEnergySkewnessIdx) > 2) ||  ...
                (~isempty(validEnergyKurtosis) && length(validEnergyKurtosisIdx) > 2)
            
            %--------------------------------------------------------------------------
            % create figure
            %--------------------------------------------------------------------------
            close all;
            paperOrientationFlag = true;
            
            h2 = figure;
            
            subplot(3, 1, 1)
            plot(validEnergyVarianceIdx, validEnergyVariance, 'bx-')
            title(['[CAL] Masked smear pixels: ', num2str(nMsmearEvents), ' cosmic ray hits detected'], 'fontsize', TITLE_FONTSIZE);
%             xlabel(' Cadence ', 'fontsize', AXIS_LABEL_FONTSIZE);
            ylabel('Energy Variance', 'fontsize', AXIS_LABEL_FONTSIZE);
            grid on;
            set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
            
            subplot(3, 1, 2)
            plot(validEnergySkewnessIdx, validEnergySkewness, 'gx-')
%             xlabel(' Cadence ', 'fontsize', AXIS_LABEL_FONTSIZE);
            ylabel('Skewness', 'fontsize', AXIS_LABEL_FONTSIZE);
            grid on;
            set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
            
            subplot(3, 1, 3)
            plot(validEnergyKurtosisIdx, validEnergyKurtosis, 'rx-')
            xlabel('Cadence', 'fontsize', AXIS_LABEL_FONTSIZE);
            ylabel('Kurtosis', 'fontsize', AXIS_LABEL_FONTSIZE);
            grid on;
            set(h2, 'PaperPositionMode', 'auto');
            set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
            
            plot_to_file('cal_msmear_cosmic_ray_metrics_II', paperOrientationFlag);
            close all;
        end
    end
    
else
    disp('No cosmic rays detected in masked smear pixel region')
end


%--------------------------------------------------------------------------
% cosmic ray metrics are in calIntermediateStruct.virtualSmearCosmicRayMetrics:
%--------------------------------------------------------------------------
if (~isempty(calIntermediateStruct.cosmicRayEvents.virtualSmear))
    
    nVsmearEvents = length([calIntermediateStruct.cosmicRayEvents.virtualSmear.delta]);
    
    if (nVsmearEvents > 1)
        
        numVsmearCrEventsArray = calIntermediateStruct.numVsmearCrEventsArray;
        
        hitRates = calIntermediateStruct.virtualSmearCosmicRayMetrics.hitRates;
        hitRateGapIndicators = calIntermediateStruct.virtualSmearCosmicRayMetrics.hitRateGapIndicators;
        validHitRates = hitRates(~hitRateGapIndicators);
        validHitRatesIdx = find(~hitRateGapIndicators);
        
        
        meanEnergy = calIntermediateStruct.virtualSmearCosmicRayMetrics.meanEnergy;
        meanEnergyGapIndicators = calIntermediateStruct.virtualSmearCosmicRayMetrics.meanEnergyGapIndicators;
        validMeanEnergy = meanEnergy(~meanEnergyGapIndicators);
        validMeanEnergyIdx = find(~meanEnergyGapIndicators);
        
        energyVariance = calIntermediateStruct.virtualSmearCosmicRayMetrics.energyVariance;
        energyVarianceGapIndicators = calIntermediateStruct.virtualSmearCosmicRayMetrics.energyVarianceGapIndicators;
        validEnergyVariance = energyVariance(~energyVarianceGapIndicators);
        validEnergyVarianceIdx = find(~energyVarianceGapIndicators);
        
        energySkewness = calIntermediateStruct.virtualSmearCosmicRayMetrics.energySkewness;
        energySkewnessGapIndicators = calIntermediateStruct.virtualSmearCosmicRayMetrics.energySkewnessGapIndicators;
        validEnergySkewness = energySkewness(~energySkewnessGapIndicators);
        validEnergySkewnessIdx = find(~energySkewnessGapIndicators);
        
        energyKurtosis = calIntermediateStruct.virtualSmearCosmicRayMetrics.energyKurtosis;
        energyKurtosisGapIndicators = calIntermediateStruct.virtualSmearCosmicRayMetrics.energyKurtosisGapIndicators;
        validEnergyKurtosis = energyKurtosis(~energyKurtosisGapIndicators);
        validEnergyKurtosisIdx = find(~energyKurtosisGapIndicators);
        
        
        %--------------------------------------------------------------------------
        % create figure
        %--------------------------------------------------------------------------
        close all;
        paperOrientationFlag = true;
        
        h3 = figure;
        
        subplot(3, 1, 1)
        plot(numVsmearCrEventsArray, 'rx-')
        title(['[CAL] Virtual smear pixels: ', num2str(nVsmearEvents), ' cosmic ray hits detected'], 'fontsize', TITLE_FONTSIZE);
%         xlabel(' Cadence ', 'fontsize', AXIS_LABEL_FONTSIZE);
        ylabel('Number', 'fontsize', AXIS_LABEL_FONTSIZE);
        grid on;
        set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
        
        subplot(3, 1, 2)
        plot(validHitRatesIdx, validHitRates, 'gx-')
%         xlabel(' Cadence ', 'fontsize', AXIS_LABEL_FONTSIZE);
        ylabel('Hit Rates (CR/cm^2/sec)', 'fontsize', AXIS_LABEL_FONTSIZE);
        grid on;
        set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
        
        subplot(3, 1, 3)
        plot(validMeanEnergyIdx, validMeanEnergy, 'bx-')
        xlabel('Cadence', 'fontsize', AXIS_LABEL_FONTSIZE);
        ylabel('Mean Energy (e-)', 'fontsize', AXIS_LABEL_FONTSIZE);
        grid on;        
        set(h3, 'PaperPositionMode', 'auto');
        set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
        
        plot_to_file('cal_vsmear_cosmic_ray_metrics_I', paperOrientationFlag);
        close all;
    end
    
    if (nVsmearEvents > 4)
        if (~isempty(validEnergySkewness) && length(validEnergySkewnessIdx) > 2) ||  ...
                (~isempty(validEnergyKurtosis) && length(validEnergyKurtosisIdx) > 2)
            
            %--------------------------------------------------------------------------
            % create figure
            %--------------------------------------------------------------------------
            close all;
            paperOrientationFlag = true;
            
            h4 = figure;
            
            subplot(3, 1, 1)
            plot(validEnergyVarianceIdx, validEnergyVariance, 'bx-')
            title(['[CAL] Virtual smear pixels: ', num2str(nVsmearEvents), ' cosmic ray hits detected'], 'fontsize', TITLE_FONTSIZE);
%             xlabel(' Cadence ', 'fontsize', AXIS_LABEL_FONTSIZE);
            ylabel(' Energy Variance ', 'fontsize', AXIS_LABEL_FONTSIZE);
            grid on;
            set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
            
            subplot(3, 1, 2)
            plot(validEnergySkewnessIdx, validEnergySkewness, 'gx-')
            grid on;
%             xlabel(' Cadence ', 'fontsize', AXIS_LABEL_FONTSIZE);
            ylabel(' Skewness ', 'fontsize', AXIS_LABEL_FONTSIZE);
            set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
            
            subplot(3, 1, 3)
            plot(validEnergyKurtosisIdx, validEnergyKurtosis, 'rx-')
            xlabel(' Cadence ', 'fontsize', AXIS_LABEL_FONTSIZE);
            ylabel(' Kurtosis ', 'fontsize', AXIS_LABEL_FONTSIZE);
            grid on;            
            set(h4, 'PaperPositionMode', 'auto');
            set(gca, 'fontsize', AXIS_NUMBER_FONTSIZE);
            
            plot_to_file('cal_vsmear_cosmic_ray_metrics_II', paperOrientationFlag);
            close all;
        end
    end
else
    disp('No cosmic rays detected in virtual smear pixel region')
end


return;
