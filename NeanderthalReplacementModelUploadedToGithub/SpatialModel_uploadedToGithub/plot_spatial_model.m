close all;

for i = 10:10:50
    M = csvread(['T_and_Replacements_per_site_Length_' num2str(i) '.csv']);
    a = ones(1,size(M,1));
    figure(1)
    subplot (1,2,1);
    plot(a*i,M(:,1),'g.'); hold on;
    plot(i,mean(M(:,1)),'b.','MarkerSize',30); hold on; % mean
    plot(i,median(M(:,1)),'c.','MarkerSize',30); hold on; % mean
    xlabel('Number of demes in the stepping-stone chain','FontSize',25); 
    ylabel({'Average number of times that a band' 'territory changes hands'},'FontSize',25);
%     title('segLastAboveAndLastBelowThreshes','FontSize',20);
median(M(:,2))
    subplot (1,2,2);
    plot(a*i,M(:,2),'y.'); hold on;
    plot(i,mean(M(:,2)),'b.','MarkerSize',30); hold on; % mean
    plot(i,median(M(:,2)),'c.','MarkerSize',30); hold on; % mean
    xlabel('Number of demes in the stepping-stone chain','FontSize',25); 
    ylabel({'Average number of times that a band' 'territory changes hands between different species'},'FontSize',25);

figure(2);
plot(i,median(M(:,2))/mean(M(:,1)),'b.','MarkerSize',30); hold on;

end

