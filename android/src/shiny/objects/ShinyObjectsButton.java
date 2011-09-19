/**
* Appcelerator Titanium Mobile
* Copyright (c) 2009-2010 by Appcelerator, Inc. All Rights Reserved.
* Licensed under the terms of the Apache Public License
* Please see the LICENSE included with this distribution for details.
*/
package shiny.objects;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.titanium.TiC;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.titanium.util.Log;
import org.appcelerator.titanium.util.TiConfig;
import org.appcelerator.titanium.util.TiConvert;
import org.appcelerator.titanium.util.TiUIHelper;
import org.appcelerator.titanium.view.TiUIView;

import android.graphics.Color;
import android.graphics.LinearGradient;
import android.graphics.Paint.Style;
import android.graphics.Shader;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.LayerDrawable;
import android.graphics.drawable.PaintDrawable;
import android.graphics.drawable.ShapeDrawable;
import android.graphics.drawable.StateListDrawable;
import android.graphics.drawable.shapes.RoundRectShape;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;

public class ShinyObjectsButton extends TiUIView
{
	private static final String LCAT = "ShinyObjectsButton";
	private static final boolean DBG = TiConfig.LOGD;
	//private static final boolean DBG = true;
	
	private float borderRadius;
	private String backgroundColor = "";
	private String borderColor = "";
	private int borderWidth = 1;
	
	public ShinyObjectsButton(final TiViewProxy proxy) 
	{
		super(proxy);
		if (DBG) 
		{
			Log.d(LCAT, "Creating a shiny button");
		}
		Button btn = new Button(proxy.getContext());
		btn.setPadding(8, 0, 8, 0);
		btn.setGravity(Gravity.CENTER);
		setNativeView(btn);
	}
	
	@Override
	public void processProperties(KrollDict d)
	{
		super.processProperties(d);

		// border radius
		if (d.containsKey(TiC.PROPERTY_BORDER_RADIUS))
		{
			borderRadius = d.getDouble(TiC.PROPERTY_BORDER_RADIUS).floatValue();
		}
		else
		{
			borderRadius = 5.0f;
			d.put(TiC.PROPERTY_BORDER_RADIUS, borderRadius);
		}
		// background color
		if (d.containsKey(TiC.PROPERTY_BACKGROUND_COLOR))
		{
			backgroundColor = d.getString(TiC.PROPERTY_BACKGROUND_COLOR);
		}
		else
		{
			backgroundColor = "#324f85";
			d.put(TiC.PROPERTY_BACKGROUND_COLOR, backgroundColor);
		}
		// border color
		if (d.containsKey(TiC.PROPERTY_BORDER_COLOR))
		{
			borderColor = d.getString(TiC.PROPERTY_BORDER_COLOR);
		}
		// border width
		if (d.containsKey(TiC.PROPERTY_BORDER_WIDTH))
		{
			borderWidth = d.getInt(TiC.PROPERTY_BORDER_WIDTH);
		}
		else
		{
			borderWidth = 1;
			d.put(TiC.PROPERTY_BORDER_WIDTH, borderWidth);
		}
		
		Button btn = (Button)getNativeView();
		/*
		if (d.containsKey(TiC.PROPERTY_IMAGE)) 
		{
			Object value = d.get(TiC.PROPERTY_IMAGE);
			if (value instanceof String) 
			{
				try 
				{
					String url = getProxy().getTiContext().resolveUrl(null, (String)value);
					TiBaseFile file = TiFileFactory.createTitaniumFile(getProxy().getTiContext(), new String[] { url }, false);
					Bitmap bitmap = TiUIHelper.createBitmap(file.getInputStream());

					btn.setBackgroundDrawable(new BitmapDrawable(bitmap));
				} 
				catch (IOException e) 
				{
					Log.e(LCAT, "Error setting button image", e);
				}
			}
		}
		*/
		if (d.containsKey(TiC.PROPERTY_TITLE)) 
		{
			btn.setText(d.getString(TiC.PROPERTY_TITLE));
		}
		if (d.containsKey(TiC.PROPERTY_COLOR)) 
		{
			btn.setTextColor(TiConvert.toColor(d, TiC.PROPERTY_COLOR));
		}
		if (d.containsKey(TiC.PROPERTY_FONT)) 
		{
			TiUIHelper.styleText(btn, d.getKrollDict(TiC.PROPERTY_FONT));
		}
		if (d.containsKey(TiC.PROPERTY_TEXT_ALIGN)) 
		{
			String textAlign = d.getString(TiC.PROPERTY_TEXT_ALIGN);
			TiUIHelper.setAlignment(btn, textAlign, null);
		}
		if (d.containsKey(TiC.PROPERTY_VERTICAL_ALIGN)) 
		{
			String verticalAlign = d.getString(TiC.PROPERTY_VERTICAL_ALIGN);
			TiUIHelper.setAlignment(btn, null, verticalAlign);
		}
		initLayers();
		setNativeView(btn);
		btn.invalidate();
	}

	@Override
	public void propertyChanged(String key, Object oldValue, Object newValue, KrollProxy proxy)
	{
		if (DBG) 
		{
			Log.d(LCAT, "Property: " + key + " old: " + oldValue + " new: " + newValue);
		}
		Button btn = (Button)getNativeView();
		if (key.equals(TiC.PROPERTY_TITLE)) 
		{
			btn.setText((String) newValue);
		} 
		else if (key.equals(TiC.PROPERTY_COLOR)) 
		{
			btn.setTextColor(TiConvert.toColor(TiConvert.toString(newValue)));
		} 
		else if (key.equals(TiC.PROPERTY_FONT)) 
		{
			TiUIHelper.styleText(btn, (KrollDict) newValue);
		} 
		else if (key.equals(TiC.PROPERTY_TEXT_ALIGN)) 
		{
			TiUIHelper.setAlignment(btn, TiConvert.toString(newValue), null);
			btn.requestLayout();
		} 
		else if (key.equals(TiC.PROPERTY_VERTICAL_ALIGN)) 
		{
			TiUIHelper.setAlignment(btn, null, TiConvert.toString(newValue));
			btn.requestLayout();
		} 
		else 
		{
			super.propertyChanged(key, oldValue, newValue, proxy);
		}
	}
    
	@Override
	public void setOpacity(float opacity) 
	{
		TiUIHelper.setPaintOpacity(((Button)getNativeView()).getPaint(), opacity);
		super.setOpacity(opacity);
	}

	@Override
	public void clearOpacity(View view) 
	{
		super.clearOpacity(view);
		((Button)getNativeView()).getPaint().setColorFilter(null);
	}
	
	private int getColor(String colorString, float opacity)
	{
		int color;
		try
		{
			color = Color.parseColor(colorString);
		}
		catch (Exception ex)
		{
			Log.d(LCAT, "Unsupported color: " + colorString);
			color = Color.parseColor("#324f85");
		}
		/*
		if (color == -1)
		{
			try 
			{
				int resid = TiRHelper.getResource("color." + colorString.toLowerCase());
				if (resid != 0) 
				{
					return getTiContext().getAndroidContext().getString(resid);
				} 
				else 
				{
					color = Color.parseColor("#324f85");
				}
			}
			catch (TiRHelper.ResourceNotFoundException e) 
			{
				color = Color.parseColor("#324f85");
			}
			catch (Exception e) 
			{
				color = Color.parseColor("#324f85");
			}
		}
		*/
		if (opacity < 1.0)
		{
			int iOpacity = (int)(255 * opacity);
			color = iOpacity << 24 | color;
		}
		return color;
	}
	
	private void initLayers()
	{
		final Button btn = (Button)getNativeView();
		if (btn != null)
		{
			ShapeDrawable.ShaderFactory sf = new ShapeDrawable.ShaderFactory() 
			{
			    @Override
			    public Shader resize(int width, int height) 
			    {
			    	// create a transparent gradient to overlay as the shine layer
			        LinearGradient lg = new LinearGradient(0, 0, 0, btn.getHeight(),
			            new int[] 
			            { 
			                0x73ffffff,		// color with white 100%, alpha 0.45 
			                0x33ffffff, 	// color with white 100%, alpha 0.2
			                0x33bfbfbf, 	// color with white 75%,  alpha 0.2
			                0x33676767,		// color with white 40%,  alpha 0.2
			                0x66d9d9d9		// color with white 85%,  alpha 0.4
			            },
			            new float[] 
			            {
			        		0.0f, 
			        		0.5f, 
			        		0.5f,
			        		0.8f,
			        		1.0f
			        	},
			            Shader.TileMode.REPEAT);
			         return lg;
			    }
			};
			int color = getColor(backgroundColor, 1.0f);
			float[] roundedCorner = new float[] { borderRadius, borderRadius, borderRadius, borderRadius, borderRadius, borderRadius, borderRadius, borderRadius };
			Log.d(LCAT, "Border Radius: " + Float.toString(borderRadius));

			// add the bottom (normal) layer
			PaintDrawable normal = new PaintDrawable();
			normal.setShape(new RoundRectShape(roundedCorner, null, roundedCorner));
			normal.getPaint().setColor(color);
			
			// add the top (shine) layer
			PaintDrawable shine = new PaintDrawable();
			shine.setShape(new RoundRectShape(roundedCorner, null, roundedCorner));
			shine.setShaderFactory(sf);

			int numLayers = 3;
			PaintDrawable border = null;
			// add the border layer
			if (borderColor.length() > 0)
			{
				color = getColor(borderColor, 0.2f);
			}
			else
			{
				color = getColor("gray", 0.2f);
			}
			border = new PaintDrawable();
			border.setShape(new RoundRectShape(roundedCorner, null, roundedCorner));
			border.getPaint().setColor(color);
			border.getPaint().setStyle(Style.STROKE);
			border.getPaint().setStrokeWidth(borderWidth);
			
			// add the highlight layer
			PaintDrawable highlight = new PaintDrawable();
			highlight.setShape(new RoundRectShape(roundedCorner, null, roundedCorner));
			highlight.getPaint().setColor(Color.parseColor("#404040"));		// 0.25 red, 0.25 blue, 0.25 green

			// layer the bottom and shine
			int layer = 0;
			Drawable[] drawNormal = new Drawable[numLayers];
			drawNormal[layer++] = (Drawable)normal;
			if (numLayers == 3)
			{
				drawNormal[layer++] = (Drawable)border;
			}
			drawNormal[layer++] = (Drawable)shine;
			LayerDrawable normalState = new LayerDrawable(drawNormal);

			// layer the highlight and shine layer for pressed state
			layer = 0;
			Drawable[] drawHighlight = new Drawable[numLayers];
			drawHighlight[layer++] = (Drawable)highlight;
			if (numLayers == 3)
			{
				drawHighlight[layer++] = (Drawable)border;				
			}
			drawHighlight[layer++] = (Drawable)shine;
			LayerDrawable highlightState = new LayerDrawable(drawHighlight);
			
			// Create a state list
			StateListDrawable stateList = new StateListDrawable();
			stateList.addState(new int[] {-android.R.attr.state_pressed}, normalState);		// not pressed (negative)
			stateList.addState(new int[] {android.R.attr.state_pressed}, highlightState);	//pressed
			btn.setBackgroundDrawable(stateList);
		}
		return;
	}
}