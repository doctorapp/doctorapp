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
//= require jquery_ujs
//= require bootstrap
//= require_tree .

$(function() {

	$('#appointment_start').datetimepicker({
		addslideraccess: true,
		slideraccessargs: { touchonly: false }
	});
	
	$('#appointment_end').datetimepicker({
		addslideraccess: true,
		slideraccessargs: { touchonly: false }
	});

});

// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function moveEvent(event, dayDelta, minuteDelta, allDay){
    jQuery.ajax({
        data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&all_day=' + allDay,
        dataType: 'script',
        type: 'post',
        url: "/events/move"
    });
}

function resizeEvent(event, dayDelta, minuteDelta){
    jQuery.ajax({
        data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta,
        dataType: 'script',
        type: 'post',
        url: "/events/resize"
    });
}

function showEventDetails(event){
    //alert("Show events with Id"+event.id );
    title = event.title;
    start = event.start;
    userId = event.user_id;
    doctorId = event.doctor_id;

    $('#event_desc').html("Start: "+start+"</br> userId: "+userId+"</br> doctorId: "+doctorId);
    $('#edit_event').html("<a href = 'javascript:void(0);' onclick ='editEvent(" + event.id + ")'>Edit</a>");
    /*if (event.recurring) {
        title = event.title + "(Recurring)";
        $('#delete_event').html("&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete Only This Occurrence</a>");
        $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + true + ")'>Delete All In Series</a>")
        $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", \"future\")'>Delete All Future Events</a>")
    }
    else {
        title = event.title;
        $('#delete_event').html("<a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete</a>");
    }*/
  
    $('#delete_event').html("<a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete</a>");
     
    $('#desc_dialog').dialog({
        title: title,
        closeOnEscape:true,
        modal: true,
        width: 500,
        draggable: true,
        resizable: true,
        close: function(event, ui){
            $('#desc_dialog').dialog('destroy')
        }
        
    });
    
}



function createEvent(startdate,enddate,allDay){
    slotMinutes = $.fullCalendar.passedOptions['slotMinutes'];

    jQuery.ajax({
        data: 'slotminutes='+slotMinutes+ '&startdate='+startdate+ '&enddate='+enddate+ '&allDay='+allDay,
        dataType: 'script',
        type: 'get',
        success: function(data) {},
        error: function(x,t,c) {
            alert("error! "+x+t+c);          
        },
        url: "/appointments/new"
        //url: "/appointments/edit"
    });
}

function editEvent(event_id){
    slotMinutes = $.fullCalendar.passedOptions['slotMinutes'];
    alert("slotMinutes: "+slotMinutes);
    jQuery.ajax({
        data: 'id=' + event_id+'&slotminutes='+slotMinutes,
        dataType: 'script',
        type: 'get',
        success: function(data) {},
        error: function(x,t,c) {
            alert("error! "+x+t+c);          
        },
        url: "/appointments/"+event_id+"/edit"
        //url: "/appointments/edit"
    });
}

function deleteEvent(event_id, delete_all){
    
    if(confirm("Are you sure to cancel the appointment?"))
    {
        jQuery.ajax({
            data: 'id=' + event_id + '&delete_all='+delete_all,
            dataType: 'script',
            type: 'delete',
            url: "/appointments/"+event_id
        });
    }
}

function showPeriodAndFrequency(value){

    switch (value) {
        case 'Daily':
            $('#period').html('day');
            $('#frequency').show();
            break;
        case 'Weekly':
            $('#period').html('week');
            $('#frequency').show();
            break;
        case 'Monthly':
            $('#period').html('month');
            $('#frequency').show();
            break;
        case 'Yearly':
            $('#period').html('year');
            $('#frequency').show();
            break;
            
        default:
            $('#frequency').hide();
    }
    
}
