package mAS_SCMS;

import repast.simphony.context.Context;
import repast.simphony.engine.environment.RunEnvironment;
import repast.simphony.parameter.Parameters;
import repast.simphony.query.PropertyLessThanEquals;
import repast.simphony.query.Query;
import repast.simphony.random.RandomHelper;
import repast.simphony.space.graph.Network;
import repast.simphony.space.grid.Grid;
import repast.simphony.space.grid.GridPoint;
import repast.simphony.util.ContextUtils;

public class Retailer_Agent extends Base_Agent {

		public Retailer_Agent(){
	
	}

	@Override
	public void step() {
		
		Context context = ContextUtils.getContext(this);
		
		}
	
	 public int getRetailer_Current_Quantity() {
	      return  retailer_current_Storage_Quantity ;
   }

}