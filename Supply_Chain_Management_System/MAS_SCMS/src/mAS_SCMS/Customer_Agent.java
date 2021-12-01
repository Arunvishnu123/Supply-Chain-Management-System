package mAS_SCMS;

import repast.simphony.context.Context;
import repast.simphony.engine.environment.RunEnvironment;
import repast.simphony.parameter.Parameters;
import repast.simphony.random.RandomHelper;
import repast.simphony.space.grid.Grid;
import repast.simphony.space.grid.GridPoint;
import repast.simphony.util.ContextUtils;
import repast.simphony.space.graph.Network;
import repast.simphony.ui.probe.ProbedProperty;

public class Customer_Agent extends Base_Agent {
	public int rrr = 5;
	public Customer_Agent(){
		
		Parameters p = RunEnvironment.getInstance().getParameters();

	}

	@Override
	public void step() {
		Context context = ContextUtils.getContext(this);
		move();
		

		}



}