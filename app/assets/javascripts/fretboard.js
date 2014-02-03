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
    Mousetrap.bind(['backspace','c'],function(){
      $('.fretboard ul li.current div').text('');
      return false; // dont let the browser do its thang
    });
    
    // Delete all data
    Mousetrap.bind(['ctrl+backspace','ctrl+c'],function(){
      $('.fretboard ul li div').text('');
      return false;
    });
    
    // Save data12
    Mousetrap.bindGlobal('ctrl+s',function(){
      $('form input:submit').click();
    });
    
    // submit form
    $('#new_tab').submit(function(){
      content = []
      var vertical = 0
      //grab all fret data
      $('.fretboard ul').each(function(){ // which time are we at?
        var v = parseInt($(this).attr('data-vertical'));
        content[vertical] = [];
        $(this).find('li').each(function(){
          var string = parseInt($(this).attr('data-string'));
          if ($(this).find('div').text() != '') { // we have user input
            content[vertical].push([string,parseInt($(this).find('div').text())]);
          }
        });
        vertical+=1
      });
      console.log(JSON.stringify(content))
      $('#tab_content').val(JSON.stringify(content));
    });
  };
});

getCurrent = function(){
  var c = $('.fretboard ul li.current');
  c.removeClass('current');
  return c;
};