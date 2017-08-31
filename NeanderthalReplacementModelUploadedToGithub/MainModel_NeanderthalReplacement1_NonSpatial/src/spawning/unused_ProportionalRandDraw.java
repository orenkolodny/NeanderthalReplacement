package spawning;

import general.Agent;
import general.ParamConfiguration;

import java.util.ArrayList;
import java.util.Random;
import java.util.Scanner;



// =======================
// I deleted some stuff here that's related to the original simulation this was used for!!!
// =======================


public class unused_ProportionalRandDraw {

	public static ArrayList<Agent> stickdraw(int HowManyToProduce,ArrayList<Agent> fathers, 
			ParamConfiguration conf)
	// gets a list of fathers and a number of offspring to produce. Returns a List of the new
	// offspring (each has a strategy defined by his father's), and updates each father regarding how 
	// many new kids he has.
	{
		double SumOfFits=0; // sum of the conditions of all the fathers
		double[] sticknotches = new double[fathers.size()];	// the upper end of the 
											// piece of stick belonging to each agent
		ArrayList<Agent> youngs = new ArrayList<Agent>(); // the list of all new agents
		int i=-1;
		double prevnotch = 0.0;
		for (Agent loopfather : fathers)
		{	i++;
			double fathercondition = 1;
			if (fathercondition<=0) {fathercondition = 0.0000001;}
			sticknotches[i]= fathercondition + prevnotch;
			prevnotch = sticknotches[i];
		}
		SumOfFits = sticknotches[sticknotches.length-1];
		if (SumOfFits==0) {
			System.out.println("sum of fits is zero! (and I was required to produce "+HowManyToProduce+" new offspring");
			//Scanner sc = new Scanner(System.in);while(!sc.nextLine().equals("")); //wait for "enter"
			for (int q=0;q<sticknotches.length;q++) {sticknotches[q] = q;} //if all conditions are 
			// zero, distribute offspring among them randomly - shouldn't happen anyway, as there are no bastards in this case. 
		} 
		
		double currand; boolean found = false;
		Random locrand = new Random();
		for (int j = 0; j<HowManyToProduce; j++)
		{
			int searchind = (int) Math.floor(sticknotches.length/2);
			int n=(int) Math.floor(sticknotches.length/2); // 2*increment of initial search area
			//System.out.println("n: " + n); // check printout
			found = false;
			currand = locrand.nextDouble();
			// find who's child this is:
			while (!found)
			{
		     double upper = sticknotches[searchind]/SumOfFits; double lower;
			 if (searchind>0) {lower = sticknotches[searchind-1]/SumOfFits;}
			 else {lower = 0;}
			 if ((currand<upper) && (currand>=lower)) 
			 {
				found = true; 
				Agent chosenparent = fathers.get(searchind); 
				//String babystrategy = chosenparent.getStrategy(); // discrete strats
				//youngs.add(new Agent(babystrategy, conf));        // discrete strats
				//chosenparent.addoffsprings(1);
				//chosenparent.addToCurrentNumberOfOffspring(1);
				//chosenparent.updateTotalbastardoffspring(1);
				//System.out.println("found father " + searchind + "randnum: " + currand); //check printout
				//System.out.println("father endofstick " + sticknotches[searchind]/SumOfFits + "randnum: " + currand); 
			 }
			 else //parent still not found
			 {
				 n = (int)Math.ceil((double) n/2);
				 if (currand<upper)	 {searchind = searchind - n;}
				 else {searchind = searchind + n;}
				 if (searchind<0) {searchind=0;}
				 if (searchind>(sticknotches.length-1)) {searchind=(sticknotches.length-1);}
			 }
			}
		}
		return youngs;
	}
}
