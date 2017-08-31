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
empirical_overlap = 5000; % 12000

% for the main runs, shown in the main text:
here = '/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/output_assessingSegregationTimeUntilFixation';
cd (here)
d = dir ('*sumstats*.txt');
for i = 1:length(d)
    currf = d(i).name
    popsize = regexprep(currf,'.+_pop',''); popsize = regexprep(popsize,'\.txt',''); popsize = str2num(popsize)
    M = dlmread(currf,'\t')
    counter = 0;
    for j = [4 1 2 3 5] % running over computation methods
    counter = counter + 1;
    figure(1);
    subplot(2,3,counter);
    plot(popsize,M(1,j),'b.','MarkerSize',30); hold on; % mean
    plot(popsize,M(3,j),'c.','MarkerSize',30); hold on; % median
    plot([popsize popsize],[M(5,j) M(6,j)],'g'); hold on; % range covering all but the 5% shortest runs
    xlabel('Europes carrying capacity [#bands]','FontSize',20); 
    ylabel({'Average number of times that a' 'band territory changes hands'},'FontSize',20);
    set(gca,'FontWeight','bold','FontSize',18);

        
    if (j==4) 
        figure(2); subplot(1,2,1);
        plot([popsize popsize],[M(5,j) M(6,j)],'g','LineWidth',4); hold on; % range covering all but the 5% shortest runs
        plot([popsize popsize],[M(4,j) M(6,j)],'r','LineWidth',4); hold on; % range covering the 5% shortest runs
        plot(popsize,M(1,j),'b.','MarkerSize',30); hold on; % mean
        plot(popsize,M(3,j),'c.','MarkerSize',30); hold on; % median
        xlabel('Europes carrying capacity [#bands]','FontSize',25); 
        ylabel({'Average number of times that a band territory changes hands'},'FontSize',25);
        title('segLastAboveAndLastBelowThreshes','FontSize',20);
        
        subplot (1,2,2);
        % calculating the range of replacement rates for which the null cannot be rejected:
        % (assuming <empirical_overlap> years of overlap)
        % The reasoning is this: 
        % per-gen-assumed-rep-prob = r  ;  empirical_overlap = o;
        % gen_length = g = 25; expected_number_of_replacements = e;
        % r * (o / g) = e
        % For the borderline (critical) e, we want to know what r is, and
        % thus: crit_r = crit_e * g / o
        
        crit = M(6,j);
        critRate = empirical_overlap/crit;
        critProbPerGeneration = 25/critRate;
        plot([popsize popsize],[0 critProbPerGeneration],'r','LineWidth',5); hold on;
        plot([popsize popsize],[critProbPerGeneration 1],'g','LineWidth',5); hold on;
        ylim([0 1]);
        xlabel('Europes carrying capacity [#bands]','FontSize',25); 
        ylabel('Probability of a territory changing hands, per generation','FontSize',25);

        
    end
    
    end
    figure(1)
    subplot(2,3,2); title('segTimesFromLastThreshCross','FontSize',12); 
    subplot(2,3,3); title('segTimesFromFirstThreshCross','FontSize',12); 
    subplot(2,3,4); title('segDurationsAboveThresh','FontSize',12); 
    subplot(2,3,1); title('segLastAboveAndLastBelowThreshes','FontSize',12); 
    subplot(2,3,5); title('segDurationsBetweenThreshes','FontSize',12); 
     
end
    
    
    