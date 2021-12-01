package mAS_SCMS;

import repast.simphony.annotate.AgentAnnot;
import repast.simphony.context.Context;
import repast.simphony.engine.environment.RunEnvironment;
import repast.simphony.engine.schedule.ScheduledMethod;
import repast.simphony.random.RandomHelper;
import repast.simphony.space.continuous.ContinuousSpace;
import repast.simphony.space.continuous.NdPoint;
import repast.simphony.space.grid.Grid;
import repast.simphony.util.ContextUtils;

/**
 * SimpleAgent is the parent class of all other agents.
 * 
 */

@AgentAnnot(displayName = "Agent")
public class Base_Agent {
	protected int  total_rawmaterial_1_Quantity;
	protected int  total_production;       // The energy level of the agent
	protected int  total_rawmaterial_2_Quantity;
	protected double heading;// The heading in degrees of the agent
	protected int distributor_Current_Quantity ;
	protected int retailer_current_Storage_Quantity;
	
	
	@ScheduledMethod(start = 1, interval = 10, shuffle=true)
	public void step() {
		// Override by subclasses
	}

	// Move the agent
	public void move() {
		// The agent is aware of its location in the continuous space and

		// Get the context in which the agent is residing
		Context context = ContextUtils.getContext(this);

		// Get the patch grid from the context
		Grid patch = (Grid) context.getProjection("Simple Grid");

		// Get the continuous space from the context
		ContinuousSpace space = (ContinuousSpace) context.getProjection("Continuous Space");

		NdPoint point = space.getLocation(this);  // Get the agent's point coordinate from the space

		double x = point.getX();			// The x coordinate on the 2D continuous space
		double y = point.getY();      // The y coordinate on the 2D continuous space

		// Randomly change the current heading plus or minus 50 degrees
		double sgn = RandomHelper.nextDoubleFromTo(-0.5, 0.5);       // a value between -0.5 and 0.5
		if (sgn > 0)
			heading = heading + RandomHelper.nextDoubleFromTo(0, 50);
		else			
			heading = heading - RandomHelper.nextDoubleFromTo(0, 50);

		// Move the agent on the space by one unit according to its new heading
		space.moveByVector(this, 1, Math.toRadians(heading),0,0);

		// Move the agent to its new patch (note the patch may not actually change)
		patch.moveTo(this, (int)x, (int)y);	
	}
	public int manufactureProducts(int production_Count) {
		return production_Count + 1;
	}
	public int raw_Materials_1(int raw_Material_Count_1) {
		return  raw_Material_Count_1 - 1;
	}
	
	public int raw_Materials_2(int raw_Material_Count_2) {
		return  raw_Material_Count_2 - 1;
	}
    
}
