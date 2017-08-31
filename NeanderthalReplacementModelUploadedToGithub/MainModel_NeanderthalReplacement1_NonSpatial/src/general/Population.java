package general;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;
import java.util.Scanner;

public class Population {
	// simply the whole population in this deme: a list of bands
	public ArrayList<Agent> population;
	int popsize;
	ParamConfiguration conf;
	int numOfNeanderthals;
	int numOfModerns;
	
	public Population(int popsize, int popNum, ParamConfiguration conf) throws IOException {
		super();
		this.conf = conf;
		this.popsize = popsize;		
		this.population = this.CreateFirstGeneration(popsize, popNum);
		if (popNum==1) { //Europe 
			numOfNeanderthals = conf.deme1_size; numOfModerns = 0;
		} else { //Africa
			numOfModerns = conf.deme2_size; numOfNeanderthals = 0;
		}
	}

	protected ArrayList<Agent> CreateFirstGeneration(int popsize, int popNum) throws IOException {
		FileWriter popwriter = new FileWriter(conf.outdir + "initial_population" + popNum + "_conditions.txt");
		PrintWriter popOut = new PrintWriter(popwriter);
		ArrayList<Agent> pop = new ArrayList<Agent>();  
		for (int i=0;i<popsize;i++) {
			int speciesIdentity = popNum; // true ONLY for this first generation, of course!
			Agent newBand = new Agent(speciesIdentity, -1, conf); // 1 == Neanderthal, 2 == Modern
			pop.add(newBand);
			popOut.println(newBand.getSpeciesIdentity());
		}
		popOut.close();
		return pop;
	}	
	
	public void randomlyCullABand(int bandSerialNumber) {
		// called upon from maingame, on every step which was chosen to occur in this population.
		// The band serial number is not its ID, it is its location in the list within this population.
		int speciesIdentityOfCulled = population.get(bandSerialNumber).getSpeciesIdentity();
		population.remove(bandSerialNumber);
		if (speciesIdentityOfCulled==1) {numOfNeanderthals=numOfNeanderthals-1;}
		else {numOfModerns = numOfModerns - 1;}
	}
	
	public void addABand(Agent newBandToAdd) {
		population.add(newBandToAdd);
		
	}
}
