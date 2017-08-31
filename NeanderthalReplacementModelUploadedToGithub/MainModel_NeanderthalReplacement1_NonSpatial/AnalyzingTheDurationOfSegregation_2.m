%close all; clear all;

%use this to read newest directory

% % % here = '/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/'
% % % cd (here)
% % % d=dir(here);
% % % d(1:3)=[];
% % % dirFlags = [d.isdir]
% % % d = d(dirFlags)
% % % [dx,dx] = sort([d.datenum],'descend');
% % % newest = d(dx(1)).name
% % % cd(newest)

% The following is commented out so the caller of this script can decide
% where the files are himself.
here = '/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/output_assessingSegregationTimeUntilFixation/';

DirToAnalyzeNow = 'outputMay02102720_pop10'; %'outputApr29115053_pop50' ;%'outputApr29130315_pop100'; %'outputApr29132335_pop500' %'outputApr28215511_pop200';%'outputMay02103424_pop300' %'outputApr29115053_pop50' %;%'outputMay02112635_pop400' %'outputApr29115053_pop50'; %;
cd(here);
cd(DirToAnalyzeNow)

% finding the pop size from the filename:
d = dir ('*Final*.txt');
currf = d(1).name
d1size = regexprep(currf,'.+d1Size_',''); d1size = regexprep(d1size,'d2Size.+',''); % fixes one type of filename i used
%d1size = regexprep(currf,'.+deme1Size_',''); d1size = regexprep(d1size,'.txt',''); % fixes another type
d1size = str2num(d1size);
d2size = 100;

thresh = round(0.1 * d1size);

d2 = dir; d2(1:3) = []; dirFlags = [d2.isdir]; d2 = d2(dirFlags);
[dy,dy] = sort([d2.datenum],'descend');
counter = 0;
segTimesFromLastThreshCross = []; segTimesFromFirstThreshCross = [];
segDurationsAboveThresh = []; segLastAboveAndLastBelowThreshes = [];
segDurationsBetweenThreshes = [];
ModernToNeandHandovers = []; NeandToModernHandovers = [];
for i=1:500%500%16 %500
    i
   if (isempty(strfind(d2(dy(i)).name,'-1')))
       counter = counter + 1;
    cd([here DirToAnalyzeNow '/' d2(dy(i)).name]);
    d2(dy(i)).name
    M = csvread('ChangeThroughTime.txt');
    if (i<10) %drawing trajectories for a few runs
        subplot(3,3,counter)
        %     figure; 
        plot(M(:,1),'-'); 
        %title( d2(dy(i)).name); 
        hold on;
        plot(find(M(:,1)==thresh,1,'last'),M(find(M(:,1)==thresh),1),'ro','MarkerSize',12);
        plot(find(M(:,1)==(d1size-thresh),1,'last'),M(find(M(:,1)==(d1size-thresh)),1),'go','MarkerSize',12);
        set(gca,'FontWeight','bold','FontSize',18);
        %plot(find(M(:,1)>=thresh),80,'c.');
        %plot((find((M(:,1)>=thresh) & (M(:,1)<=(d1size-thresh)))),100,'c.');
    end
    t_fromLastThreshCross = length(M(:,1)) - find(M(:,1)==thresh,1,'last')
    segTimesFromLastThreshCross = [segTimesFromLastThreshCross t_fromLastThreshCross];
    t_fromFirstThreshCross = length(M(:,1)) - find(M(:,1)==thresh,1,'first')
    segTimesFromFirstThreshCross = [segTimesFromFirstThreshCross t_fromFirstThreshCross];
    t_aboveThresh = length(find(M(:,1)>=thresh))
    segDurationsAboveThresh = [segDurationsAboveThresh t_aboveThresh];
    t_fromLastThreshToLastUpperThresh = find(M(:,1)==(d1size-thresh),1,'last') - find(M(:,1)==thresh,1,'last');
    segLastAboveAndLastBelowThreshes = [segLastAboveAndLastBelowThreshes t_fromLastThreshToLastUpperThresh]; 
    t_betweenUpperAndLowerThreshes = length(find((M(:,1)>=thresh) & (M(:,1)<=(d1size-thresh))));
    segDurationsBetweenThreshes = [segDurationsBetweenThreshes t_betweenUpperAndLowerThreshes];
   
   % finding the number of times that a territory switched hands between
   % species (on average): [[added 1 July 2016]]
   ModernsDuringCoexistence = M(:,1); mdc = ModernsDuringCoexistence;
   a = find(M(:,1)==thresh,1,'last'); b = find(M(:,1)==(d1size-thresh),1,'last');
   mdc = mdc(a : b); mdc1 = mdc(1:end-1); mdc2 = mdc(2:end);
   dif = mdc2-mdc1;
   NeandToModernHandover = sum(dif==1);
   ModernToNeandHandover = sum(dif==-1);
   NeandToModernHandovers = [NeandToModernHandovers NeandToModernHandover];
   ModernToNeandHandovers = [ModernToNeandHandovers ModernToNeandHandover];
   end
end
subplot(3,3,4); ylabel({'The Frequency of Moderns in the' 'hominid population of Europe'},'FontSize',25,...
    'FontWeight','bold');
subplot(3,3,8); xlabel({' ' 'Time step'},'FontSize',25,'FontWeight','bold');
    
sumstats = ones(13,5)*(-1);
NT = d1size + d2size; % Number of Territories
for st = 1:5 % Runs over the 4 methods of calculation of coexistence-duration, and collects summary
             % statistics for each
   if (st==1) 
       measure = segTimesFromLastThreshCross 
   elseif (st==2) 
       measure = segTimesFromFirstThreshCross
   elseif (st==3) 
       measure = segDurationsAboveThresh
   elseif (st==4) 
       measure = segLastAboveAndLastBelowThreshes
   elseif (st==5) 
       measure = segDurationsBetweenThreshes
   end
   measure = measure./NT;
   sumstats(1,st) = mean(measure);
   sumstats(2,st) = std(measure);
   sumstats(3,st) = median(measure);
   sumstats(4,st) = min(measure);
   sumstats(5,st) = max(measure);
   sumstats(6,st) = quantile(measure, 0.05);
   sumstats(7,st) = quantile(measure, 0.025);
   sumstats(8,st) = quantile(measure, 0.975);
   sumstats(9,st) = thresh;
   sumstats(10,st) = d1size;
   sumstats(11,st) = d2size;
   sumstats(12,st) = median(ModernToNeandHandovers/d1size);
   sumstats(13,st) = median(NeandToModernHandovers/d1size);
   sumstats(14,st) = mean((NeandToModernHandovers+ModernToNeandHandovers)/d1size);
   sumstats(15,st) = std((NeandToModernHandovers+ModernToNeandHandovers)/d1size);
   sumstats(16,st) = median((NeandToModernHandovers+ModernToNeandHandovers)/d1size);

end

% meanSegTimeFromLastThreshCross = mean(segTimesFromLastThreshCross)
% stdSegTimeFromLastThreshCross = std(segTimesFromLastThreshCross)
% medianSegTimeFromLastThreshCross = median(segTimesFromLastThreshCross)
% 
% meanSegTimeFromFirstThreshCross = mean(segTimesFromFirstThreshCross)
% stdSegTimeFromFirstThreshCross = std(segTimesFromFirstThreshCross)
% medianSegTimeFromFirstThreshCross = median(segTimesFromFirstThreshCross)
% 
% meansegDurationsAboveThresh = mean(segDurationsAboveThresh)
% stdsegDurationsAboveThresh = std(segDurationsAboveThresh)
% mediansegDurationsAboveThresh = median(segDurationsAboveThresh)

% statistics summary:
% NT = d1size + d2size; % Number of Territories
% summary = [thresh 0 ; d1size d2size ; meanSegTimeFromLastThreshCross stdSegTimeFromLastThreshCross ; ...
%     meanSegTimeFromFirstThreshCross stdSegTimeFromFirstThreshCross; meansegDurationsAboveThresh ...
%     stdsegDurationsAboveThresh; 0 0 ; meanSegTimeFromLastThreshCross/NT 0; meanSegTimeFromFirstThreshCross/NT 0; ...
%     meansegDurationsAboveThresh/NT 0; 0 0; 0 medianSegTimeFromLastThreshCross; 0 medianSegTimeFromFirstThreshCross; ...
%     0 mediansegDurationsAboveThresh; medianSegTimeFromLastThreshCross/NT 0; medianSegTimeFromFirstThreshCross/NT 0; ...
%     mediansegDurationsAboveThresh/NT 0]

cd(here); cd(DirToAnalyzeNow);
% csvwrite(['sumstats_pop' num2str(d1size) '.txt'],sumstats);
%dlmwrite(['sumstats_pop' num2str(d1size) '.txt'],sumstats,'\t');
dlmwrite(['sumstats_pop' num2str(d1size) '_incSwithcingHandsCount2.txt'],sumstats,'\t'); % tiny name change, just because I don't want to 
% overwrite existing files; added when adding the count of per-territory-inter-species-replacement, 1July2016

