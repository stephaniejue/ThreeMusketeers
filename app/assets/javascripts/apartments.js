function loadAndCreateGmap() {
  // console.log("loadAndCreateGmap running");
  if ($("#apartment_map").length > 0) {
    var apartmentId = $("#apartment_map").attr("data-apartment-id");
    $.ajax({
      dataType: 'json',
      url: '/apartments/' + apartmentId + '/map_location',
      method: 'GET',
      success: function(data) {
        placeMarkers(data);
      },
      error: function (jqXHR, testStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};

function placeMarkers(data) {
  // console.log("placeMarkers running");
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      // Add our position to the collection of markers
      var my_data = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        "picture": {
          "url": "http://pngimages.net/sites/default/files/user-png-image-30725.png",
          "width":  32,
          "height": 32
        },
        infowindow: "You!"
      };
      data.push(my_data);
      createGmap(data);
    });
  } else {
    alert("Geolocation is not available.");
    createGmap(data);
  }
}

function createGmap(data) {
  // console.log("createGmap running");
  handler = Gmaps.build('Google');
  handler.buildMap ({
      provider: {},
      internal: {id: 'apartment_map'}
    },
    function() {
      markers = handler.addMarkers(data);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
      // handler.getMap().setZoom(7);
    }
  );
};





$(document).on('ready', loadAndCreateGmap);
$(document).on('turbolinks:load', loadAndCreateGmap);
