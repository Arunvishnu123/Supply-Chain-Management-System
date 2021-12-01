package mAS_SCMS;

import repast.simphony.context.Context;
import repast.simphony.context.space.continuous.ContinuousSpaceFactoryFinder;
import repast.simphony.context.space.graph.NetworkBuilder;
import repast.simphony.context.space.grid.GridFactoryFinder;
import repast.simphony.dataLoader.ContextBuilder;
import repast.simphony.engine.environment.RunEnvironment;
import repast.simphony.parameter.Parameters;
import repast.simphony.space.continuous.RandomCartesianAdder;
import repast.simphony.space.grid.GridBuilderParameters;
import repast.simphony.space.grid.RandomGridAdder;
import repast.simphony.valueLayer.GridValueLayer;
import repast.simphony.space.graph.Network;


public class Context_Creator implements ContextBuilder<Base_Agent> {

	public Context<Base_Agent> build(Context<Base_Agent> context) {
		
		
		
		context.setId("Supply Chain Management System");
		int xdim = 50;  
		int ydim = 50;  
		
		GridFactoryFinder.createGridFactory(null).createGrid("Simple Grid", context,
				new GridBuilderParameters<Base_Agent>(new repast.simphony.space.grid.WrapAroundBorders(),
						new RandomGridAdder<Base_Agent>(), true, xdim, ydim));

		ContinuousSpaceFactoryFinder.createContinuousSpaceFactory(null)
		.createContinuousSpace("Continuous Space", context, new RandomCartesianAdder<Base_Agent>(),
				new repast.simphony.space.continuous.WrapAroundBorders(), xdim, ydim, 1);

		GridValueLayer vl = new GridValueLayer("Field", true, 
				new repast.simphony.space.grid.WrapAroundBorders(),xdim,ydim);
		context.addValueLayer(vl);
		
		
		NetworkBuilder<Base_Agent> netBuilder = new NetworkBuilder<Base_Agent>(
				"network", context, true);
		Network<Base_Agent> net = netBuilder.buildNetwork();
		
		
		
		Parameters p = RunEnvironment.getInstance().getParameters();
		int customer_Num = (Integer)p.getValue("Customer_Count");
		

		
		for (int i = 0; i < customer_Num; i++) {
			Customer_Agent customers = new Customer_Agent();            
			context.add(customers);                 
		}
	 
	    int retailer_Num = (Integer)p.getValue("Retailer_Count");
		for (int i = 0; i < retailer_Num; i++) {
			Retailer_Agent retailers = new Retailer_Agent();            
			context.add(retailers);                 
		}
	 
	    int Distributor_Num = (Integer)p.getValue("Distributor_Count");
			for (int i = 0; i <Distributor_Num; i++) {
				Distributor_Agent distributors = new Distributor_Agent();            
				context.add(distributors);                 
			}
		
		    int Manufacture_Num = (Integer)p.getValue("Manufacture_Count");
					for (int i = 0; i < Manufacture_Num; i++) {
						Manufacture_Agent Manufactures  = new Manufacture_Agent();            
						context.add( Manufactures);                 
					}
				
		   int Raw_Materials_Num = (Integer)p.getValue("Raw_Material_Count");
				   for (int i = 0; i < Raw_Materials_Num; i++) {
						Raw_Materials_Supplier_Agent RawMaterialsSuppliers  = new Raw_Materials_Supplier_Agent();            
						context.add( RawMaterialsSuppliers);                 
					}
					
		if (RunEnvironment.getInstance().isBatch()){
			
			double endAt = (Double)p.getValue("runlength");     
			RunEnvironment.getInstance().endAt(endAt);
		}
		return context;                       
	}
}