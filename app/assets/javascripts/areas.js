// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var map = L.map('map', {
  crs: L.CRS.Simple,
  maxZoom: 5,
});

var floorPlanData = $('#map').data()

var height = parseInt(floorPlanData['height']);
var width = parseInt(floorPlanData['width']);

//converts height to map units for leaflet
var ratio = width + height
var width_unit = width/ratio * 1000;
var height_unit = height/ratio * 1000;

var bounds = [[0,0], [height_unit, width_unit]];
// var bounds = [[0,0], [100,100]];
var image = L.imageOverlay(floorPlanData["floorPlanUrl"] , bounds).addTo(map);
console.log('Bounds:', height_unit, width_unit);
//add markers
var greenIcon = L.icon({
    iconUrl: 'http://leafletjs.com/examples/custom-icons/leaf-green.png',
    shadowUrl: 'http://leafletjs.com/examples/custom-icons/leaf-shadow.png',

    iconSize:     [38, 95], // size of the icon
    shadowSize:   [50, 64], // size of the shadow
    iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
    shadowAnchor: [4, 62],  // the same for the shadow
    popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
});

L.marker([height_unit * 1.00 , width_unit * .5], {icon: greenIcon}).addTo(map);
L.marker([height_unit * 0.00 , width_unit * .5], {icon: greenIcon}).addTo(map);

L.marker([height_unit * 0.50 , width_unit * 1.0], {icon: greenIcon}).addTo(map);
L.marker([height_unit * 0.50 , width_unit * 0.0], {icon: greenIcon}).addTo(map);
map.fitBounds(bounds);
