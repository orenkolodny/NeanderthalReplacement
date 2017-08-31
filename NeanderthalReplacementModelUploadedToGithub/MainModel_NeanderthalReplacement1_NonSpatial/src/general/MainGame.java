
package general;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import spawning.unused_BirthDeathProcessor;
import spawning.unused_OffSpringCalculator;

public class MainGame {
	
	protected int timeStep;
	ParamConfiguration conf;
	FileWriter writer1; FileWriter writer2; 
	private PrintWriter out1; private PrintWriter out2; 
	
	public MainGame(ParamConfiguration conf) throws Exception
	{
		this.conf = conf;
		this.timeStep = 1;
		writer1 = new FileWriter(conf.outdir + "World.txt");
		out1 = new PrintWriter(writer1);
		writer2 = new FileWriter(conf.outdir + "Params.txt");
		out2 = new PrintWriter(writer2);
	}

	public void run() throws IOException
	{
		while (!this.isGameOver())
		{
			this.playRound();			
			this.collectstats();
			this.advanceTimeStep();
			System.out.println("================Just finished time step "+(this.timeStep-1)+" ==================");
		}
		System.out.println("Game Over!");
		writer1.close(); writer2.close();
	}
	
	protected void playRound() throws IOException {
		// choose mate => calculate kids => calculate and update condition for next year
		//this.mating();
		//offspringpool = offspcalc.CreateOffspringGeneration(); //also updates the parents' condition
		

		if (true) {
			//population = bdprocessor.KillAndFill(population, offspringpool);
		}
	}
	
	private void advanceTimeStep() {
		this.timeStep++; 
	}
	
	protected boolean isGameOver() throws IOException {
		// checking if one species took over or the number of time steps is up.
/*
		boolean fixation = true;
		String firststrat = population.get(0).getMyStrategy();
		for (int i=0;i<population.size();i++) {
			String currstrat = population.get(i).getMyStrategy();
			if (!(currstrat.equals(firststrat))) {fixation = false; break;}
		}
		
		if (conf.DidAStrategyFixLastGeneration) {
			System.out.println("Strategy <"+firststrat+"> has fixed in the population in the previous generation");
			System.out.println("generation is now: "+this.generation);
			GameIsOverStatCollection();
			FileWriter fixationTimes = new FileWriter("H:\\ClaudiaSchifferEffect_deletedFromLaptop\\TheClaudiaShifferEffect\\Claudia10\\output\\fixationTimes.txt",true);
			PrintWriter outfixations = new PrintWriter(fixationTimes);
			outfixations.println(firststrat + "       " +  this.generation);
			outfixations.close(); fixationTimes.close();
			return (true);
		}
		
		if (fixation) {
			System.out.println("Strategy <"+firststrat+"> has fixed in the population");
			System.out.println("generation is: "+this.generation);
			conf.DidAStrategyFixLastGeneration = true;
			//Scanner sc = new Scanner(System.in);while(!sc.nextLine().equals("")); //wait for "enter"
		}
		// checking whether the game is over because of running its full generation length:
		boolean gameisover = (this.generation > conf.maxgeneration);
		if (gameisover) GameIsOverStatCollection();	
		return (gameisover);
		*/
		return true;
	}

	public String toString() {
		return "timeStep number: " + timeStep;
	}
	
	public void collectstats() throws IOException {
		
	}
	
	public void GameIsOverStatCollection() throws IOException {
	}
}






