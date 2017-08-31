package general;

import java.io.File;
import java.util.Scanner;

import org.apache.commons.io.FileUtils;


public class NumericSimulation {

	public boolean didModernsWin = false;
	public boolean po;
	
	public void Numeric_simulation_not_agent_based (int iterator) throws Exception {
		ParamConfiguration conf = new ParamConfiguration(iterator);
		int ehop = conf.everyHowManyRunsToPrintOutStats;
		if (iterator==1) {conf.out2.print("ModernsInDeme1 ModernsInDeme2 WhereCullingOccurred DidMigrationHappen WhoMigrated whoWasCulled CouldEstablishmentOccur");}
		// Note that the last thing only checks if establishment may have occurred - one can actually infer if that happened using that combined
		// with other data in the line. see implementation itself  details.
		int deme1Size = conf.deme1_size; int deme2Size = conf.deme2_size;
		double m1 = conf.m1; double m2 = conf.m2;
		if (m1*(double)deme1Size>0.1 || m2*(double)deme2Size>0.1) {
			System.out.println("note that the migration rates are greater than the model allows!");
			//Scanner sc = new Scanner(System.in);while(!sc.nextLine().equals("")); //wait for "enter"
		}
		// initialization:
		// a deme is simply the number of Moderns' bands in it (the overall number remains constant). 
		int deme1 = 0; int deme2 =  deme2Size;
		boolean fixed = false; boolean timedout = false;
		int timestep = 0;
		po = (iterator%ehop==0);

		// The actual simulation:
		while (!fixed && !timedout) {
			if (po) {conf.out1.print(deme1 + "\t" + deme2);}
			timestep++;
			// Culling a band randomly:
			// Since there's no spatial order and no individual-band identity, I just want to decide in one
			// draw which band was culled: both in which deme and of which species. For simplicity, the Modern
			// bands are always the first X bands in every deme.
			int candidates;
			int culledInd = 1+conf.randomizer.nextInt(deme1Size+deme2Size);
			if (culledInd<=deme1Size) { // culling in deme 1
				if (po) {conf.out1.print("\t"+1);}
				deme1 = RealizeCullingandItsAftermath(culledInd, deme1, deme1Size, deme2, deme2Size, m2, conf);
			} else { // the cullling was in deme 2
				culledInd = culledInd-deme1Size;
				if (po) {conf.out1.print("\t"+2);}
				deme2 = RealizeCullingandItsAftermath(culledInd, deme2, deme2Size, deme1, deme1Size, m1, conf);
			}
			if (deme1==0) {conf.NumOfModernEstsSinceLastCleanSlate = 0;}
			if ((timestep+1)>conf.maxTimeStep) {timedout=true; System.out.println("timed out!");}
			if ((deme1+deme2==0)||(deme1+deme2==deme1Size+deme2Size)) {
				fixed=true;
				if (deme1+deme2==deme1Size+deme2Size) {didModernsWin = true;}
			}
			if (fixed||timedout) {
				conf.out3.println(timestep + "\t" + deme1 + "\t" + deme2 + "\t" + conf.NumberOfModernsEstablishments + "\t" + 
						conf.NumberOfNeanderthalsEstablishments + "\t" + conf.NumOfModernEstsSinceLastCleanSlate); 
			}
		}
		conf.out1.close(); conf.out2.close(); conf.out3.close();
		File outputfileAndDirectory = new File (conf.outdir + "ChangeThroughTime.txt");
		File outputdirectory = new File (conf.outdir);
		//System.out.println(outputfileAndDirectory.getName() + "length is " + outputfileAndDirectory.length());
		//Scanner sc = new Scanner(System.in);while(!sc.nextLine().equals("")); //wait for "enter"
        if (outputfileAndDirectory.length()==0) {FileUtils.deleteDirectory(outputdirectory);;}
	}
	
	public int RealizeCullingandItsAftermath (int culledInd, int thisDeme, int thisDemeSize, int otherDeme, int otherDemeSize, double m_incoming, ParamConfiguration conf) {
				
		// migration:
		int candidatePoolSize = 0; int modernsAmongCandidates = 0; boolean NeanderthalMigrant=false; boolean ModernMigrant=false;
		boolean migrationOccurenceFromOtherDeme = (conf.randomizer.nextDouble()<m_incoming*(double)otherDemeSize) ;				
		if (migrationOccurenceFromOtherDeme) { // migration has occurred
			if (po) {conf.out1.print("\t"+1);}
			candidatePoolSize = thisDemeSize; // including migrant, but excluding the culled band.
			if (1+conf.randomizer.nextInt(otherDemeSize)<=otherDeme) {// the migrant is a Modern
				ModernMigrant = true; if (po) {conf.out1.print("\t"+2);}
				modernsAmongCandidates = thisDeme + 1; // before correction for whether the culled is M/N
			} else { // the migrant is Neanderthal
				NeanderthalMigrant = true; if (po) {conf.out1.print("\t"+1);}
				modernsAmongCandidates = thisDeme; // before correction for whether the culled is M/N
			}
		} else { // no migration occurred
			if (po) {conf.out1.print("\t"+0+"\t"+0);}
			candidatePoolSize = thisDemeSize-1; modernsAmongCandidates = thisDeme; // before correction for whether the culled is M/N
		}
		// finding out who died:
		if (culledInd<=thisDeme) { // A modern band has died
			if (po) {conf.out1.print("\t"+2);}
			modernsAmongCandidates = modernsAmongCandidates - 1;
			thisDeme = thisDeme - 1;
		} else {if (po) {conf.out1.print("\t"+1);}}
		// replacement:
		int chosenForReplacement = 1+conf.randomizer.nextInt(candidatePoolSize);
		if (chosenForReplacement<=modernsAmongCandidates) {thisDeme++;} // no need for an else, as the default is that N are more in that case.
		if (((chosenForReplacement==modernsAmongCandidates)&&(ModernMigrant))||((chosenForReplacement==candidatePoolSize)&&(NeanderthalMigrant))) {
			if ((chosenForReplacement==modernsAmongCandidates)&&(ModernMigrant)) {
				if (po) {conf.out1.print("\t"+2);} // a modern migrant established.
				conf.NumberOfModernsEstablishments++;
				// tracking the number of establishments that may have contributed to eventual fixing population:
				if (conf.m1==0) {// migrants can only go into Europe, They are always Moderns
					// This condition means that if the thread reaches here, thisDeme is referring to Europe.
					if (thisDeme>0) {
						conf.NumOfModernEstsSinceLastCleanSlate++;
					}
				}
			} else { // a Neanderthal migrant established
				if (po) {conf.out1.print("\t"+1);}
				conf.NumberOfNeanderthalsEstablishments++;
			}
			
		} else {if (po) {conf.out1.print("\t"+0);}}
		if (po) {conf.out1.print("\t"+conf.NumOfModernEstsSinceLastCleanSlate);}
		if (po) {conf.out1.println();}
		return (thisDeme);
	}
	

	
}
