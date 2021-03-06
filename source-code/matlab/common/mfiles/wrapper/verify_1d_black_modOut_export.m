function [exportFileList]=verify_1d_black_modOut_export(matFileName,exportDirectory,quarterNumber)
% function [exportFileList]=verify_1d_black_modOut_export(matFileName,exportDirectory,quarterNumber)
% A function to validate the the files exported by the 1-D black exporter
% are the files expected. This functin check both the count and the name of
% the file to validate the exports.
%
% Input arguments:
%   matFileName (string):   The full path to a file containing a struct
%                           array with a mapping of module/output to black
%                           algorithm applied to the module/output. The
%                           struct is generated by count_by_quarter.m, and
%                           contains the following fields: 
%                             mapByQuarterStruct.quarterString:
%                               quarter (integer)
%                               modules (1xN duoble)
%                               outputs (1xN duoble)
%                               blackAlgorithmAppliedArray (Nx10 char)
%                               blackAlgorithmAppliedKeyArray (1xN duoble)
%                               exp1DBlackIndices (1xI duoble)
%                               dynablackIndices (1xJ duoble)
%                               count1DBlack (integer)
%                               countDynaBlack (integer)
%
%   exportDirectory (string):   The full path to the directory containing
%                               the exported 1-D black *.mat files.
%   quarterNumber (integer):    The integer number for the quarter being
%                               checked.
%
% Output arguments:
%   exportFileList (struct):    A struct array of the files exported,
%                               generated by the dir function. The 
%                               exportFileList(i).name field is the list of
%                               file names in the export directory.
%
% Author: Jennifer Campbell, October, 2015							     
% KSOP-2440, KSOC-4924
%% --------------------------------------------------------------------- %%
% Gather the necessary info before running checks.
% Make a string of the quarter number so it can be used in the struct
% 
% Copyright 2017 United States Government as represented by the
% Administrator of the National Aeronautics and Space Administration.
% All Rights Reserved.
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
quarterString=['q', num2str(quarterNumber)];

% Load the mapByQuarterStruct structure
% This struct is organized by quarter, so mapByQuarterStruct(1) has the Q0
% data, and so on.
load(matFileName)

% Get the list of the 1-D Black files exported (as found in the export 
% directory), and the number of files exported.
exportFileList=dir([exportDirectory, '*.mat']);
numberFilesInDir=length(exportFileList);

% Get the number of files expected. The indices of the expected mod/out 
% pairs for 1-D black come from:
%   mapByQuarterStruct.(quarterString).exp1DBlackIndices
% The number of mod/out pairs is the number of expected files.
exp1DBlackIndices=mapByQuarterStruct.(quarterString).exp1DBlackIndices;
expectedModOutFileCount=length(exp1DBlackIndices);

%% --------------------------------------------------------------------- %%
% Check that the number of files in the export directory matches the 
% number expected:
if numberFilesInDir == expectedModOutFileCount
    fprintf('Expect %i files\n',expectedModOutFileCount)
    fprintf('Have %i files\n',numberFilesInDir)
else
    fprintf('\n\t WARNING: DO NOT HAVE THE NUMBER OF FILES EXPECTED:\n')
    fprintf('\t\tExpect %i files\n',expectedModOutFileCount)
    fprintf('\t\tHave %i files\n',numberFilesInDir)
end

%% --------------------------------------------------------------------- %%
% From the mapByQuarterStruct file, check to see if we exported each
% mod/out we expected.
for i=1:expectedModOutFileCount
    mod=mapByQuarterStruct.(quarterString).modules(exp1DBlackIndices(i));
    out=mapByQuarterStruct.(quarterString).outputs(exp1DBlackIndices(i));
    modString=num2str(mod);
    outString=num2str(out);

    fprintf('Checking for mod %i, out %i ... ',mod,out);
    fileCheckString=[exportDirectory,'kplr*q*',num2str(quarterNumber),'-*',modString,outString,'*-dr25_1dblack.mat'];
    
    if ~isempty( dir(fileCheckString) )
        fprintf('file exists\n')
    else
        fprintf('file missing\n')
    end
    
end

%% --------------------------------------------------------------------- %%
return
