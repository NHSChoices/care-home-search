$(function () {
  $('.map-container').each(function () {
    var $map      = $("#map_canvas", this);
    var $markers  = $('.map-marker');

    $map.gmap({
      'mapType': google.maps.MapTypeId.ROADMAP,
      'maxZoom': 18
    }).bind('init', function (ev, map) {

      $markers.each(function () {
        var $marker = $(this);

        var latitude  = $marker.data('latitude');
        var longitude = $marker.data('longitude');
        var info      = $marker.html();
        var options   = { position: latitude + ',' + longitude };

        $map.gmap('addMarker', options).click(function () {
          $map.gmap('openInfoWindow', {'content': info }, this);
        });

        $map.gmap('addBounds', new google.maps.LatLng(latitude, longitude));
      });

    });
  });
});
