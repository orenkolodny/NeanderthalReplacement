% Should be run after having run multipleCallsToAnalyzeSegregationTimes,
% which in turn had called AnalyzingTheDurationOfSegregation_2, and after
% having copied the sumstats files to the root directory of this category
% of runs (which is currently 
% /Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/output_assessingSegregationTimeUntilFixation/MultipleOutputsForComparingMethodsInDiffMigRates/
% The script opens each file, and plots a 5-subplot figure of the 5 different
% methods of computing segregation time, and for each shows the mean,
% median, and 95% confidence interval (i.e. shows what the duration is for
% which only 5% of the runs were shorter on one end of the bar, and which was 
% the longest on the other end).

% The units are the units that are already in the sumStats files: average number of
% changing of hands per band-territory.

close all; clear all;

% for the main runs, shown in the main text:
here = '/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/output_assessingSegregationTimeUntilFixation/MultipleOutputsForComparingMethodsInDiffMigRates';
cd (here)
d = dir ('*sumstats*.txt');
for i = 1:length(d)
    currf = d(i).name
    %popsize = regexprep(currf,'.+_pop',''); popsize = regexprep(popsize,'\.txt',''); popsize = str2num(popsize)
    mig = regexprep(currf,'.+_mig','0.'); mig = regexprep(mig,'\.txt',''); mig = str2num(mig);
    M = dlmread(currf,'\t')
    counter = 0;
    for j = [4 1 2 3 5] % running over computation methods
        counter = counter + 1;
        figure(1);
        subplot(2,3,counter);
        semilogx(mig*100,M(1,j),'b.','MarkerSize',30); hold on; % mean
        semilogx(mig*100,M(3,j),'c.','MarkerSize',30); hold on; % median
        %plot([popsize popsize],[M(5,j) M(6,j)],'g'); hold on; % range covering all but the 5% shortest runs
        xlabel('Migration probability per time step','FontSize',20); 
        ylabel({'Average number of times that a' 'band territory changes hands'},'FontSize',20);
        set(gca,'FontWeight','bold','FontSize',18);
    end
    figure(1)
    subplot(2,3,2); title('segTimesFromLastThreshCross','FontSize',20); ylim([0 200]);
    subplot(2,3,3); title('segTimesFromFirstThreshCross','FontSize',20);
    subplot(2,3,4); title('segDurationsAboveThresh','FontSize',20); ylim([0 200]);
    subplot(2,3,1); title('segLastAboveAndLastBelowThreshes','FontSize',20); ylim([0 200]);
    subplot(2,3,5); title('segDurationsBetweenThreshes','FontSize',20); ylim([0 200]);
end
    
    
    