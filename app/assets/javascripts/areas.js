// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var map = L.map('map', {
  crs: L.CRS.Simple,
  maxZoom: 5
});

var bounds = [[0,0], [400,400]];
var image = L.imageOverlay($('#map').data()["floorPlanUrl"] , bounds).addTo(map);
map.fitBounds(bounds);
