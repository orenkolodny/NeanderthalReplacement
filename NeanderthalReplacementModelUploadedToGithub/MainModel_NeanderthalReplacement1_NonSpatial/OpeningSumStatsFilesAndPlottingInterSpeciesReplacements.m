% Should be run after having run multipleCallsToAnalyzeSegregationTimes,
% which in turn had called AnalyzingTheDurationOfSegregation_2, and after
% having copied the sumstats files to the root directory of this category
% of runs (which is currently 
% /Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/output_assessingSegregationTimeUntilFixation/

% The script opens each file, and plots a 5-subplot figure of the 5 different
% methods of computing segregation time, and for each shows the mean,
% median, and 95% confidence interval (i.e. shows what the duration is for
% which only 5% of the runs were shorter on one end of the bar, and which was 
% the longest on the other end).

% The units are the units that are already in the sumStats files: average number of
% changing of hands per band-territory.

close all; clear all;
% for the main runs, shown in the main text:
here = '/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/output_assessingSegregationTimeUntilFixation/InterSpeciesSumStats2';
cd (here)
d = dir ('*sumstats*.txt');

for i = 1:length(d)
    currf = d(i).name
    popsize = regexprep(currf,'.+_pop',''); popsize = regexprep(popsize,'_incSwithcingHandsCount2\.txt',''); popsize = str2num(popsize)
    M = dlmread(currf,'\t')
    counter = 0;
    for j = [4] % 1 2 3 5] % running over computation methods
%     counter = counter + 1;
%     figure(1);
%     plot(popsize,M(1,j),'b.','MarkerSize',30); hold on; % mean
%     xlabel('Europes carrying capacity [#bands]','FontSize',20); 
%     ylabel({'Average number of times that a' 'band territory changes hands'},'FontSize',20);
%     set(gca,'FontWeight','bold','FontSize',18);

        
    if (j==4) 
        figure(1);         
        errorbar(popsize,M(14,j),M(15,j),'b.','MarkerSize',30); hold on; % mean
        xlabel('Europes carrying capacity [#bands]','FontSize',25); 
        %ylabel({'Median number of times that a band territory' 'changes hands between different species'},'FontSize',25);
        ylabel({'Mean number of times that a band territory' 'changes hands between different species'},'FontSize',25);

        
        figure(2)
        plot(popsize,M(14,j)/M(1,j),'b.','MarkerSize',30); hold on;
        xlabel('Europes carrying capacity [#bands]','FontSize',25); 
        ylabel({'Fraction of inter-species replacements of the total'},'FontSize',25);

        
    end
    
    end
    figure(1)

     
end
    
    
    