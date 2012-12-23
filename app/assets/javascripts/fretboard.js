/* Fretboard UI */
$(function() {
  $('.fretboard .v1 .s1').addClass('current');
  
  Mousetrap.bind('down', function() {
    var current = getCurrent();
    var strings = current.siblings();
    
    if ( ! current.length || current.is(':last-child') ) {
      current = strings.eq(0);
    } else {
      current = current.next();
    }
    current.addClass('current');
  });
  Mousetrap.bind('up', function() {
    var current = getCurrent();
    var strings = current.siblings();
    
    if ( ! current.length || current.is(':first-child') ) {
      current = strings.last();
    } else {
      current = current.prev();
    }
    current.addClass('current');
  });
  Mousetrap.bind('left', function() {
    var current = getCurrent();
    var current_class = current.attr('class');
    var column = current.parent();
    var fretboard = column.siblings();
    
    if ( ! current.length || column.is(':first-child') ) {
      column = fretboard.last();
    } else {
      column = fretboard.prev();
    }
    column.children('.'+current_class).addClass('current');
  });
  Mousetrap.bind('right', function() {
    var current = getCurrent();
    var current_class = current.attr('class');
    var column = current.parent();
    var fretboard = column.siblings();
    if ( ! current.length || column.is(':last-child') ) {
      column = fretboard.first();
    } else {
      column = fretboard.next();
    }
    alert(column.children('.'+current_class))
    column.children('.'+current_class).addClass('current');
  });
});

getCurrent = function(){
  var c = $('.fretboard ul li.current');
  c.removeClass('current');
  return c;
}