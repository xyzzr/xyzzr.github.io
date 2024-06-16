$(document).ready(function() {
	$.getJSON("https://api.countapi.xyz/get/eaglercraft.ru/7ab2c8d5-5869-46ff-a0e8-2d22822f8ffe", function(response) {
	    $("#playCount").text(response.value);
	});
});

function playCount(response) {
$(document).ready(function() {
	$("#play-now").click(function(){
		$("#playCount").text(response.value);
	});
});
}