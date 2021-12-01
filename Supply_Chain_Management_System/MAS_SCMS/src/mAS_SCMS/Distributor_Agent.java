package mAS_SCMS;

import java.util.ArrayList;
import java.util.List;

import repast.simphony.context.Context;
import repast.simphony.engine.environment.RunEnvironment;
import repast.simphony.parameter.Parameters;
import repast.simphony.random.RandomHelper;
import repast.simphony.space.graph.Network;
import repast.simphony.space.grid.Grid;
import repast.simphony.space.grid.GridPoint;
import repast.simphony.util.ContextUtils;
import repast.simphony.query.*;

public class Distributor_Agent extends Base_Agent {

	public Distributor_Agent(){


	}

	@Override
	public void step() {
		
		Context context = ContextUtils.getContext(this);
		Parameters para = RunEnvironment.getInstance().getParameters();
		
		int maximumRetailerStorageLimit = (Integer)para.getValue("Retailer_Maximum_Capacity");
		 
		 if( retailer_current_Storage_Quantity < maximumRetailerStorageLimit ) {
				
				@SuppressWarnings("deprecation")
				Query<Object> query2 = new PropertyLessThanEquals<Object>(context, " retailer_current_Storage_Quantity", 10);
				for (Object o : query2.query()) {
				   Retailer_Agent  retailers = (Retailer_Agent)o;
	    		
	    		Network<Base_Agent> net = (Network<Base_Agent>)context.getProjection("network");
	 			net.addEdge(new Network_Creator(this,   retailers ));
	    		 }
				
				int retailer_send = maximumRetailerStorageLimit -  retailer_current_Storage_Quantity ; 
				 retailer_current_Storage_Quantity =  retailer_current_Storage_Quantity + retailer_send ;
				 distributor_Current_Quantity =distributor_Current_Quantity - retailer_send; 
				} 
		     else {
		       Network<Base_Agent> net = (Network<Base_Agent>)context.getProjection("network");
			   net.removeEdges();
		   }
		 }

	 
    public int getDistributor_Current_Quantity() {
	      return distributor_Current_Quantity ;
    }
}