% Random walk along a discrete line; a model of a shifting front 
% of species interaction and eventual replacement.
% 

Durations = [];
handExchangesVect = [];
EuropehandExchangesVect = [];

for i = 1:50000
    i
    restartcounter = 0;
    Length = 50; % number of bands to be replaced along the trajectory
                     % from Africa to Spain.
    location = 1; % of the foremost Modern (starting from the far right)
    handExchanges = 0;
    timestep = 0; 
    while (location<Length) 
        timestep = timestep + 1; 
        whoDies = ((round(rand))*2)-1; % -1: a Modern. 1: a Neanderthal.
        whoReplaces = ((round(rand))*2)-1; % -1: a Neanderthal; 1: a Modern
        location = location + (whoDies+whoReplaces)/2; 
        if (location == 0) % an extinction event; I immediately set up a new colonizer
            restartcounter = restartcounter + 1;
            location = 1;
            handExchanges = 0;
            timestep = 0;
        end
        if (~(whoDies+whoReplaces==0)) % an exchange took place
            handExchanges = handExchanges + 1;
        end

    end
    Durations = [Durations timestep];
    handExchangesVect = [handExchangesVect handExchanges];
end

Durations = Durations ./ 2; % Durations is the num of time steps that occurred in the two sites 
                           % along the front. To get a per-site num of time
                           % steps, I divide by two.
handExchangesVect = handExchangesVect ./ (Length-2); % This gives me the number of exchanges per site,
                           % and the -2 is because the first and last sites
                           % are replaced never and once, respectively.
                           
% 'expected number of band replacements (mostly within-species), including away from the front, per site'
% mean(handExchangesVect)/Length * 2 * (Length-1)/2 % the 2 is to account for same-species replacements
%     % along the front, and the Length/2 is because the replacements happening per
%     % site while it is on the front are happening to it at the same rate when it isn't, but
%     % within-species only. The time it spends on the front (once on either side of it) is 2/(Length-1) of
%     % the total time of replacement.

dlmwrite(['T_and_Replacements_per_site_Length_' num2str(Length) '.csv'],[Durations' handExchangesVect'])

'mean + median hand exchanges per site'
mean(handExchangesVect)
median(handExchangesVect)

'mean + median durations (reps per site)' 
mean(Durations)  
median(Durations)  