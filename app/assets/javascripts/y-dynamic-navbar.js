$(document).ready(function() {
	$('#nav').scrollerspy({
		min: 0,
		mode: 'horizontal',
		onEnter: function(position,enters) {},
		onLeave: function(position,leaves) {},
		onTick: function(element, position, enters, leaves) {
			$("#nav").css("left", -position.left + "px");
		},
		container: window
	});
});
