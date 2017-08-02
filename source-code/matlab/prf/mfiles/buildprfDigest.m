function [RptgenML_CReport1] = buildprfDigest
%BUILDPRFDIGEST
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
 
%  Auto-generated by MATLAB on 15-Oct-2008 13:06:35
 
% Create RptgenML.CReport
RptgenML_CReport1 = RptgenML.CReport('RptFileName',...
'C:\path\to\matlab\prf\mfiles\prfDigest.rpt',...
'Stylesheet','default-fo',...
'FilenameName','prfDigest',...
'DirectoryType','pwd');
% setedit(RptgenML_CReport1);
 
% Create rptgen.cfr_paragraph
rptgen_cfr_paragraph1 = rptgen.cfr_paragraph;
setParent(rptgen_cfr_paragraph1,RptgenML_CReport1);
 
% Create rptgen.cml_eval
rptgen_cml_eval1 = rptgen.cml_eval('isInsertString',false,'isDiary',false,...
'EvalString',['tab{1,1} = ''Generated:'' ; ',sprintf('\n'),'tab{1,2} = datestr(now,31) ;',sprintf('\n'),'tab{2,1} = ''Module:'' ;',sprintf('\n'),'tab{2,2} = ''prf'' ;',sprintf('\n'),'tab{3,1} = ''CCD Module:'' ;',sprintf('\n'),'tab{3,2} = prfInputStruct.ccdModule ;',sprintf('\n'),'tab{4,1} = ''CCD Output:'' ;',sprintf('\n'),'tab{4,2} = prfInputStruct.ccdOutput ;']);
setParent(rptgen_cml_eval1,rptgen_cfr_paragraph1);
 
% Create rptgen.cfr_table
rptgen_cfr_table1 = rptgen.cfr_table('numHeaderRows',0,'isBorder',false,'Source','tab');
setParent(rptgen_cfr_table1,rptgen_cfr_paragraph1);
 
% Create rptgen.cml_eval
rptgen_cml_eval2 = rptgen.cml_eval('isInsertString',false,'isDiary',false,...
'EvalString',['prfRegionPlotHandle = plot_prf_fit_regions( prfStructureVector ) ;',sprintf('\n'),'starTargets = find(any(selectedTargetMatrix'')) ;',sprintf('\n'),'targets = targetStarsStruct(starTargets) ;',sprintf('\n'),'row = [targets.row] ;',sprintf('\n'),'column = [targets.column] ;',sprintf('\n'),'rowMatrix = reshape(row,length(prfInputStruct.cadenceTimes.startTimestamps), ...',sprintf('\n'),'length(targets)) ;',sprintf('\n'),'rowMatrix = rowMatrix'' ;',sprintf('\n'),'columnMatrix = reshape(column,length(prfInputStruct.cadenceTimes.startTimestamps), ...',sprintf('\n'),'length(targets)) ;',sprintf('\n'),'columnMatrix = columnMatrix'' ;',sprintf('\n'),'rowVector = rowMatrix(:,prfInputStruct.prfConfigurationStruct.baseAttitudeIndex) ;',sprintf('\n'),'columnVector = columnMatrix(:,prfInputStruct.prfConfigurationStruct.baseAttitudeIndex) ;',sprintf('\n'),'',sprintf('\n'),'plot(columnVector,rowVector,''k.'') ;']);
setParent(rptgen_cml_eval2,RptgenML_CReport1);
 
% Create rptgen_hg.chg_fig_snap
rptgen_hg_chg_fig_snap1 = rptgen_hg.chg_fig_snap('ImageFormat','jpeg90');
setParent(rptgen_hg_chg_fig_snap1,RptgenML_CReport1);
 
% Create rptgen.cml_eval
rptgen_cml_eval3 = rptgen.cml_eval('isInsertString',false,'isDiary',false,...
'EvalString','close all');
setParent(rptgen_cml_eval3,RptgenML_CReport1);
 
% Create rptgen.cml_eval
rptgen_cml_eval4 = rptgen.cml_eval('isInsertString',false,'isDiary',false,...
'EvalString',['[row,col,dRow,dCol,crowding,gapIndicators] = compute_centroiding_error( ...',sprintf('\n'),'    prfResultStruct.centroids, targetStarsStruct, ...',sprintf('\n'),'    prfInputStruct.prfConfigurationStruct.baseAttitudeIndex ) ;',sprintf('\n'),'goodData = find(~gapIndicators) ;',sprintf('\n'),'row = row(goodData) ;',sprintf('\n'),'col = col(goodData) ;',sprintf('\n'),'dRow = dRow(goodData) ;',sprintf('\n'),'dCol = dCol(goodData) ;',sprintf('\n'),'crowding = crowding(goodData) ;',sprintf('\n'),'goodCrowding = find(crowding >= prfInputStruct.prfConfigurationStruct.crowdingThreshold) ;',sprintf('\n'),'row = row(goodCrowding) ;',sprintf('\n'),'col = col(goodCrowding) ;',sprintf('\n'),'dRow = dRow(goodCrowding) ;',sprintf('\n'),'dCol = dCol(goodCrowding) ;',sprintf('\n'),'nBins = 51 ;',sprintf('\n'),'figure',sprintf('\n'),'subplot(2,1,1)',sprintf('\n'),'hist(dRow,nBins) ;',sprintf('\n'),'xlabel(''Row Residual [pixels]'') ;',sprintf('\n'),'title(''Row Residual on Base Attitude Cadence'')',sprintf('\n'),'subplot(2,1,2) ;',sprintf('\n'),'rmsRow = plot_residual_distribution(dRow,1,nBins) ;',sprintf('\n'),'title(''Row Residual on Base Attitude Cadence -- Central Distribution'') ;',sprintf('\n'),'xlabel(''Row Residual [pixels]'') ;']);
setParent(rptgen_cml_eval4,RptgenML_CReport1);
 
% Create rptgen_hg.chg_fig_snap
rptgen_hg_chg_fig_snap2 = rptgen_hg.chg_fig_snap('ImageFormat','jpeg90');
setParent(rptgen_hg_chg_fig_snap2,RptgenML_CReport1);
 
% Create rptgen.cml_eval
rptgen_cml_eval5 = rptgen.cml_eval('isInsertString',false,'isDiary',false,...
'EvalString',['close all',sprintf('\n'),'figure',sprintf('\n'),'subplot(2,1,1)',sprintf('\n'),'hist(dCol,nBins) ;',sprintf('\n'),'xlabel(''Column Residual [pixels]'') ;',sprintf('\n'),'title(''Column Residual on Base Attitude Cadence'')',sprintf('\n'),'subplot(2,1,2) ;',sprintf('\n'),'rmsRow = plot_residual_distribution(dCol,1,nBins) ;',sprintf('\n'),'title(''Column Residual on Base Attitude Cadence -- Central Distribution'') ;',sprintf('\n'),'xlabel(''Column Residual [pixels]'') ;']);
setParent(rptgen_cml_eval5,RptgenML_CReport1);
 
% Create rptgen_hg.chg_fig_snap
rptgen_hg_chg_fig_snap3 = rptgen_hg.chg_fig_snap('ImageFormat','jpeg90');
setParent(rptgen_hg_chg_fig_snap3,RptgenML_CReport1);
 
% Create rptgen.cml_eval
rptgen_cml_eval6 = rptgen.cml_eval('isInsertString',false,'isDiary',false,...
'EvalString',['close all',sprintf('\n'),'display_centroiding_error( row, col, dRow, dCol ) ;']);
setParent(rptgen_cml_eval6,RptgenML_CReport1);
 
% Create rptgen_hg.chg_fig_snap
rptgen_hg_chg_fig_snap4 = rptgen_hg.chg_fig_snap('ImageFormat','jpeg90');
setParent(rptgen_hg_chg_fig_snap4,RptgenML_CReport1);
 
% Create rptgen.cml_eval
rptgen_cml_eval7 = rptgen.cml_eval('isInsertString',false,'isDiary',false,...
'EvalString',['colorVector = ''bgrcm'' ;',sprintf('\n'),'figure',sprintf('\n'),'for count = 1:length(prfStructureVector)',sprintf('\n'),'  prfObject = prfClass(prfStructureVector(count).prfPolyStructure.polyCoeffStruct) ;',sprintf('\n'),'  [rowValue,rowPos] = cross_section(prfObject,1) ;',sprintf('\n'),'  [colValue,colPos] = cross_section(prfObject,2) ;',sprintf('\n'),'  rowString = [colorVector(count),''-''] ;',sprintf('\n'),'  colString = [colorVector(count),''--''] ;',sprintf('\n'),'  plot(rowPos,rowValue,rowString) ;',sprintf('\n'),'  hold on',sprintf('\n'),'  plot(colPos,colValue,colString) ;',sprintf('\n'),'end',sprintf('\n'),'xlabel(''Row/Column Position [pixels]'') ;',sprintf('\n'),'ylabel(''PRF Amplitude [A.U.]'') ;',sprintf('\n'),'title(''PRF Cross-Sections [bgrcm] -- Row (solid), Col (dashed)'') ;']);
setParent(rptgen_cml_eval7,RptgenML_CReport1);
 
% Create rptgen_hg.chg_fig_snap
rptgen_hg_chg_fig_snap5 = rptgen_hg.chg_fig_snap('ImageFormat','jpeg90');
setParent(rptgen_hg_chg_fig_snap5,RptgenML_CReport1);
 
% Create rptgen.cml_eval
rptgen_cml_eval8 = rptgen.cml_eval('isInsertString',false,'isDiary',false,...
'EvalString',['close all',sprintf('\n'),'if (length(prfStructureVector) == 5)',sprintf('\n'),'  nPlotRow = 3 ;',sprintf('\n'),'  nPlotCol = 2 ;',sprintf('\n'),'else',sprintf('\n'),'  nPlotRow = 1 ;',sprintf('\n'),'  nPlotCol = 1 ;',sprintf('\n'),'end',sprintf('\n'),'figure',sprintf('\n'),'for count = 1:length(prfStructureVector)',sprintf('\n'),'  subplot(nPlotCol,nPlotRow,count) ;',sprintf('\n'),'  prfObject = prfClass(prfStructureVector(count).prfPolyStructure.polyCoeffStruct) ;',sprintf('\n'),'  [prfArray, prfRow, prfColumn] = make_array(prfObject, 100, 1);',sprintf('\n'),'  contour(prfRow, prfColumn, prfArray, 20);',sprintf('\n'),'  axis([3.5 7.5 3.5 7.5]) ;',sprintf('\n'),'  title([''PRF '',num2str(count)]) ;',sprintf('\n'),'end']);
setParent(rptgen_cml_eval8,RptgenML_CReport1);
 
% Create rptgen_hg.chg_fig_snap
rptgen_hg_chg_fig_snap6 = rptgen_hg.chg_fig_snap('ImageFormat','jpeg90');
setParent(rptgen_hg_chg_fig_snap6,RptgenML_CReport1);
 
% Create rptgen.cml_eval
rptgen_cml_eval9 = rptgen.cml_eval('isInsertString',false,'isDiary',false,...
'EvalString','close all');
setParent(rptgen_cml_eval9,RptgenML_CReport1);
 