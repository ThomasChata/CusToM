function [] = CalibrateModelGeneration(ModelParameters,AnalysisParameters)
% Generation of the calibrated musculoskeletal model
%   A subject-specific model is generated. Additionnal computations used
%   for the analysis are also made.
%
%	Associated publication:
%	- Muller, A., Haering, D., Pontonnier, C., & Dumont, G., 2017. 
%	Non-invasive techniques for musculoskeletal model calibration. In 23�me Congr�s Fran�ais de M�canique.
%
%   INPUT
%   - ModelParameters: parameters of the musculoskeletal model,
%   automatically generated by the graphic interface 'GenerateParameters';
%   - AnalysisParameters: parameters of the musculoskeletal analysis,
%   automatically generated by the graphic interface 'Analysis'.
%   OUTPUT
%   The musculoskeletal model is automatically saved in the variable
%   'BiomechanicalModel'.
%________________________________________________________
%
% Licence
% Toolbox distributed under 3-Clause BSD License
%________________________________________________________

%% Anthropometric model generation
disp('Anthropometric Model Generation ...')
[BiomechanicalModel.OsteoArticularModel, BiomechanicalModel.Markers, BiomechanicalModel.Muscles] = ModelGeneration(ModelParameters);
disp('... Anthropometric Model Generation done')

%% Geometrical calibration
if AnalysisParameters.CalibIK.Active
    disp('Geometrical Calibration ...')
    [BiomechanicalModel.OsteoArticularModel, BiomechanicalModel.GeometricalCalibration, BiomechanicalModel.Markers] = GeometricalCalibration(BiomechanicalModel.OsteoArticularModel, BiomechanicalModel.Markers, AnalysisParameters);
    disp('... Geometrical Calibration done')
end

%% Symbolic functions
disp('Preliminary Computations ...')
[BiomechanicalModel.OsteoArticularModel] = Add6dof(BiomechanicalModel.OsteoArticularModel);
[BiomechanicalModel.OsteoArticularModel, BiomechanicalModel.Jacob] = SymbolicFunctionGenerationIK(BiomechanicalModel.OsteoArticularModel,BiomechanicalModel.Markers);
disp('... Preliminary Computations done')

%% Inertial calibration
if AnalysisParameters.CalibID.Active
    disp('Dynamic Calibration ...')
    [BiomechanicalModel] = DynamicCalibration(ModelParameters,AnalysisParameters, BiomechanicalModel);
    disp('... Dynamic Calibration done')
end

%% Muscular calibration
% To do

%% Moment arms matrix et muscular coupling

if numel(BiomechanicalModel.Muscles)
    disp('Moment Arms Computation ...')
    [BiomechanicalModel.MomentArms,BiomechanicalModel.MuscularCoupling] = MomentArmsComputation(BiomechanicalModel.OsteoArticularModel,BiomechanicalModel.Muscles);
    disp('... Moment Arms Computation done');
end

%% G�n�ration de la base de donn�es pour le calcul des efforts musculaires avec la m�thode MusIC
%% Generation of the data base for computation of muscular forces by using MusIc method

if numel(BiomechanicalModel.Muscles)
    disp('MusIC Database Generation ...')
    [BiomechanicalModel.MusICDatabase] = MusICDatabaseGeneration(BiomechanicalModel.OsteoArticularModel, BiomechanicalModel.Muscles, BiomechanicalModel.MuscularCoupling, BiomechanicalModel.MomentArms, AnalysisParameters); %#ok<STRNU> % pr�ciser la m�thode d'optimisation
    disp('... MusIC Database Generation done')
end

save('BiomechanicalModel','BiomechanicalModel');

end