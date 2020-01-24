$(document).ready(function()
      { 
             $(document).bind("contextmenu",function(e){
                    return false;
             });
             $("#seg").hide();
      });
      
      $(document).ready(function()
      { 
        $("#customSwitch1").click(function () {
      
           if ($(this).is(":checked")) {
             $("#seg").show();
               } else {
                 $("#seg").hide();
                 $("#seg").val('N/A')
               }
        });
});

$(document).ready(function () {
  $('#submit').on('click',function(e) {
  $dscDLV= $('#dsc').val();
  $prbmDLV= $('#prbm').val();
  $osDLV= $('#os').val();
  $dsmDLV= $('#dsm').val();
  $dsaDLV= $('#dsa').val();
  $icDLV= $('#ic').val();
  $scDLV= $('#sc').val();
  $segDLV= $('#seg').val();
  //if no option is found alert the user
  if (($('option[value="'+$dscDLV+'"]').length == 0)){
    alert('Incorrect value for Deep Security Component');
    e.preventDefault();
  }
  else if (($('option[value="'+$prbmDLV+'"]').length == 0)){
    alert('Incorrect value for Problematic Module');
    e.preventDefault();
  }
  else if (($('option[value="'+$osDLV+'"]').length == 0)){
    alert('Incorrect value for Affected Operating System');
    e.preventDefault();
  }
  else if (($('option[value="'+$dsmDLV+'"]').length == 0)){
    alert('Incorrect value for DSM Build');
    e.preventDefault();
  }
  else if (($('option[value="'+$dsaDLV+'"]').length == 0)){
    alert('Incorrect value for DSA Build');
    e.preventDefault();
  }
  else if (($('option[value="'+$icDLV+'"]').length == 0)){
    alert('Incorrect value for Issue Category');
    e.preventDefault();
  }
  else if (($('option[value="'+$scDLV+'"]').length == 0)){
    alert('Incorrect value for Sub Category');
    e.preventDefault();
  }
  else if (($('option[value="'+$segDLV+'"]').length == 0)){
    alert('Incorrect value for SEG Escalated');
    e.preventDefault();
  }
  else if ($dscDLV == "N/A"){
    alert('Please have input for Deep Security Component');
    e.preventDefault();
  }
  else if ($prbmDLV == "N/A"){
    alert('Please have input for Concerned Feature');
    e.preventDefault();
  }
  else if ($icDLV == "N/A"){
    alert('Please have input for Issue Category');
    e.preventDefault();
  }
  else if ($scDLV == "N/A"){
    alert('Please have input for Sub Category');
    e.preventDefault();
  }
   else {

        if ($('#customSwitch1').is(":checked")) {
        $('#outputs').html($('#dsc').val() + " | " + $('#prbm').val() + " | " + $('#os').val() + " | " + $('#dsm').val() + " | " + $('#dsa').val() + " | " + $('#ic').val() + " | " + $('#sc').val() + " | SEG Escalated | " + $('#txtarea').val() + " | ");

        $("#outputs").select();
            document.execCommand('copy');
          } else {
            $('#outputs').html($('#dsc').val() + " | " + $('#prbm').val() + " | " + $('#os').val() + " | " + $('#dsm').val() + " | " + $('#dsa').val() + " | " + $('#ic').val() + " | " + $('#sc').val() + " | " + $('#seg').val() + " | " + $('#txtarea').val() + " | ");

        $("#outputs").select();
          document.execCommand('copy');
          }

          if($('#seg').val() != "N/A") {
            $('#outputs').html($('#dsc').val() + " | " + $('#prbm').val() + " | " + $('#os').val() + " | " + $('#dsm').val() + " | " + $('#dsa').val() + " | " + $('#ic').val() + " | " + $('#sc').val() + " | SEG Escalated: " + $('#seg').val() + " | " + $('#txtarea').val() + " | ");

        $("#outputs").select();
          document.execCommand('copy');
          } 

   }
});  

});

$(document).ready(function () {
  $('#dsc').focusin(function() {
    $('#dsc').val('');
  });

  $('#dsc').focusout(function() {
    if(!($('#dsc').val() != '')){
      $('#dsc').val('Choose an option...')
    }
  });


  $('#prbm').focusin(function() {
    $('#prbm').val('');
  });

  $('#prbm').focusout(function() {
    if(!($('#prbm').val() != '')){
      $('#prbm').val('Choose an option...')
    }
  });


  $('#os').focusin(function() {
    $('#os').val('');
  });

  $('#os').focusout(function() {
    if(!($('#os').val() != '')){
      $('#os').val('N/A')
    }
  });


  $('#dsm').focusin(function() {
    $('#dsm').val('');
  });

  $('#dsm').focusout(function() {
    if(!($('#dsm').val() != '')){
      $('#dsm').val('N/A')
    }
  });


  $('#dsa').focusin(function() {
    $('#dsa').val('');
  });

  $('#dsa').focusout(function() {
    if(!($('#dsa').val() != '')){
      $('#dsa').val('N/A')
    }
  });


  $('#ic').focusin(function() {
    $('#ic').val('');
  });

  $('#ic').focusout(function() {
    if(!($('#ic').val() != '')){
      $('#ic').val('Choose an option...')
    }
  });

   $('#sc').focusin(function() {
    $('#sc').val('');
  });

   $('#sc').focusout(function() {
    if(!($('#sc').val() != '')){
      $('#sc').val('Choose an option...')
    }
  });


  $('#seg').focusin(function() {
    $('#seg').val('');
  });

  $('#seg').focusout(function() {
    if(!($('#seg').val() != '')){
      $('#seg').val('N/A')
    }
  });


});