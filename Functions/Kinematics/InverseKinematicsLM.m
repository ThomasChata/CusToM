function [ExperimentalData, InverseKinematicResults] = InverseKinematicsLM(filename,AnalysisParameters,BiomechanicalModel)
% Computation of the inverse kinematics step thanks to a Jacobian matrix
%   
%   INPUT
%   - filename: name of the file to process (character string)
%   - AnalysisParameters: parameters of the musculoskeletal analysis, automatically generated by the graphic interface 'Analysis'
%   - BiomechanicalModel: musculoskeletal model
%   OUTPUT
%   - ExperimentalData: motion capture data(see the Documentation for the structure)
%   - InverseKinematicResults: results of the inverse kinematics step (see the Documentation for the structure)
%________________________________________________________
%
% Licence
% Toolbox distributed under GPL 3.0 Licence
%________________________________________________________
%
% Authors : Antoine Muller, Charles Pontonnier, Pierre Puchaud and
% Georges Dumont
%________________________________________________________

%% Loading useful files
if ~exist(filename,'dir')
    mkdir(filename)
end
disp(['Inverse kinematics (' filename ') ...'])
Human_model = BiomechanicalModel.OsteoArticularModel;
Markers_set = BiomechanicalModel.Markers;

%% Symbolic function generation
% Markers position with respects to the joint coordinates
nbClosedLoop = sum(~cellfun('isempty',{Human_model.ClosedLoop})); %#ok<NASGU>

%% List of markers from the model
list_markers={};
for ii=1:numel(Markers_set)
    if Markers_set(ii).exist
        list_markers=[list_markers;Markers_set(ii).name]; %#ok<AGROW>
    end
end
%% Number of solids considered in the Inverse Kinematics
if isfield(BiomechanicalModel,'Generalized_Coordinates')
    nb_solid=length(BiomechanicalModel.Generalized_Coordinates.q_red);
else
    nb_solid=size(Human_model,2);  % Number of solids
end

%% Position of the real markers from the c3d file
[real_markers, nb_frame, Firstframe, Lastframe,f_mocap] = Get_real_markers(filename,list_markers,AnalysisParameters); 

%% Root position
Base_position=cell(nb_frame,1);
Base_rotation=cell(nb_frame,1);
for ii=1:nb_frame
    Base_position{ii}=zeros(3,1);
    Base_rotation{ii}=eye(3,3);
end

%% Initializations

% Linear constraints for the inverse kinematics
Aeq_ik=zeros(nb_solid);  % initialization
beq_ik=zeros(nb_solid,1);
for ii=1:nb_solid
   if size(Human_model(ii).linear_constraint) ~= [0 0] %#ok<BDSCA>
       Aeq_ik(ii,ii)=-1;
       Aeq_ik(ii,Human_model(ii).linear_constraint(1,1))=Human_model(ii).linear_constraint(2,1);
   end    
end

%% Inverse kinematics frame per frame

options1 = optimoptions(@fmincon,'Display','off','TolFun',1e-3,'MaxFunEvals',20000,'GradObj','off','GradConstr','off');

q=zeros(nb_solid,nb_frame);

addpath('Symbolic_function')

nb_cut=max([Human_model.KinematicsCut]);

Rcut=zeros(3,3,nb_cut);   % initialization of the position and the rotation of the cut coordinate frames
pcut=zeros(3,1,nb_cut);

list_function=cell(nb_cut,1);
for c=1:max([Human_model.KinematicsCut])
    list_function{c}=str2func(sprintf('f%dcut',c));
end
list_function_markers=cell(numel(list_markers),1);
for m=1:numel(list_markers)
    list_function_markers{m}=str2func(sprintf([list_markers{m} '_Position']));
end

% Joint limits
if isfield(BiomechanicalModel,'Generalized_Coordinates')
    q_map=BiomechanicalModel.Generalized_Coordinates.q_map;
    l_inf1=[Human_model.limit_inf]';
    l_sup1=[Human_model.limit_sup]';
    % to handle infinity
    ind_infinf=not(isfinite(l_inf1));
    ind_infsup=not(isfinite(l_sup1));
    % tip to handle inflinity with a complex number.
    l_inf1(ind_infinf)=1i;
    l_sup1(ind_infsup)=1i;
    % new indexing
    l_inf1=q_map'*l_inf1;
    l_sup1=q_map'*l_sup1;
    %find 1i to replay by inf
    l_inf1(l_inf1==1i)=-inf;
    l_sup1(l_sup1==1i)=+inf;
else
    l_inf1=[Human_model.limit_inf]';
    l_sup1=[Human_model.limit_sup]';
end

% Jacobian matrix loading
Jfq = BiomechanicalModel.Jacob.Jfq;
indexesNumericJfq = BiomechanicalModel.Jacob.indexesNumericJfq;
nonNumericJfq = BiomechanicalModel.Jacob.nonNumericJfq;
Jfcut = BiomechanicalModel.Jacob.Jfcut;
indexesNumericJfcut = BiomechanicalModel.Jacob.indexesNumericJfcut;
nonNumericJfcut = BiomechanicalModel.Jacob.nonNumericJfcut;
Jcutq = BiomechanicalModel.Jacob.Jcutq;
indexesNumericJcutq = BiomechanicalModel.Jacob.indexesNumericJcutq;
nonNumericJcutq = BiomechanicalModel.Jacob.nonNumericJcutq;
Jcutcut = BiomechanicalModel.Jacob.Jcutcut;
indexesNumericJcutcut = BiomechanicalModel.Jacob.indexesNumericJcutcut;
nonNumericJcutcut = BiomechanicalModel.Jacob.nonNumericJcutcut;
if isfield(BiomechanicalModel.Jacob,'RmvInd_q')
    RmvInd_q = BiomechanicalModel.Jacob.RmvInd_q;Ind_q=setdiff(1:nb_solid,RmvInd_q);
else
    RmvInd_q=[];Ind_q=setdiff(1:nb_solid,RmvInd_q);
end
% Inverse kinematics parameters
if isfield(BiomechanicalModel,'Generalized_Coordinates')
    pos_root =find(q_map'*([Human_model.mother]==0)'); %  root solid position;
else
    pos_root =find([Human_model.mother]==0); %  root solid position
end

lambda = 5e-2; % LM

h = waitbar(0,['Inverse Kinematics (' filename ')']);
% 1st frame : classical optimization
q0=zeros(nb_solid,1);   
ik_function_objective=@(qvar)CostFunctionSymbolicIK(qvar,nb_cut,real_markers,1,list_function,list_function_markers,Rcut,pcut);
[q(:,1)] = fmincon(ik_function_objective,q0,[],[],Aeq_ik,beq_ik,l_inf1,l_sup1,[],options1);
waitbar(1/nb_frame)

for f = 2:nb_frame
    % cut evaluation
    for c=1:nb_cut
        [Rcut(:,:,c),pcut(:,:,c)]=list_function{c}(q(:,f-1),pcut,Rcut);
    end
    % dx
    for m=1:numel(list_markers)
        dX((m-1)*3+1:3*m,:) = real_markers(m).position(f,:)'-list_function_markers{m}(q(:,f-1),pcut,Rcut);
    end
    % Jfq
    Jfq(indexesNumericJfq) = nonNumericJfq(q(:,f-1),pcut,Rcut);
    % Jfcut
    Jfcut(indexesNumericJfcut) = nonNumericJfcut(q(:,f-1),pcut,Rcut);
    % Jcutq
    Jcutq(indexesNumericJcutq) = nonNumericJcutq(q(:,f-1),pcut,Rcut);
    % Jcutcut
    Jcutcut(indexesNumericJcutcut) = nonNumericJcutcut(q(:,f-1),pcut,Rcut);
    % J
    J = Jfq + Jfcut*dJcutq(Jcutcut,Jcutq); J(:,RmvInd_q)=[];
    % dq (Levenberg�Marquardt)
    Jt = transpose(J);
    JtJ = Jt*J;
    A=(JtJ+lambda * diag(diag(JtJ)));
    B=Jt*(dX);
    dq = A\B;
    % joint coordinates computation
    q(Ind_q,f)=q(Ind_q,f-1)+dq;
%     q(Ind_q,f)=q(Ind_q,f-1)+[dq(1:pos_root-1,:);0;dq(pos_root:end,:)];
    waitbar(f/nb_frame)
end
close(h)

%% Data processing
if AnalysisParameters.IK.FilterActive
    % data filtering
    q=filt_data(q',AnalysisParameters.IK.FilterCutOff,f_mocap)';
end

% Error computation
KinematicsError=zeros(numel(list_markers),nb_frame);
nb_cut=max([Human_model.KinematicsCut]);
for f=1:nb_frame
    [KinematicsError(:,f)] = ErrorMarkersIK(q(:,f),nb_cut,real_markers,f,list_markers,Rcut,pcut);
end

% Reaffect coordinates
if isfield(BiomechanicalModel,'Generalized_Coordinates')
    q_complet=q_map*q; % real_coordinates
    fq_dep=BiomechanicalModel.Generalized_Coordinates.fq_dep;
    q_dep_map=BiomechanicalModel.Generalized_Coordinates.q_dep_map;
    for ii=1:size(q,2)
    q_complet(:,ii)=q_complet(:,ii)+q_dep_map*fq_dep(q(:,ii)); % add dependancies
    end
    
    q6dof=[q_complet(end-4:end,:);q_complet(1,:)];
    q=q_complet(1:end-6,:);
    q(1,:)=0;
else
    q6dof=[q(end-4:end,:);q(1,:)];
    q=q(1:end-6,:);
    q(1,:)=0;
end

time=real_markers(1).time'; 

%% Save data
ExperimentalData.FirstFrame = Firstframe;
ExperimentalData.LastFrame = Lastframe;
ExperimentalData.MarkerPositions = real_markers;
ExperimentalData.Time = time;

InverseKinematicResults.JointCoordinates = q;
InverseKinematicResults.FreeJointCoordinates = q6dof;
InverseKinematicResults.ReconstructionError = KinematicsError;
    
disp(['... Inverse kinematics (' filename ') done'])

%% We delete the folder to the path
rmpath('Symbolic_function')
end
