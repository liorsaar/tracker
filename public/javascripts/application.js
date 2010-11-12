// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function tt()
{
    alert("tt");

  		var ctx = document.getElementById('c').getContext('2d');
	
  		ctx.fillStyle = 'blue';
	  	ctx.fillRect(-50, -50, 100, 100);
	  
	  	ctx.fillStyle = 'green';
	  	ctx.fillRect(50, 50, 100, 100);
	  
	  	ctx.strokeStyle = 'black';
	  	ctx.strokeRect(0, 0, 100, 100);
}

function showCorrectAnswer()
{
   		if($('show_correct_answer').checked)
   		{
   			alert('show');//$("correct_answer").show();
   		}
   		else
   		{
   			alert('hide');//$("correct_answer").hide();
  		}
}