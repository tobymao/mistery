setTimeout(function() {
  var el = document.getElementsByClassName('flash');
  for (var i = 0; i < el.length; i++) {
    el[i].className += ' fade';
  }
}, 2000);
