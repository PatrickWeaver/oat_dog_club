$(window).load(function(){

  $( ".new-zine-menu" ).click(function() {
    $( ".new-zine-form" ).toggleClass( "invisible" );
  });

  $( ".new-paragraph-button" ).click(function() {
    $( ".new-paragraph-form" ).toggleClass( "invisible" );
  });

  $( ".new-image-button" ).click(function() {
    $( ".new-image-form" ).toggleClass( "invisible" );
  });

  $( ".new-cover-button" ).click(function() {
    $( ".new-cover-form" ).toggleClass( "invisible" );
    $( ".zine-title-container" ).toggleClass( "invisible" );
  });

  $(".zine-content-edit-button").click(function() {
    $( this ).siblings(".zine-content-edit-buttons").toggleClass( "invisible" );
  });

  $( ".zine-content-close-box" ).click(function() {
    $( this ).parents(".box").toggleClass( "invisible" );
    $( this ).parents(".zine-content-container").children(".orderable").toggleClass( "invisible" );
    $( this ).parents(".zine-cover-container").children(".zine-title-container").toggleClass( "invisible" );
  });



  $( ".move-to-button" ).click(function() {
    $( this ).parents(".zine-content-container").children(".orderable").toggleClass( "invisible" );
    $( this ).parents(".zine-content-container").children(".move-to-edit").toggleClass( "invisible" );
  });

  $( ".border-button" ).click(function() {
    $( this ).parents(".zine-content-container").children(".orderable").toggleClass( "invisible" );
    $( this ).parents(".zine-content-container").children(".border-color-edit").toggleClass( "invisible" );
  });

  $( ".create-paragraph-image-button" ).click(function() {
    $( this ).parents(".zine-content-container").children(".orderable").toggleClass( "invisible" );
    $( this ).parents(".zine-content-container").find(".new-paragraph-image").toggleClass( "invisible" );
  });

  $( ".image-width-button" ).click(function() {
    $( this ).parents(".zine-content-container").children(".orderable").toggleClass( "invisible" );
    $( this ).parents(".zine-content-container").children(".image-resize").toggleClass( "invisible" );
  });

  $( ".caption-button" ).click(function() {
    $( this ).parents(".zine-content-container").children(".orderable").toggleClass( "invisible" );
    $( this ).parents(".zine-content-container").children(".edit-caption").toggleClass( "invisible" );
  });


  $( ".paragraph-image-close-box" ).click(function() {
    $( this ).parents(".box").toggleClass( "invisible" );
    $( this ).parents(".paragraph-image-container").children("ul.images-list").toggleClass( "invisible" );
  });



  $( ".paragraph-image-width-button" ).click(function() {
    $( this ).parents(".paragraph-image-container").children("ul.images-list").toggleClass( "invisible" );
    $( this ).parents(".paragraph-image-container").children(".image-resize").toggleClass( "invisible" );
  });

  $( ".paragraph-image-caption-button" ).click(function() {
    $( this ).parents(".paragraph-image-container").children("ul.images-list").toggleClass( "invisible" );
    $( this ).parents(".paragraph-image-container").children(".edit-caption").toggleClass( "invisible" );
  });




  $( ".author-section" ).find( ".close-box" ).click(function() {
    $( ".author-section" ).find(".show-author").toggleClass( "invisible" );
    $( ".author-section" ).find(".remove-author").toggleClass( "invisible" );
  });

  $( ".title-unhide" ).click(function() {
    $( ".zine-title-container" ).toggleClass( "invisible" );
  });


  $( ".phone-dropdown" ).click(function() {
    $(".phone-dropdown-menu").toggleClass( "invisible" );
  });

  var containerWidth = $('.zine-title-container').outerWidth();
  var blockWidth = $('.zine-title-block').outerWidth();
  var blockHeight = $('.zine-title-block').outerHeight();


  $( ".zine-title-block" ).css({ 
        'left' : (containerWidth - blockWidth) / 2
    });

  var containerHeight = $('.zine-title-container').outerHeight();
  var titleHeight = $('.zine-title').outerHeight();
  var titleWidth = $('.zine-title').outerWidth();

  $( ".zine-title" ).css({ 
      'top' :  (containerHeight - titleHeight) / 2,
      'left' : (containerWidth - titleWidth) / 2,
      'width' : titleWidth
  });

  if (blockWidth < 0) {
    $( ".zine-title" ).css({ 
      'top' :  (containerHeight - titleHeight) / 2,
    });
  };

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

  $( ".edit-title-button" ).click(function() {
    $( ".edit-title-form" ).toggleClass( "invisible" );
    $( ".zine-title-container" ).toggleClass( "invisible" );
  });

  $( ".resize-cover" ).click(function() {
    $( ".zine-title-container" ).toggleClass( "invisible" );
    $( ".cover-resize-form" ).toggleClass( "invisible" );
  });

  $( ".authors-close-box" ).click(function() {
    $(".authors").removeClass("invisible");
    $(".edit-authors").addClass("invisible").removeClass("dark-changes");
    $(".zine-title-container").removeClass("invisible");
    $(".add-author-button").removeClass("invisible");
    $(".dont-add-author-button").addClass("invisible");
    $(".show-authors-buton").addClass("btn-success").removeClass("btn-gray");
    $(".hide-authors-button").addClass("btn-danger").removeClass("btn-gray");
    $(".show-author").removeClass("invisible");
    $(".remove-author").addClass("invisible");
    $(".authors-list").removeClass("invisible");
    $(".add-author").addClass("invisible");
    $(".remove-author-button").addClass("btn-danger").removeClass("btn-warning" );
    $(".dont-remove-author-button").addClass("invisible");

  });


  $( ".authors-button" ).click(function() {
    $( ".zine-title-container" ).toggleClass( "invisible" );
    $( ".authors" ).toggleClass( "invisible" );
    $( ".edit-authors" ).toggleClass( "invisible" );

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

  $('.colorpicker').colorpicker();

  $('textarea[maxLength]').each(function(){
    var tId=$(this).attr("id");
    $(this).after('<span class="text-area-counter" id="cnt'+tId+'"></span>');
    $(this).keyup(function () {
      var tId=$(this).attr("id");
      var tMax=$(this).attr("maxLength");
      var left = tMax - $(this).val().length;
      if (left < 0) left = 0;
      $('#cnt'+tId).text('Characters left: ' + left);
    }).keyup();
  });

  $('.caption-container').each(function(){
    var width = $(this).prev().width();
    $(this).width(width);
  });

  $(function(){
    $('header').data('size','big');
  });

    $(window).scroll(function() {
      if($(document).scrollTop() > 0) {
        if($('.navbar').data('size') == 'big') {
          $('.navbar').data('size','small');
          $('.navbar').stop().animate( {
            height:'25px'
          },200);
          $('.nav-li > a').data('size', 'small');
          $('.nav-li > a').stop().animate( {
              padding: '2px 15px'
          }, 200);
          $('.logo').data('size', 'small');
          $('.logo').stop().animate( {
              padding: '0px 0px 0px',
              fontSize: '1.3em'
          }, 200);
          $('.oat-dog-logo').data('size', 'small');
          $('.oat-dog-logo').stop().animate( {
              height: '22px',
              margin: '2px 10px 1px'
          }, 200);
        }
      }
      else {
        if($('.navbar').data('size') == 'small') {
          $('.navbar').data('size','big');
          $('.navbar').stop().animate({
              height:'50px'
          },200);
          $('.nav-li > a').data('size', 'big');
          $('.nav-li > a').stop().animate({
              padding: '15px 15px'
          }, 200);
          $('.logo').data('size', 'big');
          $('.logo').stop().animate({
              padding: '9px 0px 0px',
              fontSize: '1.7em'
          }, 200);
          $('.oat-dog-logo').data('size', 'big');
          $('.oat-dog-logo').stop().animate({
              height: '44px',
              margin: '3px 10px'
          }, 200);
        }  
      }
    });

$(function(){
    $('header').data('size','big');
  });

    $(window).scroll(function() {
      if($(document).scrollTop() > 0) {
        if($('.phone-navbar').data('size') == 'big') {
          $('.phone-navbar').data('size','small');
          $('.phone-navbar').stop().animate( {
            height:'100px'
          },0);
          $('.phone-nav-li').data('size', 'small');
          $('.phone-nav-li').stop().animate( {
              padding: '0px 15px',
              fontSize: '1em'
          }, 0);
          $('.phone-logo').data('size', 'small');
          $('.phone-logo').stop().animate( {
              fontSize: '1.3em',
              padding: '0px'
          }, 0);
          $('.phone-oat-dog-logo').data('size', 'small');
          $('.phone-oat-dog-logo').stop().animate( {
              height: '96px',
              margin: '2px 0px'
          }, 0);
          $('.phone-dropdown-menu').data('size', 'small');
          $('.phone-dropdown-menu').stop().animate( {
              margin: '100px 0px 0px 0px'
          }, 0);
        }
      }
      else {
        if($('.phone-navbar').data('size') == 'small') {
          $('.phone-navbar').data('size','big');
          $('.phone-navbar').stop().animate({
              height:'250px'
          },0);
          $('.phone-nav-li').data('size', 'big');
          $('.phone-nav-li').stop().animate({
              padding: '30px 15px',
              fontSize: '1em'
          }, 0);
          $('.phone-logo').data('size', 'big');
          $('.phone-logo').stop().animate({
              fontSize: '3em',
              padding: '9px 0px 0px 0px'
          }, 0);
          $('.phone-oat-dog-logo').data('size', 'big');
          $('.phone-oat-dog-logo').stop().animate({
              height: '240px',
              margin: '5px 0px'
          }, 0);
          $('.phone-dropdown-menu').data('size', 'big');
          $('.phone-dropdown-menu').stop().animate({
              margin: '250px 0px 0px 0px'
          }, 0);
        }  
      }
    });
  




  


});
