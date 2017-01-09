function createGmap(data) {
  handler = Gmaps.build('Google');
  handler.buildMap ({
      provider: {},
      internal: {id: 'apartment_map'}
    },
    function() {
      markers = handler.addMarkers(data);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
      handler.getMap().setZoom(12);
    }
  );
};

function loadAndCreateGmap() {
  if ($("#apartment_map").length > 0) {
    var apartmentId = $("#apartment_map").attr("data-apartment-id");

    $.ajax({
      dataType: 'json',
      url: '/apartments/' + apartmentId + '/map_location',
      method: 'GET',
      success: function(data) {
        createGmap(data);
      },
      error: function (jqXHR, testStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};
$(document).on('ready', loadAndCreateGmap);
$(document).on('turbolinks:load', loadAndCreateGmap);
