close all; clear all;

%use this to manually change directory
here = '/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/output_Non_Symmetric_Migration';
cd (here)
d = dir ('*Final*.txt');
migrates = []; Probs = []; sterrs =[]; 
d1Sizes =[];
for i = 1:length(d)
    currf = d(i).name
    currmigrate = regexprep(currf,'.+m1',''); currmigrate = regexprep(currmigrate,'m2.+',''); currmigrate = str2num(currmigrate)
    d1size = regexprep(currf,'.+d1Size_',''); d1size = regexprep(d1size,'d2Size.+',''); d1size = str2num(d1size);
    M = csvread(currf);
    modernWins = sum(M(:,3)==500); NeandWins = sum(M(:,3)==0);
    p = modernWins/(NeandWins+modernWins); serr = sqrt(p*(1-p)/length(M(:,1)));
    Probs = [Probs p]; sterrs = [sterrs serr];
    migrates = [migrates currmigrate];
end
% plot(popsizes, meanest,'.')
% subplot(1,2,1)
% errorbar(d1Sizes./500,mig1Probs,mig1sterrs,'.'); hold on;
errorbar(migrates./0.000005,Probs,2*sterrs,'b.'); hold on;
plot(migrates./0.000005,Probs,'.','MarkerSize',25)
set(gca,'xscale','log')
% errorbar(d1Sizes./500,mig3Probs,mig3sterrs,'g.'); hold on;
%ylim([0 1.1]);

% % subplot(1,2,2);
% % plot(d1Sizes./500,mig2Probs./(1-mig2Probs),'.'); hold on
% % plot(d1Sizes./500,(1./(d1Sizes./500)).^2,'or'); % The intuitions predict a (N1/N2)^3 advantage, 
% but in reality I get less than a power-of-2 advatage. That sort of makes
% sense, because the intuitions hold only very early on, and then break
% down; in each of the processes there remains an advantage to the Moderns
% or it becomes fair (doesn't flip to a Neanderthal advantage in any case),
% so the direction remains correct throughout, but not the magnitude of the
% effects I describe in the text.

% subplot(1,3,1);
% errorbar(popsizes,meantime,stdOfMeanTime,'.'); hold on;
% errorbar(popsizes,meantime,stdOfMeanTime/sqrt(length(M(:,1))),'r.'); hold on;
% 
% subplot(1,3,3)
% errorbar(popsizes,meanContributingEsts,stdOfContributing,'.'); hold on;
% errorbar(popsizes,meanContributingEsts,stdOfContributing/sqrt(length(M(:,1))),'r.'); hold on;

% To put them on the same figure (the plot becomes too busy):
% ax1 = gca; ax1.YColor = 'k';
% ax1_pos = ax1.Position; % position of first axes
% ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
% line(popsizes,meantime,'Parent',ax2,'Color','g'); hold on;
% errorbar(popsizes, meantime, stdOfMeanTime,'c.');





% 
% % %use this to read newest directory
% here = '/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/'
% cd (here)
% d=dir('/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/');
% d(1:3)=[];
% dirFlags = [d.isdir]
% d = d(dirFlags)
% [dx,dx] = sort([d.datenum],'descend');
% newest = d(dx(1)).name
% cd(newest)
% 
% d2 = dir; d2(1:3) = []; dirFlags = [d2.isdir]; d2 = d2(dirFlags);
% [dy,dy] = sort([d2.datenum],'descend');
% counter = 0;
% for i=1:10
%    if (isempty(strfind(d2(dy(i)).name,'-1')))
%        counter = counter + 1;
%     cd([here newest '/' d2(dy(i)).name]);
%     d2(dy(i)).name
%     M = csvread('ChangeThroughTime.txt');
%     subplot(3,3,counter)
% %     figure; 
%     plot(M(:,1),'-'); title( d2(dy(i)).name) 
%    end
% end
    
    
% % %     
% % %      filename = sprintf('%s%d%s','run',i,'/NumOfToolsPerGeneration.txt');
% % %      filename
% % %      M=csvread(filename);
% % %     
% % %     %     filenameE = sprintf('%s%d%s','run',i,'_1popsOfSize100Type0/EnvironmentData.txt');
% % %     %     E=csvread(filenameE);
% % %     
% % %     if (execute_fit)
% % %         %linear fit
% % %         P1 = polyfit(M(:,1),M(:,2),1)
% % %         Y1 = polyval(P1,M(:,1));
% % %         sum((M(:,2)-Y1).^2)/length(Y1)
% % %         
% % %         %quadratic fit
% % %         P2 = fit(M(:,1),M(:,2),'poly2')
% % %         Y2 = feval(P2,M(:,1));
% % %         sum((M(:,2)-Y2).^2)/length(Y2)
% % %         
% % %         %exponential fit
% % %         PE = fit(M(:,1),M(:,2),'exp1')
% % %         YE = feval(PE,M(:,1));
% % %         sum((M(:,2)-YE).^2)/length(YE)
% % %         
% % %         
% % %         %standard deviation in bins of 50 - not used currently
% % %         for j=50:50:length(M(:,1))
% % %             DEV(j/50,1)=j;
% % %             DEV(j/50,2)=std(M([j-49:j],2));
% % %         end
% % %     end
% % % %     figure
% % % %     diffvec=diff(M(:,2));
% % % %     hist(diffvec(diffvec<0),[-20:0])
% % % %     
% % % 
% % %     Mcorrected = M;
% % %     Mcorrected(:,3) = Mcorrected(:,3)-Mcorrected(:,6);
% % % 
% % %     figure
% % %     %subplot(1,4,i+1)
% % %     %b=bar(M(:,3:6),1,'stacked','edgecolor','none')
% % %     % b=bar(M(:,[3,4,6,5]),1,'stacked','edgecolor','none')
% % %     
% % %     b=bar(Mcorrected(:,[3,6,4,5]),1,'stacked','edgecolor','none')
% % %     set(b(1),'facecolor',[228/255 26/255 28/255],'edgecolor',[228/255 26/255 28/255])
% % %     set(b(3),'facecolor',[255/255 153/255 51/255],'edgecolor',[255/255 153/255 51/255])
% % %     set(b(4),'facecolor',[255/255 255/255 51/255],'edgecolor',[255/255 255/255 51/255])
% % %     set(b(2),'facecolor','g','edgecolor','g')
% % %     % %     set(b(1),'facecolor',[8/255 48/255 107/255],'edgecolor',[8/255 48/255 107/255])
% % %     % %     set(b(2),'facecolor',[49/255 130/255 189/255],'edgecolor',[49/255 130/255 189/255])
% % %     % %     set(b(3),'facecolor',[189/255 215/255 231/255],'edgecolor',[189/255 215/255 231/255])
% % %     xlabel('Timestep')
% % %     ylabel('Total number of tools')
% % %     %xlim([0,length(M(:,1))])
% % %     %xlim([0 20000])
% % %     %ylim([0,1000])
% % %     hold on
% % %     plot(M(:,1),M(:,2),'-k','linewidth',2)
% % %     plot(M(:,1),M(:,3),'-b','linewidth',2)
% % %     title([newest '  run' num2str(i)])
% % %     
% % %     
% % %     % adding dots at the generations on which unique stable-state-related
% % %     % changes occured:
% % %     c=dir(sprintf('%s%d%s','run',i,'/LossRateChanges.txt'));
% % %     if (~isempty(c)) 
% % %     if (c.bytes > 0) 
% % %         filename1 = sprintf('%s%d%s','run',i,'/LossRateChanges.txt');
% % %         losses=csvread(filename1);
% % %         hold on; plot(losses(:,1),zeros(length(losses(:,1))),'.g','MarkerSize',30)
% % %     end
% % %     end
% % %     
% % %     d = dir(sprintf('%s%d%s','run',i,'/CarryingCapacityChanges.txt'));
% % %     if (d.bytes>0)  
% % %         filename1 = sprintf('%s%d%s','run',i,'/CarryingCapacityChanges.txt');
% % %         cccs=csvread(filename1);  
% % %         hold on; plot(cccs(:,1),zeros(length(cccs(:,1))),'.b','MarkerSize',30)
% % %     end
% % %     
% % %     e = dir(sprintf('%s%d%s','run',i,'/LossRateReverseChange.txt'))
% % %     if (~isempty(e)) 
% % %     if (e.bytes>0)
% % %         filename2 = sprintf('%s%d%s','run',i,'/LossRateReverseChange.txt');
% % %         reversechange=csvread(filename2);  
% % %         hold on; plot(reversechange(:,1),zeros(length(reversechange(:,1))),'.c','MarkerSize',30)
% % %     end
% % %     end
% % %     
% % %         
% % %     
% % %     
% % % %     figure
% % % %     plot(M(1:500:end,1),M(1:500:end,3),'-r','linewidth',2)
% % % %     hold on
% % % %     plot(M(1:500:end,1),M(1:500:end,4),'-c','linewidth',2)
% % % %     plot(M(1:500:end,1),M(1:500:end,5),'-y','linewidth',2)
% % % %     %     b(1).FaceColor = 'red';
% % % %     
% % % %     %     b(2).FaceColor = 'yellow';
% % % %     %     b(3).FaceColor = 'green';
% % % %     plot(M(:,1),M(:,2),'-k','linewidth',2)
% % % %     
% % % %     if (execute_fit)
% % % %         %     plot(M(:,1),Y1,'-b') %plot linear fit
% % % %         plot(M(:,1),Y2,'--b')
% % % %         plot(M(:,1),YE,'-.b')
% % % %         %     plot(M(:,1),M(:,6),'-r')
% % % %         %     plot(DEV(:,1),DEV(:,2),'-k')
% % % %     end
% % % %     title(newest)
% % % %     xlabel('Timestep')
% % % %     ylabel('Total number of cultural traits')
% % % %     %     legend('Population 1','Population 2','Binned StDev')
% % % %     legend('Main axis traits','Toolkit traits','Combination traits','Total traits','Quadratic fit','Exponential fit','Location','NorthWest')
% % % %     xlim([0,length(M(:,1))])
% % % %     hold off
% % %     
% % %     %this puts the figure in the same folder as the data
% % %     filename2 = sprintf('%s%d%s','run',i,'_1popsOfSize100Type0/NumOfToolsPerGenerationPlot');
% % %     %print(filename2,'-dpng')
% % %     %print(filename2,'-dpdf')
% % %     
% % %     %this puts the figure in a central figures folder
% % %     % %     oldfolder=cd('/Users/nicole/Documents/workspace/CulturalDiv3/figures/');
% % %     % %     filename2 = sprintf('%s%s%s%d','NumOfToolsPerGeneration',newest,'_',i);
% % %     % %     print(filename2,'-dpng')
% % %     % %     cd(oldfolder)
% % %     
% % %     
% % %     %     close
% % %     
% % %     hold on;
% % %     t = M(:,1);
% % %     %     plot(t,P_l*N*t,'.b');
% % %     %     plot(t,P_lc*N*t,'.c'); % main leaps, corrected for s-loss
% % %     %     plot(t,P_lct*N*t,'.k'); % main leaps (coorected for s-loss) + toolkits
% % %     %      plot(t,N*N*P_lc/P_s - N*N*P_lc/P_s*exp(-P_s/N*t),'-b'); % main leaps, corrected
    % for s-loss, with spontanous loss
    %     plot(t,(N*N*P_lct/P_sc - N*N*P_lct/P_sc*exp(-P_sc/N*t)),'-m');% main leaps, corrected
    % for s-loss, with spontanous loss,
    % with tools
    %     plot(t,P_lc*N*t + P_lc*N*l*t + ((P_lc*N).^2)*f/2*(t.^2), '.g'); % all three processes,
    % no loss. combination
    % scheme 0.
    % plot(t,P_lc*N*t + P_lc*N*l*t + (P_lc*N)*(P_lc*N)*f/2*(t.^2) - P_lc*N*f*P_lc*N.*t, '.b'); %same, exact: looking at n-1 instead of n
    % tools to combine with.
    %    plot(t,P_lc*N*t + P_lc*N*l*t + 1/f*exp(P_lc*N*f*t) - P_lc*N*t - 1/f,'.g'); % same, comb scheme 1.
    
    
    
    % %Environmental figure
    %
    %     figure
    %     Ebar=E;
    %     Ebar(:,6)=E(:,4)+E(:,5)-E(:,3);
    %     Ebar(:,4)=E(:,4)-Ebar(:,6);
    %     Ebar(:,5)=E(:,5)-Ebar(:,6);
    %
    %     bE=bar(Ebar(:,[6,4,5]),1,'stacked','edgecolor','none')
    %     set(bE(1),'facecolor',[255/255 255/255 51/255],'edgecolor',[255/255 255/255 51/255])
    %     set(bE(2),'facecolor',[31/255 120/255 180/255],'edgecolor',[31/255 120/255 180/255])
    %     set(bE(3),'facecolor',[51/255 160/255 44/255],'edgecolor',[51/255 160/255 44/255])
    %
    %
    %     hold on
    %     plot(E(:,1),E(:,3),'-k')
    %
    %     %for two environments
    %     env1=E(E(:,2)==0,1);
    %     onevect1 = ones(length(env1),1);
    %     env2=E(E(:,2)==1,1);
    %     onevect2 = ones(length(env2),1);
    %     yl=ylim;
    %     plot(env1,onevect1*yl(2),'o','MarkerFaceColor',[31/255 120/255 180/255],'MarkerEdgeColor',[31/255 120/255 180/255],'MarkerSize',5)
    %     plot(env2,onevect2*yl(2),'o','MarkerFaceColor',[51/255 160/255 44/255],'MarkerEdgeColor',[51/255 160/255 44/255],'MarkerSize',5)
    % %     title(newest)
    %     xlabel('Timestep')
    %     ylabel('Total number of cultural traits')
    % %     legend('Population 1','Population 2','Binned StDev')
    %     legend('Both Environment traits','Environment 1 traits','Environment 2 traits','Total traits','Location','NorthWest')
    %     xlim([0,length(E(:,1))])
    %     hold off
    %
    %     %this puts the figure in the same folder as the data
    %     filename2 = sprintf('%s%d%s','run',i,'_1popsOfSize100Type0/EnvironmentPlot');
    %     %print(filename2,'-dpng')
    %     %print(filename2,'-dpdf')
    %
    %     %this puts the figure in a central figures folder
    % % %     oldfolder=cd('/Users/nicole/Documents/workspace/CulturalDiv3/figures/');
    % % %     filename2 = sprintf('%s%s%s%d','NumOfToolsPerGeneration',newest,'_',i);
    % % %     print(filename2,'-dpng')
    % % %     cd(oldfolder)
    %
    %
    %
    %subset 5000 generations
%     figure
%     b=bar(M(1:500,3:5),1,'stacked','edgecolor','none')
%     set(b(1),'facecolor',[228/255 26/255 28/255],'edgecolor',[228/255 26/255 28/255])
%     set(b(2),'facecolor',[255/255 153/255 51/255],'edgecolor',[255/255 153/255 51/255])
%     set(b(3),'facecolor',[255/255 255/255 51/255],'edgecolor',[255/255 255/255 51/255])
%     xlim([0,length(M(1:500,1))])
%     %
%     hold on
%     %     plot(M(1:500,1),M(1:500,3),'-r','linewidth',2)
%     %     hold on
%     %     plot(M(1:500,1),M(1:500,4),'-c','linewidth',2)
%     %     plot(M(1:500,1),M(1:500,5),'-y','linewidth',2)
%     plot(M(1:500,1),M(1:500,2),'-k','linewidth',2)
%     title(newest)
%     xlabel('Timestep')
%     ylabel('Total number of cultural traits')
%     legend('Main axis traits','Toolkit traits','Combination traits','Total traits','Location','NorthWest')
%     xlim([0,length(M(1:500,1))])
%     hold off
%     hold on;
%     t = M(:,1);
%     %     plot(t,P_l*N*t,'.b');
%     %     plot(t,P_lc*N*t,'.c'); % main leaps, corrected for s-loss
%     %     plot(t,P_lct*N*t,'.k'); % main leaps (coorected for s-loss) + toolkits
%     %     plot(t,N*N*P_lc/P_s - N*N*P_lc/P_s*exp(-P_s/N*t),'-b'); % main leaps, corrected
%     % for s-loss, with spontanous loss
%     %     plot(t,N*N*P_lct/P_sc - N*N*P_lct/P_sc*exp(-P_sc/N*t),'.r'); % main leaps, corrected
%     % for s-loss, with spontanous loss,
%     % with tools
%     %     plot(t,P_lc*N*t + P_lc*N*l*t + ((P_lc*N).^2)*f/2*(t.^2), '.g'); % all three processes,
%     % no loss. combination
%     % scheme 0.
%     % plot(t,P_lc*N*t + P_lc*N*l*t + (P_lc*N)*(P_lc*N)*f/2*(t.^2) - P_lc*N*f*P_lc*N.*t, '.b'); %same, exact: looking at n-1 instead of n
%     % tools to combine with.
    %    plot(t,P_lc*N*t + P_lc*N*l*t + 1/f*exp(P_lc*N*f*t) - P_lc*N*t - 1/f,'.g'); % same, comb scheme 1.                                               % with tools
% end
