// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
function getUrlParameter(sParam)
{
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) 
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) 
        {
            return sParameterName[1];
        }
    }
}   

function handleBalancedResponse(response) {
  if (response.status_code === 201) {
    var fundingInstrument = response.cards != null ? response.cards[0] : response.bank_accounts[0];

    $.ajax({
      type: 'POST',
      url: '/api/v1/bank_accounts',
      data: {
	bank_account: {
		instrument_href: fundingInstrument.href
        }
      },
      beforeSend: function (request) {
         var token = getUrlParameter('token');
         request.setRequestHeader('Authorization', 'Token token="'+ token +'"');
      }
    });
    
  } else {
    window.alert("Bank Account Failed to Add");
  }
}

$(function() {
  balanced.init();

  $(document).on('click', '#ba-create', function (e){
      e.preventDefault();

  var payload = {
    name: $('#ba-name').val(),
    routing_number: $('#ba-routing').val(),
    account_number: $('#ba-number').val()
  };

  // Create bank account
  balanced.bankAccount.create(payload, handleBalancedResponse);
  });
});
