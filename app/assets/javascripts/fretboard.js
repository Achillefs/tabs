/* Fretboard UI */
$(function() {
  if ($('.fretboard').exists()) {
    /* START Fretboard Arrow navigation */
    $('.fretboard .v1 .s1').addClass('current');
    Mousetrap.bind('down', function() {
      var current = getCurrent();
      var strings = current.siblings();

      if ( current.is(':last-child') ) {
        current = strings.eq(0);
      } else {
        current = current.next();
      }
      current.addClass('current');
    });

    Mousetrap.bind('up', function() {
      var current = getCurrent();
      var strings = current.siblings();

      if ( current.is(':first-child') ) {
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
      var fretboard = $('.fretboard ul');

      if ( column.is(':first-child') ) {
        column = fretboard.last();
      } else {
        column = column.prev();
      }

      column.find('.'+current_class).addClass('current');
    });

    Mousetrap.bind('right', function() {
      var current = getCurrent();
      var current_class = current.attr('class');
      var column = current.parent();
      var fretboard = $('.fretboard ul');
      if ( column.is(':last-child') ) {
        column = fretboard.eq(0);
      } else {
        column = column.next();
      }

      column.find('.'+current_class).addClass('current');
    });
    /* END Fretboard Arrow navigation */
    
    // START fretboard fret number input
    Mousetrap.bind(
      ['0','1','2','3','4','5','6','7','8','9','q','w','e','a','s','d','x'], function(e,key){
      var current_val = $('.fretboard ul li.current div').text();
      var value = key;
      switch(value){
        case 'q':
          value = '4';
          break;
        case 'w':
          value = '5';
          break;
        case 'e':
          value = '6';
          break;
        case 'a':
          value = '7';
          break;
        case 's':
          value = '8';
          break;
        case 'd':
          value = '9';
          break;
        case 'x':
          value = '0';
          break;
      }
      if (current_val == '1' || current_val == '2') {
        value = current_val + value;
      };
      $('.fretboard ul li.current div').text(value);
    });
    
    // Delete current fret
    Mousetrap.bind('backspace',function(){
      $('.fretboard ul li.current div').text('');
      return false; // dont let the browser do its thang
    });
  };
});

getCurrent = function(){
  var c = $('.fretboard ul li.current');
  c.removeClass('current');
  return c;
};