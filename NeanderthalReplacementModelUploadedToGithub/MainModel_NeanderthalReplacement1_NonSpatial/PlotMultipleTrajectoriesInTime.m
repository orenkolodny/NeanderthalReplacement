
This script is no longer in use; it is replaced by a copy of it 
that is found within AnalyzingTheDurationOfSegregation_2
=%==============================================================

close all

%use this to manually change directory
% cd('/Users/nicole/Documents/workspace/CulturalDiv7/output/Jul09080813/')
% newest='Jul09080813';

% %use this to read newest directory
here = '/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/'
cd (here)
d=dir('/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/');
d(1:3)=[];
dirFlags = [d.isdir]
d = d(dirFlags)
[dx,dx] = sort([d.datenum],'descend');
newest = d(dx(1)).name
cd(newest)

here = '/Users/orenkolodny/Documents/workspace/NeanderthalReplacement1/output_calculationsForUnidirectionalMigration_take3/';
cd(here);
newest = 'outputApr14114401_5';
cd(newest)


d2 = dir; d2(1:3) = []; dirFlags = [d2.isdir]; d2 = d2(dirFlags);
[dy,dy] = sort([d2.datenum],'descend');
counter = 0;
ttt = []
for i=1:10
   if (isempty(strfind(d2(dy(i)).name,'-1')))
       counter = counter + 1;
    cd([here newest '/' d2(dy(i)).name]);
    d2(dy(i)).name
    M = csvread('ChangeThroughTime.txt');
    subplot(3,3,counter)
    set(gca,'FontWeight','bold','FontSize',18);
%     figure; 
    plot(M(:,1),'-'); 
    %title( d2(dy(i)).name); 
    hold on;
    plot(find(M(:,1)==60,1,'last'),M(find(M(:,1)==60),1),'ro');
    t = length(M(:,1)) - find(M(:,1)==60,1,'last')
    ttt = [ttt t];
   end
end
    
mean(ttt)
    