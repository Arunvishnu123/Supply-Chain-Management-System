package mAS_SCMS;

import repast.simphony.context.Context;
import repast.simphony.engine.environment.RunEnvironment;
import repast.simphony.parameter.Parameters;
import repast.simphony.query.PropertyLessThanEquals;
import repast.simphony.query.Query;
import repast.simphony.random.RandomHelper;
import repast.simphony.space.grid.Grid;
import repast.simphony.space.grid.GridPoint;
import repast.simphony.util.ContextUtils;
import repast.simphony.space.graph.Network;
import repast.simphony.space.graph.RepastEdge;
import java.util.List;
import java.util.ArrayList;

public class Manufacture_Agent extends Base_Agent {
	
	public Manufacture_Agent(){
	   
	}
	
    public  Manufacture_Agent(int total_production){
		
		}


	@Override
	public void step() {
		
		
		Context context = ContextUtils.getContext(this);
		Parameters para = RunEnvironment.getInstance().getParameters();
		int Manufacturing_Capacity  = (Integer)para.getValue("Manufacuturing_Capacity");
		
		//manufacture products
    	if (( total_rawmaterial_1_Quantity > 1) && ( total_rawmaterial_2_Quantity > 1) && (total_production < Manufacturing_Capacity))
    	{
         total_rawmaterial_1_Quantity = raw_Materials_1( total_rawmaterial_1_Quantity);
       	 total_rawmaterial_2_Quantity = raw_Materials_2(total_rawmaterial_2_Quantity);
    	 total_production = manufactureProducts(total_production);
    	 
    	}
    	
    	
    	
        int maximumDistributorlimit = (Integer)para.getValue("Distributor_Max_Stock_Limit");
		
	 if ( distributor_Current_Quantity <  maximumDistributorlimit )
		{
			
			@SuppressWarnings("deprecation")
			Query<Object> query = new PropertyLessThanEquals<Object>(context, "distributor_Current_Quantity", 50);
			for (Object o : query.query()) {
			   Distributor_Agent  Distributors = ( Distributor_Agent)o;
    		
    		Network<Base_Agent> net = (Network<Base_Agent>)context.getProjection("network");
 			net.addEdge(new Network_Creator(this,  Distributors ));
    		 }
			
			int distributor_send = maximumDistributorlimit -  distributor_Current_Quantity ; 
			distributor_Current_Quantity = distributor_Current_Quantity + distributor_send ;
			total_production = total_production - distributor_send ; 
			} 
	     else {
	       Network<Base_Agent> net = (Network<Base_Agent>)context.getProjection("network");
		   net.removeEdges();
	   }
	}
	
	public int getManufactureProducts() {
		return total_production;
	}
  
    public int getRawMaterials_1_Quantity() {
	      return total_rawmaterial_1_Quantity;
    }
    
    public int getRawMaterials_2_Quantity() {
	      return total_rawmaterial_2_Quantity;
  }
    	

}

		

