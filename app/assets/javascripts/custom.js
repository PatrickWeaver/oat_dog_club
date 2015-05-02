$(document).ready(function(){

  $( ".new-zine-menu" ).click(function() {
    $( ".new-zine-form" ).toggleClass( "invisible" );
  });

  $( ".new-paragraph-button" ).click(function() {
    $( ".new-paragraph-form" ).toggleClass( "invisible" );
  });

  $( ".new-image-button" ).click(function() {
    $( ".new-image-form" ).toggleClass( "invisible" );
  });

  $( ".close-box" ).click(function() {
    $( this ).parent(".box").toggleClass( "invisible" );
    $( this ).parents(".twin-boxes").children(".twin-box").toggleClass ( "invisible" );
  });

  $( ".author-section" ).find( ".close-box" ).click(function() {
    $( ".author-section" ).find(".show-author").toggleClass( "invisible" );
    $( ".author-section" ).find(".remove-author").toggleClass( "invisible" );
  });

  $( ".title-unhide" ).click(function() {
    $( ".zine-title-container" ).toggleClass( "invisible" );
  });

  var containerWidth = $('.zine-title-container').width();
  var blockWidth = $('.zine-title-block').outerWidth();
  var blockHeight = $('.zine-title-block').outerHeight();


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

  if (blockWidth < 300 ) {
    newEditWidth = 300
    if (blockHeight < 300){
    extraTopMargin = 100
   }
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


  $( ".authors-button" ).click(function() {
    $( ".zine-title-container" ).toggleClass( "invisible" );
    $( ".authors" ).toggleClass( "invisible" );

  });

  $( ".remove-author-button" ).click(function() {
    $( this ).toggleClass( "btn-danger").toggleClass( "btn-warning" );
    $( ".edit-authors" ).toggleClass( "dark-changes");
    $( ".add-author-button").toggleClass( "invisible");
    $( ".dont-add-author-button").toggleClass( "invisible");
    $( ".show-authors-button").toggleClass( "btn-success" ).toggleClass( "btn-gray" );
    $( ".hide-authors-button").toggleClass( "btn-danger" ).toggleClass( "btn-gray" );
    $( ".show-author" ).toggleClass( "invisible" );
    $( ".remove-author" ).toggleClass( "invisible" );
  })

  $( ".add-author-button" ).click(function() {
    $( ".authors-list" ).toggleClass( "invisible" );
    $( ".add-author" ).toggleClass( "invisible" );
    $( ".show-authors-button").toggleClass( "btn-success" ).toggleClass( "btn-gray" );
    $( ".hide-authors-button").toggleClass( "btn-danger" ).toggleClass( "btn-gray" );
    $( ".remove-author-button").toggleClass( "invisible");
    $( ".dont-remove-author-button").toggleClass( "invisible");
    $( ".add-author-button").toggleClass( "btn-success" ).toggleClass( "btn-gray" );
  })






});
