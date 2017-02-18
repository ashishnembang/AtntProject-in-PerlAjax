
$(function(){
	
	getAppointments();
	
	$("#appointment_detail").hide();
	$("#btn_add").hide();
	$("#btn_cancal").hide();
	$("#assignment_form").hide();
	
	$("#btn_new").click(function(){
		$("#btn_new").hide();
		$("#btn_add").show();
		$("#btn_cancal").show();
		$("#assignment_form").show();
		$("#search_and_list").hide();
	});
	
	$("#btn_cancal").click(function(){
		$("#btn_new").show();
		$("#btn_add").hide();
		$("#btn_cancal").hide();
		$("#assignment_form").hide();
		$("#search_and_list").show();
		$('#txt_search').val('');
		getAppointments();
	});
	

	$("#btn_search").click(function(){
		var txt_search =  $("#txt_search").val();
		$.get({
	  		dataType: "json",
			url: "searchAppointment.pl?txt_search="+txt_search,
			data: '',
			  success: function(data){
				  
				   populateTable(data);
			  },
			  error: function(e){
				  alert("err");
			  }
			  
			});
	});
	
});

//getting list of appointments initially
function getAppointments(){
	$.ajax({
	  dataType: "json",
	  url: "selectingAppointment.pl",
	  data: '',
	  success: function(data){
		  populateTable(data);
	  },
	  error: function(e){
		  alert("err");
	  }	  
	});
}

//populating and appending list of appointment
function populateTable(data){
	var name = data;
	var $table=$('<table border="1">');
	$table.append('<tr><th>Date</th><th>Time</th><th>Description</th></tr>');
	 $.each(name, function(i,record) {
	     	var splt = record.createdDate.split(' ');
	     	var date = splt[0];
	     	var time = splt[1];
            $table.append("<tr><td>"+date+"</td><td>"+time+"</td><td>"+record.description+"</td></tr>");
	 });
	 
	 $('#appointment_details').html('').append($table);
}
