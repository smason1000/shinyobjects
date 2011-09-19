# shinyobjects Module

## Description

This module allows you to add shiny objects to your Appcelerator programs.

This release contains the ability to create a button similar to the iPhone system buttons that have a shine effect and color.
Both the text color and button color may easily be modified with properties.

## Accessing the shinyobjects Module

To access this module from JavaScript, you would do the following:

	var shinyobjects = require("shiny.objects");

The shinyobjects variable is a reference to the Module object.

## Reference

createButton		creates a shiny button

Properties

backgroundColor		sets the background color of the button

borderRadius		(float) sets the border radius of the button (iPhone system buton is about 6.0)

color			sets the color of the button text

Events

click - allows an event to be attached to the click of the button

## Usage

// Shiny Objects button

var shinyobjects = require("shiny.objects");

var btnShiny = shinyobjects.createButton({ 

	"color":"white",
	
	"backgroundColor":"blue",
	
	"top": 90,
	
	"width":100, 
	
	"height":30,
	
	"borderRadius": 6.0,
	
	"title": "Shiny"
	
});

btnShiny.addEventListener('click', function()

{

	alert('You clicked the shiny button.');
	
});

## Author

Scott Mason

## License

See the LICENSE file included with this distribution
