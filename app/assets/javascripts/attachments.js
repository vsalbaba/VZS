$(function () {
	var newAttachment = $('#vzs-new-attachment');
	if(newAttachment.length) {
		if($('.error', newAttachment).length) {
			return;
		}
		$(newAttachment).hide();
		$(newAttachment).after(''
			+'<div id="vzs-new-attachment-link">'
			+'<a href="#" class="btn">'
			+'<i class="icon-file"></i> '
			+'Nová příloha &hellip;'
			+'</a>'
			+'</div>'
			);
		$('button[type=reset]', newAttachment).click( function() {
			newAttachment.hide();
			$('#vzs-new-attachment-link').show();
		});
		$('#vzs-new-attachment-link a').click( function() {
			newAttachment.show();
			$('#vzs-new-attachment-link').hide();
			return false;
		});
	}
});
