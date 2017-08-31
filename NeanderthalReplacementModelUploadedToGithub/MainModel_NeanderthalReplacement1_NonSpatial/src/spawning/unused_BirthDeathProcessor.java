package spawning;

import general.Agent;
import general.ParamConfiguration;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

public class unused_BirthDeathProcessor {

	private Random randomizer = new Random();
	private double deathprob;
	private String birthmethod;
	ParamConfiguration conf;
	
	public unused_BirthDeathProcessor(double death_prob, String birth_method, ParamConfiguration conf) {
		this.deathprob = death_prob; // prob of death per individual per round
		this.birthmethod = birth_method;
		this.conf = conf;
	}

	public ArrayList<Agent> KillAndFill (ArrayList<Agent> curr_pop, ArrayList<Agent> offspringcadre)
	// kills off some of the individuals, and fills in the lines so as to keep a constant 
	// population size. the birth_method sets whether the new guys' parents will be randomly
	// chosen from the existing population, an outside pool, or with proportion to something,
	// or from this generations' offspring, which is the most reasonable option.
	{
		ArrayList<Agent> currpop = curr_pop;
		// killing:
		List<Agent> dead = new ArrayList<Agent>();
		for (int i=0;i<currpop.size();i++) {
			if (randomizer.nextDouble()<deathprob) {dead.add(currpop.get(i));}
			// also, if someone's condition is extremely negative - prehaps kill 'em off:
			//if (conf.) // for now - no. We want the pressure to come from the dynamic itself.
		}
		for (int j=0;j<dead.size();j++) {
			currpop.remove(dead.get(j));
		}
		
		// choosing with whom to refill the lines:
		List<Agent> children = new ArrayList<Agent>(); // all new agents that'll be added
		for (int i=0;i<dead.size();i++) {
			Agent newguy;
			if (birthmethod.equals("random_directly_from_parents")) {// some null-dynamics I might want to check?
				int a = randomizer.nextInt(currpop.size());
				newguy = new Agent(currpop.get(a).getSpeciesIdentity(),currpop.get(a).getParentID(),conf);
			} else { // The new guys are chosen from the last pool of offspring
				int a = randomizer.nextInt(offspringcadre.size());
				//System.out.println("cadre size: " +  offspringcadre.size());
				//Scanner sc = new Scanner(System.in);while(!sc.nextLine().equals("")); //wait for "enter"
				newguy = offspringcadre.get(a);
				// and removing him from the Cadre (as he's just been chosen):
				offspringcadre.remove(a);
			}
			children.add(newguy);
		}
		
		// refilling the lines:
		for (Agent Ag : children) {
			currpop.add(Ag);
		}
		return currpop;
}
}