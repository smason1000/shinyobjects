// This is a test harness for your module
// This application creates a toolbar and adds buttons to both the left and right sides.
// The main screen features buttons of different colors that change the window background when clicked 

// open a single window
var window = Ti.UI.createWindow({
	backgroundColor:'white'
});
window.open();

// TODO: write your module tests here
var shinyObjects = require("shiny.objects");

var util = shinyObjects.createUtility();
util.sleep(0.5);

var top = 70;
var btnGray = shinyObjects.createButton({ 
	color:"white",
	backgroundColor: "gray",
	top: top,
	left: 40,
	width:100, 
	height:30,
	title: "Gray"
});
btnGray.addEventListener('click', function()
{
	window.backgroundColor = "gray";
});
var btnWhite = shinyObjects.createButton({ 
	color:"black",
	backgroundColor: "white",
	top: top,
	left: 180,
	width:100, 
	height:30,
	title: "White"
});
btnWhite.addEventListener('click', function()
{
	window.backgroundColor = "white";
});

top += 40;
var btnRed = shinyObjects.createButton({ 
	color:"white",
	backgroundColor: "red",
	top: top,
	left: 40,
	width:100, 
	height:30,
	title: "Red"
});
btnRed.addEventListener('click', function()
{
	window.backgroundColor = "red";
});
var btnYellow = shinyObjects.createButton({ 
	color:"black",
	backgroundColor: "yellow",
	top: top,
	left: 180,
	width:100, 
	height:30,
	title: "Yellow"
});
btnYellow.addEventListener('click', function()
{
	window.backgroundColor = "yellow";
});

top += 40;
var btnPurple = shinyObjects.createButton({ 
	color:"white",
	backgroundColor: "purple",
	top: top,
	left: 40,
	width:100, 
	height:30,
	title: "Purple"
});
btnPurple.addEventListener('click', function()
{
	window.backgroundColor = "purple";
});
var btnCyan = shinyObjects.createButton({ 
	color:"black",
	backgroundColor: "cyan",
	top: top,
	left: 180,
	width:100, 
	height:30,
	title: "Cyan"
});
btnCyan.addEventListener('click', function()
{
	window.backgroundColor = "cyan";
});

top += 40;
var btnBlue = shinyObjects.createButton({ 
	color:"white",
	backgroundColor: "blue",
	top: top,
	left: 40,
	width:100, 
	height:30,
	title: "Blue"
});
btnBlue.addEventListener('click', function()
{
	window.backgroundColor = "blue";
});
var btnMagenta = shinyObjects.createButton({ 
	color:"black",
	backgroundColor: "magenta",
	top: top,
	left: 180,
	width:100, 
	height:30,
	title: "Magenta"
});
btnMagenta.addEventListener('click', function()
{
	window.backgroundColor = "magenta";
});

top += 40;
var btnBlack = shinyObjects.createButton({ 
	color:"white",
	backgroundColor: "black",
	top: top,
	left: 40,
	width:100, 
	height:30,
	title: "Black"
});
btnBlack.addEventListener('click', function()
{
	window.backgroundColor = "black";
});
var btnOrange = shinyObjects.createButton({ 
	color:"black",
	backgroundColor: "orange",
	top: top,
	left: 180,
	width:100, 
	height:30,
	title: "Orange"
});
btnOrange.addEventListener('click', function()
{
	window.backgroundColor = "orange";
});

top += 40;
var btnBrown = shinyObjects.createButton({ 
	color:"white",
	backgroundColor: "brown",
	top: top,
	left: 40,
	width:100, 
	height:30,
	title: "Brown"
});
btnBrown.addEventListener('click', function()
{
	window.backgroundColor = "brown";
});
var btnGreen = shinyObjects.createButton({ 
	color:"black",
	backgroundColor: "green",
	top: top,
	left: 180,
	width:100, 
	height:30,
	title: "Green"
});
btnGreen.addEventListener('click', function()
{
	window.backgroundColor = "green";
});

window.add(btnGray);
window.add(btnWhite);
window.add(btnRed);
window.add(btnYellow);
window.add(btnPurple);
window.add(btnCyan);
window.add(btnBlue);
window.add(btnMagenta);
window.add(btnBlack);
window.add(btnOrange);
window.add(btnBrown);
window.add(btnGreen);

// Toolbar example

// This technique can also be used within the standard navigation bar
// allowing you to control the buttons that go in there

// You can mix and match shiny buttons and standard Titanium buttons

var toolBar = Ti.UI.createToolbar({
	top: 0
});

// create the container for the 2 buttons
// they are going to be placed on the toolbar, but could be the left or right nav objects
var viewLeft = Ti.UI.createView({
	top: 0,
	left: 5,
	height: 30,
	width: 130
});

// Back
var btnSave = shinyObjects.createButton(
{
	top: 7,
	left: 0,
	width: 60,
	height: 30,
	borderRadius: 5,
	color: 'white',
	backgroundColor: '#324f85',
	title: 'Save'
});
btnSave.addEventListener('click', function(){
	alert('You clicked the Save button.');
});

// Quit
var btnQuit = shinyObjects.createButton(
{
	top: 7,
	left: 65,
	width: 60,
	height: 30,
	borderRadius: 5,
	color: 'white',
	backgroundColor: '#324f85',
	title: 'Quit'
});
btnQuit.addEventListener('click', function(){
	alert('You clicked the Quit button.');
});
viewLeft.add(btnSave);
viewLeft.add(btnQuit);

// create a container for the right buttons - you can add multiple buttons to this view as well
var viewRight = Ti.UI.createView({
	top: 0,
	right: 5,
	height: 30,
	width: 100
});

// Delete
var btnDelete = shinyObjects.createButton(
{
	top: 7,
	left: 35,
	width: 60,
	height: 30,
	borderRadius: 5,
	color: 'white',
	backgroundColor: 'red',
	title: 'Delete'
});
btnDelete.addEventListener('click', function(){
	alert('You clicked the Delete button.');
});

// Flashlight
var btnLight = shinyObjects.createButton(
{
	top: 7,
	left: 0,
	width: 30,
	height: 30,
	borderRadius: 5,
	color: 'white',
	backgroundColor: 'black',
	title: 'On'
});
btnLight.addEventListener('click', function()
{
	// toggle the flashlight
	if (btnLight.title == 'On')
	{
		if (util.hasFlashlight == 1)
			util.flashlight(1);
		else
			window.backgroundColor = 'white';
		btnLight.backgroundColor = 'white';
		btnLight.title = 'Off';
		btnLight.color = 'black';
	}
	else
	{
		if (util.hasFlashlight == 1)
			util.flashlight(0);
		else
			window.backgroundColor = 'black';
		btnLight.backgroundColor = 'black';
		btnLight.title = 'On';
		btnLight.color = 'white';
	}
});
viewRight.add(btnLight);
viewRight.add(btnDelete);

toolBar.add(viewLeft);
toolBar.add(viewRight);
window.add(toolBar);
