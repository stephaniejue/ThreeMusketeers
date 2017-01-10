function createGmapAll(data) {
  handler = Gmaps.build('Google');
  handler.buildMap ({
      provider: {},
      internal: {id: 'apartment_map_all'}
    },
    // function() {
    //   showLocations(data);
    // },
    function() {
      markers = handler.addMarkers(data);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
      // handler.getMap().setZoom();
    }
  );
}
//
// function showLocations(data) {
//   if (navigator.geolocation) {
//       navigator.geolocation.getCurrentPosition(function(position) {
//       // Add our position to the collection of markers
//       data[data.length] = {
//         lat: position.coords.latitude,
//         lng: position.coords.longitude,
//         infowindow: "You!"
//       };
//       placeMakers(data, markers);
//     });
//   } else {
//       alert("Geolocation is not available.");
//       placeMakers(data, markers)
//   }
// }

function loadAndCreateGmapAll() {
  if ($("#apartment_map_all").length > 0) {
    $.ajax({
      dataType: 'json',
      url: '/apartments/map_all',
      method: 'GET',
      success: function(data) {
        createGmapAll(data);
      },
      error: function (jqXHR, testStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};

$(document).on('ready', loadAndCreateGmapAll);
$(document).on('turbolinks:load', loadAndCreateGmapAll);
