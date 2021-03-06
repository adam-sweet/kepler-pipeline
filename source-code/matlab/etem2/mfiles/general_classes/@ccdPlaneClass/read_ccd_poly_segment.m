function ccdPolySegment = read_ccd_poly_segment(ccdPlaneObject, filename, columns, prfNum)
%function ccdSegment = read_ccd_poly_segment(ccdPlaneObject, columns)
%
% reads in a vertical segment of a ccd polynomial that when evaluated is
% of size [numCcdRows, numCcdCols]. columns specifies the columns of the ccd to be
% represented (these are stored in rows of the file).
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

runParamsObject = ccdPlaneObject.runParamsClass;
numCcdRows = get(runParamsObject, 'numCcdRows');
numCcdCols = get(runParamsObject, 'numCcdCols');
nCoefs = get(runParamsObject, 'nCoefs');
endian = get(runParamsObject, 'endian');

ccdPolySegment = zeros(numCcdRows, length(columns), nCoefs);

minColumn = min(columns);
maxColumn = max(columns);

numColumns = maxColumn-minColumn+1;% total number of columns to read in at a time

relativeColumns = columns-minColumn+1;% columns indexed from 1

skip1 = (minColumn-1)*numCcdRows*4;
skip2 = (numCcdCols-maxColumn)*numCcdRows*4;

fid = fopen(filename, 'r', endian);
fseek(fid, (prfNum-1)*numCcdRows*numCcdCols*nCoefs*4, 'cof');

for i = 1:nCoefs
    
    fseek(fid, skip1, 'cof');

    coeffSegment = fread(fid, [numCcdRows,numColumns], 'float32');
    
    ccdPolySegment(:,:,i) = coeffSegment(:,relativeColumns);
    
    fseek(fid, skip2, 'cof');
end

fclose(fid);


