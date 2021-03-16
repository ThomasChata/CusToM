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

load([filename '/ExperimentalData.mat']); %#ok<LOAD>
time = ExperimentalData.Time;
freq = 1/time(2);

Muscles = BiomechanicalModel.Muscles;
load([filename '/InverseKinematicsResults']) %#ok<LOAD>
load([filename '/InverseDynamicsResults']) %#ok<LOAD>



q=InverseKinematicsResults.JointCoordinates;
torques =InverseDynamicsResults.JointTorques;


Nb_q=size(q,1);
Nb_frames=size(torques,2);

%existing muscles
idm = logical([Muscles.exist]);
Nb_muscles=numel(Muscles(idm));

if ~isempty(intersect({BiomechanicalModel.OsteoArticularModel.name},'root0'))
    BiomechanicalModel.OsteoArticularModel=BiomechanicalModel.OsteoArticularModel(1:end-6);
end

%% computation of muscle moment arms from joint posture
% L0=zeros(Nb_muscles,1);
% Ls=zeros(Nb_muscles,1);
% for i=1:Nb_muscles
%     L0(i) = BiomechanicalModel.Muscles(i).l0;
%     Ls(i) = BiomechanicalModel.Muscles(i).ls;
% end
Lmt=zeros(Nb_muscles,Nb_frames);
R=zeros(Nb_q,Nb_muscles,Nb_frames);
for i=1:Nb_frames % for each frames
  %  Lmt(idm,i)   =   MuscleLengthComputationNum(BiomechanicalModel,q(:,i)); %dependant of every q (q_complete)
    R(:,:,i)    =   MomentArmsComputationNum(BiomechanicalModel,q(:,i),0.0001); %depend on reduced set of q (q_red)
end

idxj=find(sum(R(:,:,1),2)~=0)';

% Lm = Lmt./(Ls./L0+1);
% % Muscle length ratio to optimal length
% Lm_norm = Lm./L0;
% % Muscle velocity
% Vm = gradient(Lm_norm)*freq;

%% Computation of muscle forces (optimization)
% Optimisation parameters
Amin = zeros(Nb_muscles,1);
A0  = 0.5*ones(Nb_muscles,1);
Fmax = [Muscles(idm).f0]';
Amax = ones(Nb_muscles,1);
Fopt = zeros(Nb_muscles,Nb_frames);
Aopt = zeros(size(Fopt));
% Muscle Forces Matrices computation
%[Fa,Fp]=AnalysisParameters.Muscles.MuscleModel(Lm,Vm,Fmax);


% Solver parameters
options1 = optimoptions(@fmincon,'Algorithm','sqp','Display','final','GradObj','off','GradConstr','off','TolFun',1e-6,'MaxIterations',100000,'MaxFunEvals',100000);
options2 = optimoptions(@fmincon,'Algorithm','sqp','Display','final','GradObj','off','GradConstr','off','TolFun',1e-6,'MaxIterations',1000,'MaxFunEvals',2000000);

h = waitbar(0,['Forces Computation (' filename ')']);


[solid_path1,solid_path2,num_solid,num_markers]=Data_ClosedLoop(BiomechanicalModel.OsteoArticularModel);

dependancies=KinematicDependancy(BiomechanicalModel.OsteoArticularModel);
% Closed-loop constraints

KT=ConstraintsJacobian(BiomechanicalModel,q(:,1),solid_path1,solid_path2,num_solid,num_markers,ones(size(q,1),1),0.0001,dependancies)';

% tic();
% KT2 = FullConstraintsJacobian(BiomechanicalModel,q(:,1),solid_path1,solid_path2,num_solid,num_markers,ones(size(q,1),1),0.0000001,dependancies)';
% toc();


lambda = zeros(size(KT,2),1);

if isempty(lambda)
    idxj = [38 39 40 41]; % BO : elbow to hand
else
    idxj = 38:47; % BF : elbow to hand
end


%G = null(KT(idxj,:)');
%G=eye(size(KT));
% Moment arms and Active forces
% Aeq = G'*R(idq,:,1).*Fa(:,1)' ;
%Aeq = [G'*R(idxj,:,1).*Fmax' , G'*KT(idxj,:)] ;
Aeq = [R(idxj,:,1).*Fmax' , KT(idxj,:)] ;
% Joint Torques
%beq = G'*(torques(idq,1) - R(idq,:,1)*Fp(:,1));
beq = torques(idxj,1);
% First frame optimization

Amin = [Amin; -inf*ones(size(lambda))];
Amax = [Amax; inf*ones(size(lambda))];
[X(:,1)] = AnalysisParameters.Muscles.Costfunction([A0 ; lambda], Aeq, beq, Amin, Amax, options1, AnalysisParameters.Muscles.CostfunctionOptions, Fmax, Fmax);
%[Aopt(:,1)] = AnalysisParameters.Muscles.Costfunction(A0, Aeq, beq, Amin, Amax, options1, AnalysisParameters.Muscles.CostfunctionOptions, Fa(:,1), Fmax);
% Muscular activiy
Aopt(:,1) = X(1:Nb_muscles,1);
A0 = X(:,1);
Fopt(:,1) = Fmax.*Aopt(:,1);
%Fopt(:,1) = Fa(:,1).*Aopt(1:Nb_muscles,1)+Fp(:,1);

waitbar(1/Nb_frames)

for i=2:Nb_frames % for following frames
    % Closed-loop constraints
    KT=ConstraintsJacobian(BiomechanicalModel,q(:,i),solid_path1,solid_path2,num_solid,num_markers,ones(size(q,1),1),0.0001,dependancies)';
    %G = null(KT(idxj,:)');
    %G=eye(size(KT));

    % Moment arms and Active forces
   % Aeq = G'*R(idq,:,i).*Fa(:,i)';
    Aeq = [R(idxj,:,i).*Fmax' , KT(idxj,:)] ;
    % Joint Torques
%    beq=G'*(torques(idq,i)- R(idq,:,1)*Fp(:,i));
    beq=torques(idxj,i);
    % Optimization
%    [Aopt(:,i)] = AnalysisParameters.Muscles.Costfunction(A0, Aeq, beq, Amin, Amax, options2, AnalysisParameters.Muscles.CostfunctionOptions, Fa(:,i), Fmax);
    [X(:,i)] = AnalysisParameters.Muscles.Costfunction(A0, Aeq, beq, Amin, Amax, options1, AnalysisParameters.Muscles.CostfunctionOptions, Fmax, Fmax);
    % Muscular activity
    Aopt(:,i) = X(1:Nb_muscles,i);
    A0=X(:,i);
    Fopt(:,i) = Fmax.*Aopt(:,i);
%    Fopt(:,i) = Fa(:,i).*Aopt(1:Nb_muscles,i)+Fp(:,i);
    
    waitbar(i/Nb_frames)
end

% Static optimization results
MuscleForcesComputationResults.MuscleActivations(idm,:) = Aopt(1:Nb_muscles,:);
MuscleForcesComputationResults.MuscleForces(idm,:) = Fopt;
MuscleForcesComputationResults.MuscleLengths= Lmt;
MuscleForcesComputationResults.MuscleLeverArm = R;
MuscleForcesComputationResults.Lambda = X(Nb_muscles+1:end,:);

close(h)

disp(['... Forces Computation (' filename ') done'])


end