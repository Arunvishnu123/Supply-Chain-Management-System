package MAS_SCMS_Style;

import javax.swing.BoxLayout;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.SwingConstants;
import mAS_SCMS.Context_Creator;
import repast.simphony.engine.environment.RunEnvironment;
import repast.simphony.parameter.Parameters;
import repast.simphony.userpanel.ui.UserPanelCreator;
import mAS_SCMS.Customer_Agent;
import java.awt.*;



public class User_Panel implements UserPanelCreator {

	@Override
	public JPanel createPanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
		JLabel label_1 = new JLabel("Supply Chain Management System",SwingConstants.CENTER);
	    label_1.setFont(new Font("Ariel", Font.BOLD, 12));
		panel.add(label_1,BorderLayout.CENTER);
		
		
		
		Context_Creator tt = new Context_Creator();
		Customer_Agent tt1 = new Customer_Agent();
		Parameters p = RunEnvironment.getInstance().getParameters();
		int customer_Num = (Integer)p.getValue("Customer_Count");
		int retailer_Num = (Integer)p.getValue("Retailer_Count");
		int distributor_Num = (Integer)p.getValue("Distributor_Count");
		int manufacture_Num = (Integer)p.getValue("Manufacture_Count");
		int raw_Materials_Supplier_Num = (Integer)p.getValue("Raw_Material_Count");
		
		JLabel Customer_Count_Display = new JLabel("Total Number of Customers - "+customer_Num,
		        SwingConstants.CENTER);
		panel.add(Customer_Count_Display);
		
		JLabel Retailer_Count_Display = new JLabel("Total Number of Retailers - "+retailer_Num,
		        SwingConstants.CENTER);
		panel.add(Retailer_Count_Display);
		
		JLabel Distributor_Count_Display = new JLabel("Total Number of Distributors - "+distributor_Num,
		        SwingConstants.CENTER);
		panel.add(Distributor_Count_Display);
		
		JLabel manufacture_Count_Display = new JLabel("Total Number of Manufactures - "+manufacture_Num,
		        SwingConstants.CENTER);
		panel.add(manufacture_Count_Display);
		
		JLabel raw_Materials_Count_Display = new JLabel("Total Number of Raw Materials Suppliers - "+raw_Materials_Supplier_Num,
		        SwingConstants.CENTER);
		panel.add(raw_Materials_Count_Display);
		return panel;
	}

}
