// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var map = L.map('map', {
  crs: L.CRS.Simple,
  maxZoom: 5,
});

var floorPlanData = $('#map').data()
console.log(floorPlanData)


var height = parseInt(floorPlanData['height']);
var width = parseInt(floorPlanData['width']);

//converts height to map units for leaflet
var ratio = width + height
var width_unit = width/ratio * 1000;
var height_unit = height/ratio * 1000;

var bounds = [[0,0], [height_unit, width_unit]];
// var bounds = [[0,0], [100,100]];
var image = L.imageOverlay(floorPlanData["floorPlanUrl"] , bounds).addTo(map);
map.fitBounds(bounds);
