package general;

import java.util.Random;

public class Agent {
	private static int agentsCounter = 0;
	private final int id;
	private int species;
	private int parentID;
	private ParamConfiguration conf;
	
	public Agent(int speciesIdentity, int parentID, ParamConfiguration conf)
	{
		this.conf = conf;
		this.species = speciesIdentity;
		this.id = ++agentsCounter;
		this.parentID = parentID;
	}
	
	public int getId() {
		return this.id;
	}

	public int getSpeciesIdentity() {
		return this.species;
	}
	
	public int getParentID() {
		if (this.parentID==-1) { // this is a first generation, counts as its own parent.
			return this.id;
		} else {return this.parentID;}
	}
	
	public String toString() {
		return id + "=>" + this.species;
	}
}
