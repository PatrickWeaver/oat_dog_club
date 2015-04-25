$(document).ready(function(){

  $( ".new-zine-menu" ).click(function() {
    $( ".new-zine-form" ).toggleClass( "invisible" );
  });

  $( ".new-paragraph-button" ).click(function() {
    $( ".new-paragraph-form" ).toggleClass( "invisible" );
  });

  $( ".close-box" ).click(function() {
    $( this ).parent(".box").toggleClass( "invisible" );
  });

  var containerWidth = $('.zine-title-container').width();
  var blockWidth = $('.zine-title-block').outerWidth();

  $( ".zine-title-block" ).css({ 
        'left' : (containerWidth - blockWidth) / 2
    });

  var containerHeight = $('.zine-title-container').outerHeight();
  var titleHeight = $('.zine-title').outerHeight();
  var titleWidth = $('.zine-title').outerWidth();
  var editHeight = $('.edit-title-form').outerHeight();
  var editWidth = $('.edit-title-form').outerWidth();
  var newEditWidth
  var extraTopMargin = 0

  if ( titleWidth < editWidth ) {
    newEditWidth = blockWidth
  } else {
    newEditWidth = editWidth
  }

  if (blockWidth < 300) {
    newEditWidth = 300
    extraTopMargin = 100
  }


  $( ".zine-title" ).css({ 
      'left' : (containerWidth - titleWidth) / 2,
      'top' :  (containerHeight - titleHeight) / 2,
      'width' : titleWidth
  });

  $( ".edit-title-form" ).css({ 
      'left' : (containerWidth - newEditWidth) / 2,
      'top' :  (containerHeight - editHeight) / 2 + extraTopMargin,
      'width' : blockWidth
  });

  $( ".edit-title-button" ).click(function() {
    $( ".edit-title-form" ).toggleClass( "invisible" );
    $( ".zine-title" ).toggleClass( "invisible" );
  });






});

