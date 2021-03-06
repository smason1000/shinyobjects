/**
 * This file was auto-generated by the Titanium Module SDK helper for Android
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2010 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 *
 */
package shiny.objects;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.TiContext;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.titanium.view.TiUIView;
import org.appcelerator.titanium.TiC;

import android.app.Activity;

@Kroll.proxy(creatableInModule=ShinyObjectsModule.class)
public class ButtonProxy extends TiViewProxy
{
	//private float borderRadius;

	public ButtonProxy(TiContext tiContext)
	{
		super(tiContext);
	}

	@Override
	protected KrollDict getLangConversionTable() 
	{
		KrollDict table = new KrollDict();
		table.put("title","titleid");
		return table;
	}

	// Handle creation options
	@Override
	public void handleCreationDict(KrollDict options)
	{
		super.handleCreationDict(options);
	}
		
	@Override
	protected KrollDict handleStyleOptions(KrollDict options)
	{
		super.handleStyleOptions(options);
		
		// default border radius
		if (!options.containsKey(TiC.PROPERTY_BORDER_RADIUS))
		{
			options.put(TiC.PROPERTY_BORDER_RADIUS, (float)4.0);
		}	    
	    return options;
	}
	
	@Override
	public TiUIView createView(Activity activity)
	{
		ShinyObjectsButton btn = new ShinyObjectsButton(this);
		return btn;
	}
}