package general;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.apache.commons.io.FileUtils;

public class ParamConfiguration {
	public String workingdir;
	public int deme1_size = 50; // Europe
	public int deme2_size = 100; // Africa
	public double m1 = 0; // outgoing from Europe
	public double m2 = 0.0001; // outgoing migration from africa
	//public Population deme1; // 
	//public Population deme2;
	//public ArrayList<Agent> deme1_pop;
	//public ArrayList<Agent> deme2_pop;
	public int maxTimeStep = 100000000;
	public int everyHowManyRunsToPrintOutStats = 1; // 1 would mean always.
	
	public Random randomizer = new Random();
	public String outdir;
	
	// from here, globals (and not run params):
	public boolean DidAStrategyFixLastGeneration = false;
	public static String rootOfOutput;
	public FileWriter writer1; 
	public PrintWriter out1;
	public FileWriter writer2; 
	public PrintWriter out2;
	public FileWriter writer3; 
	public PrintWriter out3;
	public int NumberOfModernsEstablishments = 0;
	public int NumberOfNeanderthalsEstablishments = 0;
	public int NumOfModernEstsSinceLastCleanSlate = 0; // tracking how many establishments occurred into 
	// deme 1; I zero this every time all Moderns are lost from deme 1, so that I end up with the
	// number of establishments that could have contributed to the population that eventually fixes.
	// This is applied only with regard to migration into Europe and only when migration in the other direction is zero.
	//public int NumOfNeanderthalEstsWhileNeanderthalsAlreadySegregatingSinceLastCleanSlate = 0;
	public static String mytime;
	
	
	public ParamConfiguration(int iterationNum) throws IOException {
		super();
		workingdir = produceThisSimulationDirectory(iterationNum);
		this.outdir = this.workingdir; // + "output\\";
		writer1 = new FileWriter(this.outdir + "ChangeThroughTime.txt");
		out1 = new PrintWriter(writer1);
		writer2 = new FileWriter(this.rootOfOutput + "ChangeThroughTime_labels.txt", true);
		out2 = new PrintWriter(writer2);
		writer3 = new FileWriter(this.rootOfOutput + "FinalResultsOfAllRuns_d1Size_"+deme1_size+"d2Size_"+deme2_size+"m1"
				+m1+"m2"+m2+".txt", true);
		out3 = new PrintWriter(writer3);
		//this.deme1 = new Population(deme1_size, 1, this);
		//this.deme2 = new Population(deme2_size, 2, this);
	}
		
	public static String produceThisSimulationDirectory(int iterNum) throws IOException {
		// I'd like to have all the output of a certain run in one directory, that won't be overrun by the
		// next run, so:
		Date date = Calendar.getInstance().getTime();
		mytime = date.toString();
		//System.out.println(mytime);
		mytime = mytime.replaceAll("^.+? ",""); mytime=mytime.replaceAll("GMT+.+","");
		mytime = mytime.replaceAll(" ","");mytime = mytime.replaceAll(":","");
		//mytime = mytime.substring(0,mytime.length()-2); //this throws away the seconds.
		mytime = mytime.split("PDT", 2)[0];
		// to here - preparing name of run
		
		String truncationStr = "SomeRunParam";
		String outdirName = "output"+File.separator+"run"+iterNum+"_trunc" + truncationStr + "_" + mytime+File.separator+File.separator;
		//String outdirName = "trunc" + truncationStr + "_" + mytime+File.separator+File.separator;
		
		File T_outdirectory1 = new File("output");
		if (!T_outdirectory1.exists()) {
			new File("output").mkdir();
		}
		
		File T_outdirectory = new File(outdirName);
		if (!T_outdirectory.exists()) {
			new File(outdirName).mkdir();
		}
		
		// copying the src of each run, so that I'll know exactly the params of each run:
		String sourcecodedirectory = outdirName.replaceAll("output.+", "");
		String fullsourcecodeddirectory = sourcecodedirectory + "src";
		//System.out.println(fullsourcecodeddirectory);
		boolean fullsourceexists = (new File(fullsourcecodeddirectory)).exists();
		if (fullsourceexists) {
			//FileUtils.copyDirectory(new File(fullsourcecodeddirectory), new File(outdirName+"src_forThisRun"));
			//System.out.println(outdirName);
			rootOfOutput = outdirName.replaceAll("output.+", "output"+File.separator);
			FileUtils.copyDirectory(new File(fullsourcecodeddirectory), new File(rootOfOutput+"src_forThisRun"));
		}
		return outdirName;
	}
}
