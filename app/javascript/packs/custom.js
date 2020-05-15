/* re: making a table row clickable with js https://jumpstartrails.com/discussions/50*/
/* re: making Rails 5 + turbolinks play nice with document load functions https://stackoverflow.com/questions/36110789/rails-5-how-to-use-document-ready-with-turbo-links */

// $(document).on('turbolinks:load', function(){
//   $(".clickable-tr").on('click', function(e){
//     console.log("It works on each vist!")
//     url = $(this).attr('data-path');
//     window.location = url;
//   });
// });

// $(document).ready(function(){
//   $(".clickable-tr").on('click', function(e){
//     console.log("clicked a row!");
//     url = $(this).attr('data-path');
//     window.location = url;
//   });
// });

$(document).on('turbolinks:load', function(){
  $(".clickable-tr").on('click', function(e){
    url = $(this).attr('data-path');
    window.location = url;
  });
});