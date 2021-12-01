package MAS_SCMS_Style;

import java.io.IOException;


import repast.simphony.visualizationOGL2D.DefaultStyleOGL2D;
import saf.v3d.scene.VSpatial;

public class Manufacture_Agent_Style extends DefaultStyleOGL2D {
	
	@Override
	public VSpatial getVSpatial(Object agent, VSpatial spatial) {
		
		String logoPath = "icons/test.png";
		

		try {
			spatial = shapeFactory.createImage(logoPath);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return spatial;
	}
	
	@Override
	public float getScale(Object object) {
		return 0.15f;
	}
}
