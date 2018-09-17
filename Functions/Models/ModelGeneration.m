function [OsteoArticularModel, Markers, Muscles, EnableModel] = ModelGeneration(ModelParameters)
% Generation of the anthropometric model
%   The anthropometric musculoskeletal model is generated. A
%   pre-calibration is done from the size of the subject. 
%	
%	Based on:
%   - Kajita, S., Sakka, S., Hirukawa, H., Harada, K., & Yokoi, K., 2009.
%	Introduction � la commande des robots humano�des: De la mod�lisation � la g�n�ration du mouvement. Springer Science & Business Media.
%
%   INPUT
%   - ModelParameters: parameters of the musculoskeletal model, automatically
%   generated by the graphic interface 'GenerateParameters'
%   OUTPUT
%   - OsteoArticularModel: osteo-articular model (see the Documentation for
%   the structure);
%   - Markers: markers set (see the Documentation for the structure);
%   - Muscles: muscles set (see the Documentation for the structure);
%   - EnableModel: for each body part, this variable evaluates the
%   possibility to add the associated model (used for the graphic
%   interface 'GenerateParameters').
%________________________________________________________
%
% Licence
% Toolbox distributed under 3-Clause BSD License
%________________________________________________________

% Initialisation
OsteoArticularModel=[];

% Scaling coefficient from subject size and model size
k=ModelParameters.Size/1.80;

% distribution of global subject mass in the different segments of the body
[Mass.Trunk_Mass, Mass.Arm_Mass, Mass.Leg_Mass]= WholeBodySegMass(ModelParameters.Mass);
[Mass.Pelvis_Mass, Mass.LowerTrunk_Mass, Mass.UpperTrunk_Mass, Mass.Skull_Mass]= TrunkSegMass(Mass.Trunk_Mass);
[Mass.Thigh_Mass, Mass.Shank_Mass, Mass.Foot_Mass]= LegSegMass(Mass.Leg_Mass);
[Mass.UpperArm_Mass, Mass.Forearm_Mass, Mass.Hand_Mass]= ArmSegMass(Mass.Arm_Mass);

EnableModel = zeros(6,1);

%% Pelvis / LowerTrunk
[OsteoArticularModel] = ModelParameters.PelvisLowerTrunk(OsteoArticularModel,k,Mass,[]);
    
%% UpperTrunk
try
    [OsteoArticularModel] = ModelParameters.UpperTrunk(OsteoArticularModel,k,Mass,'LowerTrunk_UpperTrunkNode');
catch
    EnableModel(1) = 1;
end

%% Head
try
    [OsteoArticularModel]= ModelParameters.Head(OsteoArticularModel,k,Mass,'NeckNode');
catch
    EnableModel(2) = 1;
end

%% Right leg
try
    [OsteoArticularModel]= ModelParameters.RightLeg(OsteoArticularModel,k,'R',Mass,'Pelvis_HipJointRightNode');
catch
    EnableModel(3) = 1;
end

%% Left leg
try
    [OsteoArticularModel]= ModelParameters.LeftLeg(OsteoArticularModel,k,'L',Mass,'Pelvis_HipJointLeftNode');
catch
    EnableModel(4) = 1;
end

%% Right arm
try
    [OsteoArticularModel]= ModelParameters.RightArm(OsteoArticularModel,k,'R',Mass,'Thorax_ShoulderRightNode');
catch
    EnableModel(5) = 1;
end    

%% Left arm
try
    [OsteoArticularModel]= ModelParameters.LeftArm(OsteoArticularModel,k,'L',Mass,'Thorax_ShoulderLeftNode');
catch
    EnableModel(6) = 1;
end

%% Markers
[Markers] = ModelParameters.Markers(ModelParameters.MarkersOptions);

% We remove markers
[Markers] = Remove_markers(Markers,ModelParameters.MarkersRemoved);

% Checking if markers are on the model
[Markers] = VerifMarkersOnModel(OsteoArticularModel,Markers);

%% Muscles
if numel(ModelParameters.Muscles)
    % Initialisation
    Muscles = struct('name',[],'f0',[],'l0',[],'Kt',[],'ls',[],'alpha0',[],'path',[]);Muscles(1) = [];

    % add muscle sets
    for i = 1:numel(ModelParameters.Muscles)
        Muscles = ModelParameters.Muscles{i}(Muscles,ModelParameters.MusclesOptions{i});
    end

    % Checking if muscles are on the model
    Muscles = VerifMusclesOnModel(OsteoArticularModel,Muscles);
else
    Muscles = [];
end

end

function [Markers_set]=Remove_markers(Markers_set,Markers_set_missing_markers)
    [~,I,~]=intersect({Markers_set.name}',Markers_set_missing_markers);
    Markers_set(I)=[];
end


