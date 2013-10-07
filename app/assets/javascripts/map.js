// Generated by CoffeeScript 1.4.0
var log, map, markerArray;

log = console.log.bind(console);

map = "";

markerArray = [];

window.onload = function() {
  var colorData, colorFile, fileJS, fileRangeEnd, fileRangeStart, latlngData, latlngFile, mapJS, polylineStack, rangeEnd, rangeStart;
  colorFile = document.getElementById("colorFile");
  latlngFile = document.getElementById("latlngFile");
  colorData = "";
  latlngData = "";
  polylineStack = [];
  fileRangeStart = document.getElementById("lineLengthStart");
  fileRangeEnd = document.getElementById("lineLengthEnd");
  rangeStart = 0;
  rangeEnd = 100;
  mapJS = {
    init: function() {
      var latlng, myOptions;
      latlng = new google.maps.LatLng(35.685222, 139.729387);
      myOptions = {
        zoom: 17,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
		disableDefaultUI: true // Eliminate Control UIs
      };
      map = new google.maps.Map(document.getElementById("map"), myOptions);

	  //Iwasawa Add Script
	  // Custumize Style

	  var baseOptions = [{
		featureType:'all',
		elementType:'geometry',
		stylers:[
			{visibility:'on'},
			{hue:'#00040f'},
			{saturation:'-100'},
			{lightness: '-20'},
			{gamma:'0.2'}
		]
	  },{
		featureType:'all',
		elementType:'labels',
		stylers:[
			{visibility:'off'},
		]
	  }];
	  map.setOptions({styles:baseOptions});

    },
    removeAll: function() {
      var data, _i, _len;
      for (_i = 0, _len = polylineStack.length; _i < _len; _i++) {
        data = polylineStack[_i];
        data.setMap(null);
      }
    },
    drawLine: function(from, to, color) {
      var lineAry, polyline;
      lineAry = [new google.maps.LatLng(from.lat, from.lng), new google.maps.LatLng(to.lat, to.lng)];
      polyline = new google.maps.Polyline({
        path: lineAry,
        strokeColor: color,
        strokeOpacity: 1.0,
        strokeWeight: 5
      });
      polyline.setMap(map);
      polylineStack.push(polyline);
    },
    redrawLine: function() {
      var e, i, s, _i, _results;
      mapJS.removeAll();
      s = parseInt(polylineStack.length * rangeStart / 100);
      e = parseInt(polylineStack.length * rangeEnd / 100);
      _results = [];
      for (i = _i = s; s <= e ? _i <= e : _i >= e; i = s <= e ? ++_i : --_i) {
        _results.push(polylineStack[i].setMap(map));
      }
      return _results;
    }
  };
  fileJS = {
    init: function() {
      colorFile.addEventListener("change", fileJS.getAsText);
      latlngFile.addEventListener("change", fileJS.getAsText);
      fileRangeStart.addEventListener("change", fileJS.rangeChange);
      return fileRangeEnd.addEventListener("change", fileJS.rangeChange);
    },
    getAsText: function(file) {
      var reader, target;
      target = this.id;
      file = eval(target).files[0];
      reader = new FileReader();
      reader.readAsText(file, "UTF-8");
      reader.onprogress = function(evt) {
        return log(evt);
      };
      reader.onload = function(evt) {
        var str;
        str = evt.target.result;
        if (target === "colorFile") {
          colorData = str.split("\n");
        } else {
          latlngData = str.split("\n");
        }
        if (colorData && latlngData) {
          return fileJS.draw();
        }
      };
      reader.onerror = function(evt) {
        return log(evt);
      };
    },
    getLatlng: function(time) {
      var elm, lat, line, lng, tmp, _i, _len, _ref;
      tmp = "";
      lat = "";
      lng = "";
      for (_i = 0, _len = latlngData.length; _i < _len; _i++) {
        line = latlngData[_i];
        if (tmp === "") {
          tmp = line.split(" ");
          continue;
        }
        elm = line.split(" ");
        if ((tmp[0] * 1 <= (_ref = time * 1) && _ref < elm[0] * 1)) {
          lat = tmp[1] * 1 + (elm[1] - tmp[1]) * ((time - tmp[0]) / (elm[0] - tmp[0]));
          lng = tmp[2] * 1 + (elm[2] - tmp[2]) * ((time - tmp[0]) / (elm[0] - tmp[0]));
          if (!(parseInt(lat) === 35)) {
            log(lat + ":" + lng);
          }
          return {
            lat: lat,
            lng: lng
          };
        }
        tmp = elm;
      }
    },
    draw: function() {
      var color, elm, from, fromTime, index, line, to, toTime, _i, _len, _results;
      color = "";
      from = {};
      to = {};
      fromTime = "";
      toTime = "";
      _results = [];
      for (index = _i = 0, _len = colorData.length; _i < _len; index = ++_i) {
        line = colorData[index];
        elm = line.split(" ");
        fromTime = elm[0];
        toTime = elm[1];
		
		//color = '#';
		//colorをrgb(r,g,b)の形で表現する
        color = "rgb(";

		color += Math.floor(parseFloat(elm[2]));
		color += ',';
		color += Math.floor(parseFloat(elm[3]));
		color += ',';
		color += Math.floor(parseFloat(elm[4]));
		color += ')';
        //if (elm[2] === "0") {
        //  color += elm[2];
        //} else {
        //  color += "f";
        //}
        //if (elm[3] === "0") {
        //  color += elm[3];
        //} else {
        //  color += "f";
        //}
        //if (elm[4] === "0") {
        //  color += elm[4];
        //} else {
        //  color += "f";
        //}
        from = fileJS.getLatlng(fromTime);
        to = fileJS.getLatlng(toTime);
        _results.push(mapJS.drawLine(from, to, color));
      }
      return _results;
    },
    rangeChange: function() {
      rangeStart = fileRangeStart.value;
      rangeEnd = fileRangeEnd.value;
      return mapJS.redrawLine();
    }
  };
  mapJS.init();
  return fileJS.init();
};