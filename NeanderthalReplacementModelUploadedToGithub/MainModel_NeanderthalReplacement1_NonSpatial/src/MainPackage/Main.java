package MainPackage;

import java.awt.font.NumericShaper;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.Scanner;

import org.apache.commons.io.FileUtils;

import general.MainGame;
import general.NumericSimulation;
import general.ParamConfiguration;

//9 Apr 2016: This whole code is based on the ClaudiaShiffer code, and I started making the
			// required changes and then realized that besides in order to know which specific lineages 
			// took over (i.e. are there offspring of more than one migration from the other island in the
			// fixing population or not), there's no actual need for a (long-running) agent-based simulation.
			// Thus, the mmain and its downstream calls are the basis that still needs some work for an agent
			// based version, if I'll need one, and the Numeric_simulation... is the one that I'm going to actually
			// use for now.

public class Main {
	
	public static int iterator;
	public static int modernWins = 0;
	public static int numberOfRuns = 500;
	
	public static void main (String[] args) throws Exception {
			
		for (iterator=0;iterator<numberOfRuns;iterator++) {
			System.out.println(iterator);
			NumericSimulation NS = new NumericSimulation();
			NS.Numeric_simulation_not_agent_based(iterator);
			if (NS.didModernsWin) {modernWins++;}
			//mmain(args);
		}
		ParamConfiguration pc = new ParamConfiguration(-1); // only for the mytime variable used below... :)
		File dir = new File("output");
        File newName = new File("output"+pc.mytime);
        if (dir.isDirectory() ) {dir.renameTo(newName);}
		System.out.println("number of Modern fixations: " +  (double)modernWins/(double)numberOfRuns);
		
	}
	
	/*
	public static void mmain(String[] args) throws Exception {
		
		ParamConfiguration conf = new ParamConfiguration(iterator);
		if (iterator<10) {
			// Run with some parameter setting
			//conf.matingtype = "getwhatyouwant";
		} else if (iterator<20) {
			}// Run with some other parameter setting		
		MainGame world_realization = new MainGame(conf);
		world_realization.run();
	}*/
	
}

//Scanner sc = new Scanner(System.in);while(!sc.nextLine().equals("")); //wait for "enter"
