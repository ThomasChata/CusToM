%% Optimisation des bras de levier
clear variables;
cmap=colormap(parula(3));
set(groot, 'DefaultAxesColorOrder', cmap,'DefaultAxesFontSize',20,'DefaultLineLineWidth',3);
close;
format long

[ModelParameters,AnalysisParameters]=Parameters;

save('ModelParameters.mat','ModelParameters');
save('AnalysisParameters.mat','AnalysisParameters');

Main;

load('BiomechanicalModel.mat');

temp={BiomechanicalModel.Muscles.name};
for k=1:length(temp)
    temp2=temp{k};
    temp{k}=temp2(2:end);
end
all_muscles=unique(temp);

%% Stockage dans un fichier texte

MomentsArmRegression=MomentsArmRegression_creationRRN();
LengthRegression=MuscleLengthRegression_creationRRN();


all_muscles= {'Brachioradialis',...
    'ExtensorCarpiRadialisLongus',...
    'ExtensorCarpiRadialisBrevis',...
    'ExtensorCarpiUlnaris',...
    'FlexorCarpiUlnaris','FlexorCarpiRadialis',...
     'PalmarisLongus' ,'PronatorTeres', ...
     'Anconeus',...
     'Brachialis',...
    'PronatorQuadratus' ,'SupinatorBrevis' ,'TricepsMed','TricepsLat'...
        };

for i=1:length(all_muscles)
    
    
    
    name_mus=all_muscles{i};
    
    [fctcoutx,RMS,RMSLmt,involved_solids,num_markersprov,BiomechanicalModel]=MomentArmOptimisation(name_mus,BiomechanicalModel,MomentsArmRegression,LengthRegression);
    
    
    
    fileID = fopen('via_points_final2.txt','a');
    
    solid_interet=involved_solids{1};
    markers_interet=num_markersprov{1};
    
    for k=1:length(solid_interet)
        temp1=solid_interet(k);
        temp2=markers_interet(k);
        nom_pt_passage=BiomechanicalModel.OsteoArticularModel(temp1).anat_position{temp2,1};
        pt_passage=BiomechanicalModel.OsteoArticularModel(temp1).anat_position{temp2,2};
        
        
        nom_pt_passage=nom_pt_passage(2:end);
        pt_passage=BiomechanicalModel.OsteoArticularModel(temp1).anat_position{temp2,2} +  BiomechanicalModel.OsteoArticularModel(temp1).c ;
        fprintf(fileID,'[Signe ''%6s''], k*Mirror*[%6.4f ; %6.4f ; %6.4f] - COM ;... \n',nom_pt_passage,pt_passage);
        fprintf(fileID,'[Signe ''%6s''], [%6.4f  %6.4f  %6.4f] ;... \n',nom_pt_passage,[0 -1 0;0 0 -1; 1 0 0]*pt_passage);
        
    end
    
    for p=1:size(RMS,2)
        fprintf(fileID,'RMS MA %6s :    %6.4f  (%6.4f )] ;... \n',RMS(p).axe,RMS(p).rms,RMS(p).rmsr);
    end
    
    fprintf(fileID,'RMS Lmt :    %6.4f ] ;... \n',RMSLmt.rmsr);
    fprintf(fileID,'Corr Lmt :    %6.4f  ] ;... \n',RMSLmt.corr);
    fprintf(fileID,'Signe diff  :    %6.4f  ] ;... \n',RMSLmt.sign);
    fprintf(fileID,'Fctcout  :    %6.4f ] ;... \n',fctcoutx);
    
    
    
    fclose(fileID);
    
    
    
    
end


save('BiomechanicalModel.mat','BiomechanicalModel');


% Affichage des correlations vs les longueurs

NamesPA1 = {'BRD','ECRL','ECRB'};
LmtPA1  = [16.8745  , 21.2039, 18.4362 ];
CorrPA1 = abs([0.9990  ,  0.9878  ,  0.9894 ]);
NamesPA2 = {'ECU', 'FCU','FCR'};
LmtPA2  = [ 16.0798   5.7539  19.8811 ];
CorrPA2 = abs([0.8483   0.9718  0.9555    ]);
NamesPA3 = {'PL','PT'};
LmtPA3  = [ 4.1776 ,  0.9107 ];
CorrPA3 = abs(  [0.9622 , 0.9986 ] );



NamesMA2={'ANC','SUP','TRImed','TRIlat'};
LmtMA2=[75.4469  864.8622   2.6498  2.5961  ] ;
CorrMA2 = abs( [0.9998    0.9985  0.9999  0.9999]) ;
NamesMA1={'PQ'};
LmtMA1=[  186.2619 ] ;
CorrMA1 = abs( [ 1.0000  ]) ;
NamesMA3={'BRA' };
LmtMA3=[ 19.3194  ] ;
CorrMA3 = abs( [0.9993]) ;


figure()
hold on
grid on
plot(LmtPA1,CorrPA1,'Marker','d','MarkerSize',20,'MarkerFaceColor','m','LineStyle','none','MarkerEdgeColor',[0 0 0]);
plot(LmtMA1,CorrMA1,'Marker','o','MarkerSize',20,'MarkerFaceColor','g','LineStyle','none','MarkerEdgeColor',[0 0 0]);
plot(LmtPA2,CorrPA2,'Marker','d','MarkerSize',20,'MarkerFaceColor','m','LineStyle','none','MarkerEdgeColor',[0 0 0]);
plot(LmtPA3,CorrPA3,'Marker','d','MarkerSize',20,'MarkerFaceColor','m','LineStyle','none','MarkerEdgeColor',[0 0 0]);
plot(LmtMA2,CorrMA2,'Marker','o','MarkerSize',20,'MarkerFaceColor','g','LineStyle','none','MarkerEdgeColor',[0 0 0]);
plot(LmtMA3,CorrMA3,'Marker','o','MarkerSize',20,'MarkerFaceColor','g','LineStyle','none','MarkerEdgeColor',[0 0 0]);
text(LmtPA1,CorrPA1,NamesPA1,'FontSize',40)
text(LmtPA2,CorrPA2,NamesPA2,'FontSize',40)
text(LmtPA3,CorrPA3,NamesPA3,'FontSize',40)
text(LmtMA1,CorrMA1,NamesMA1,'FontSize',40)
text(LmtMA2,CorrMA2,NamesMA2,'FontSize',40)
text(LmtMA3,CorrMA3,NamesMA3,'FontSize',40)

xlabel('Musculo-tendon length rRMSE (%)')
ylabel('Correlation')
legend({'Pluri-articular muscles','Mono-articular muscles'})

ax=gca;
ax.FontSize=50;
ax.FontName='Utopia';
set(gca,'xscale','log')
