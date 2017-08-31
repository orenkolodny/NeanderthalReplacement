package spawning;

import general.Agent;
import general.ParamConfiguration;
import general.Population;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

public class unused_OffSpringCalculator {

	protected ParamConfiguration conf;
	private Random randomizer;
		
	public unused_OffSpringCalculator(ParamConfiguration conf) {
		this.conf = conf;
		this.randomizer = conf.randomizer;
	}

	/*
	public ArrayList<Agent> CreateOffspringGeneration() {
		// adds to each agent's record the number of offspring he had, and puts all the new
		// offspring in a pool that can be used for next-generation recruitment.
		HashMap<Agent,FemaleAgent> zivugim = conf.zivugim;
		ArrayList<Agent> offspringpool = new ArrayList<Agent>();
		int totnumofbastards = 0; //overall number of bastards in pop; parents will be found later
		for (Agent Ag : zivugim.keySet()) {
			int nestlings = zivugim.get(Ag).getNumofoffspring();
			// but if the male's condition is 0, the nesting utterly fails:
			if (Ag.getCondition()<=0) {nestlings = 0;}
			//int offsp=(int)Math.ceil(nestlings * Ag.getCondition());
			int offsp = conf.ParenthoodCalculation(nestlings, Ag.getCondition());
			Ag.AddOffspringToParent(offsp, "homegrown"); // add the offsprings to their father's CV
			//Ag.addoffsprings(offsp); // add the offsprings to their father's CV
			//Ag.setCurrentoffspringnum(offsp);
			totnumofbastards += (int)nestlings - offsp; // counting (over the whole colony) the number of EPY to be distributed among everyone at the end of the "legitimate children" calculation 
			Ag.ResetCurrentParasiteNumber(); // turn it to zero - to update this years parasites.
			Ag.AddParasitesToParent(nestlings - offsp); // inform the poor father of the num of parasites he has at home
			ConditionCalcAndUpdate(Ag, (int)nestlings); // make the father pay the price
			for (int e=0;e<offsp;e++) { // create the pool of offsprings
				//Agent newkid = new Agent(Ag.getStrategy(), conf); // was used for discrete strats
				Agent newkid = new Agent(Ag.getApreference(),Ag.getBpreference(),conf);
				offspringpool.add(newkid);
			}
		}

		// assigning the bastards fathers with linear proportion to their condition:
		//System.out.println("total number of bastards = "+totnumofbastards);
		ArrayList<Agent> bastards = ProportionalRandDraw.stickdraw(totnumofbastards, conf.population, conf);
		for (Agent bast : bastards) {offspringpool.add(bast);}
		
	return offspringpool;
	}
	*/
}