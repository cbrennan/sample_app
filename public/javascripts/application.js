// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/*
Event.observe('micropost_content', 'keyup', textChanged());
Event.observe('micropost_content', 'keydown', textChanged);

function textChanged() {
    var maxLen = 140;
    var left = maxLen - this.value().length;
    $('char-count').update(left);
}
*/

$('#micropost_content').live('keyup keydown', function(e) {
  var maxLen = 140;
  var left = maxLen - $(this).val().length;
  $('#char-count').html(left);
});
