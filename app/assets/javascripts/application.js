// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require twitter/bootstrap
//= require_self
//= require user_list
//= require attachments
//= require jquery.form
//= require jquery.easing.1.3.js
//= require jquery.elastislide.js
//= require elastislide
//= require lightbox
//= require photos
//= require tooltips
//= require jquery-scrollerspy.js
//= require y-dynamic-navbar.js
//= require sortable
//= require bootstrap-datetimepicker.min.js
//= require locales/bootstrap-datetimepicker.cs.js
// DISABLED require bootstrap.js.coffee
// DISABLED require user_sessions.js.coffee

// Po kazdem schovani modalu smazat jeho obsah. Jinak modaly plnene vzdalene zobrazuji stale stejna data.
$('body').on('hidden', '.modal', function () {
  $(this).removeData('moal');
});

$(document).ready(function() {
 $('.input-datetime').datetimepicker({
   language: 'cs',
   format: "dd. mm. yyyy hh:ii",
   autoclose: true,
   weekStart: 1});
});