function [MuscleForcesComputationResults] = ForcesComputationOptiNum(filename, BiomechanicalModel, AnalysisParameters)
% Computation of the muscle forces estimation step by using an optimization method
%
%	Based on :
%	- Crowninshield, R. D., 1978. 
%	Use of optimization techniques to predict muscle forces. Journal of Biomechanical Engineering, 100(2), 88-92.
%
%   INPUT
%   - filename: name of the file to process (character string)
%   - BiomechanicalModel: musculoskeletal model
%   - AnalysisParameters: parameters of the musculoskeletal analysis,
%   automatically generated by the graphic interface 'Analysis' 
%   OUTPUT
%   - MuscleForcesComputationResults: results of the muscle forces
%   estimation step (see the Documentation for the structure) 
%________________________________________________________
%
% Licence
% Toolbox distributed under GPL 3.0 Licence
%________________________________________________________
%
% Authors : Antoine Muller, Charles Pontonnier, Pierre Puchaud and
% Georges Dumont
%________________________________________________________
disp(['Forces Computation (' filename ') ...'])

%% Loading variables

Muscles = BiomechanicalModel.Muscles;
load([filename '/InverseKinematicsResults']) %#ok<LOAD>
load([filename '/InverseDynamicsResults']) %#ok<LOAD>

if isfield(BiomechanicalModel,'Generalized_Coordinates')
q_map_unsix = BiomechanicalModel.Generalized_Coordinates.q_map_unsix;
q = q_map_unsix'*[InverseKinematicsResults.FreeJointCoordinates(end,:);...
    InverseKinematicsResults.JointCoordinates(2:end,:);
    InverseKinematicsResults.JointCoordinates(1,:);
    InverseKinematicsResults.FreeJointCoordinates(1:end-1,:)];

torques = q_map_unsix'*[InverseDynamicsResults.DynamicResiduals.t6dof(end,:);...
    InverseDynamicsResults.JointTorques(2:end,:);
    InverseDynamicsResults.JointTorques(1,:);
    InverseDynamicsResults.DynamicResiduals.f6dof;
    InverseDynamicsResults.DynamicResiduals.t6dof(1:end-1,:)];
else
  q=InverseKinematicsResults.JointCoordinates;  
  torques=InverseDynamicsResults.JointTorques;
end

%% Computation of muscle forces (optimization)
Nb_frames=size(torques,2);
Nb_muscles=numel(Muscles);
% Optimisation parameters
F0 = zeros(Nb_muscles,1);
Fmin = zeros(Nb_muscles,1);

Fopt = zeros(Nb_muscles,Nb_frames);
Aopt = zeros(size(Fopt));

Lm=zeros(Nb_muscles,Nb_frames);
options = optimoptions(@fmincon,'Algorithm','sqp','Display','off','GradObj','off','GradConstr','off','TolFun',1e-6);
% options = optimoptions(@fmincon,'Algorithm','sqp','Display','off','GradObj','off','GradConstr','off','TolFun',1e-9,'MaxFunEvals',20000);
% options = optimoptions(@fmincon,'Algorithm','sqp','Display','off','GradObj','off','GradConstr','off','TolFun',1e-9,'MaxFunEvals',100000,'TolX',1e-9,'StepTolerance',1e-15,'FunctionTolerance',1e-10,'MaxIterations',5000);

h = waitbar(0,['Forces Computation (' filename ')']);
tic
for i=1:Nb_frames % for each frames
%     i
    % computation of muscle moment arms from joint posture

[R,Lm(:,i)]=MomentArmsComputationNum(BiomechanicalModel,q(:,i),0.001);
if i==1 % find the relevant joints
    [idxj,~]=find(sum(R,2)~=0);
end
    Aeq=R(idxj,:);
    % Joint Torques
    beq=torques(idxj,i); % C
    % Fmax
    Fmax = [Muscles.f0]';
    % Optimization
    Fopt(:,i) = AnalysisParameters.Muscles.Costfunction(F0, Aeq, beq, Fmin, Fmax, options, AnalysisParameters.Muscles.CostfunctionOptions, Fmax);
    % Muscular activity
    Aopt(:,i) = Fopt(:,i)./Fmax;
    F0=Fopt(:,i);
    waitbar(i/Nb_frames)

end
close(h)
% w=toc; %#ok<NASGU>

MuscleForcesComputationResults.MuscleActivations = Aopt;
MuscleForcesComputationResults.MuscleForces = Fopt;
MuscleForcesComputationResults.MuscleLengths = Lm;

disp(['... Forces Computation (' filename ') done'])


end