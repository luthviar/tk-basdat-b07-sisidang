/* Javascript */
$(function () {
    var date = new Date();
    var y = date.getFullYear();
	
	$('#calendar').fullCalendar({
		header: {
			left: 'prev,next today',
			center: 'title'
		},
		editable: true
	});
});