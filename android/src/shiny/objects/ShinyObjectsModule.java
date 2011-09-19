package shiny.objects;

import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;

import org.appcelerator.titanium.TiContext;
//import org.appcelerator.titanium.util.Log;
//import org.appcelerator.titanium.util.TiConfig;

@Kroll.module(name="ShinyObjects", id="shiny.objects")
public class ShinyObjectsModule extends KrollModule
{

	// Standard Debugging variables
	//private static final String LCAT = "ShinyObjectsModule";
	//private static final boolean DBG = TiConfig.LOGD;

	// You can define constants with @Kroll.constant, for example:
	// @Kroll.constant public static final String EXTERNAL_NAME = value;
	
	public ShinyObjectsModule(TiContext tiContext)
	{
		super(tiContext);
	}

	// Methods
	//@Kroll.method
	//public String example() {
	//	Log.d(LCAT, "example called");
	//	return "hello world";
	//}
	
	// Properties
	//@Kroll.getProperty
	//public String getExampleProp() {
	//	Log.d(LCAT, "get example property");
	//	return "hello world";
	//}
	
	
	//@Kroll.setProperty
	//public void setExampleProp(String value) {
	//	Log.d(LCAT, "set example property: " + value);
	//}
}