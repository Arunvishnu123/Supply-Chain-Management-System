package mAS_SCMS;

import java.util.ArrayList;
import java.util.List;

import repast.simphony.context.Context;
import repast.simphony.engine.environment.RunEnvironment;
import repast.simphony.parameter.Parameters;
import repast.simphony.query.PropertyLessThan;
import repast.simphony.query.PropertyLessThanEquals;
import repast.simphony.query.Query;
import repast.simphony.random.RandomHelper;
import repast.simphony.space.graph.Network;
import repast.simphony.space.grid.Grid;
import repast.simphony.space.grid.GridPoint;
import repast.simphony.util.ContextUtils;


@SuppressWarnings("deprecation")
public class Raw_Materials_Supplier_Agent extends Base_Agent {

	public Raw_Materials_Supplier_Agent(){
	
	  }

	@Override
	public void step() {
	
		Context context = ContextUtils.getContext(this);
		
		//Check the raw materials availability and send the raw materials if not available 
   	 if((total_rawmaterial_1_Quantity < 20) || (total_rawmaterial_2_Quantity < 20))
    	 {
    		
    		
 			@SuppressWarnings("deprecation")
 			Query<Object> query = new PropertyLessThan<Object>(context,"total_rawmaterial_1_Quantity", 400);
 			for (Object v : query.query()) {
 			   Manufacture_Agent manufactures = (Manufacture_Agent)v;
    		 
    		Network<Base_Agent> net = (Network<Base_Agent>)context.getProjection("network");
 			net.addEdge(new Network_Creator(this,manufactures));
 			
    		 }
    		 
 			if (total_rawmaterial_1_Quantity < 10) {
 			total_rawmaterial_1_Quantity = total_rawmaterial_1_Quantity + 100 ;
 			}
 			if(total_rawmaterial_2_Quantity < 10) {
 				total_rawmaterial_2_Quantity = total_rawmaterial_2_Quantity + 100 ;	
 			}
    		 } else {
    			 Network<Base_Agent> net = (Network<Base_Agent>)context.getProjection("network");
    			   net.removeEdges();
    		 }

	}

}