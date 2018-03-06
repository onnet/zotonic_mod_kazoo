/**
 *  Calculator functions
 */
$(function(){

    var dials = $("#phone .dialpad .button");
    var index;
    var number = $("#webrtc_destination");
    var total;

    dials.click(function(){

console.log('Button pressed');

        index = dials.index(this);

console.log(index);

        if(index == 0){

          if (dtmfstate) {
            sendDtmf("1");
          } else {
            number.val(number.val() + "1");
          }

        }else if(index == 1){

          if (dtmfstate) {
            sendDtmf("2");
          } else {
            number.val(number.val() + "2");
          }

        }else if(index == 2){

          if (dtmfstate) {
            sendDtmf("3");
          } else {
            number.val(number.val() + "3");
          }

        }else if(index == 3){

          if (dtmfstate) {
            sendDtmf("4");
          } else {
            number.val(number.val() + "4");
          }

        }else if(index == 4){

          if (dtmfstate) {
            sendDtmf("5");
          } else {
            number.val(number.val() + "5");
          }

        }else if(index == 5){

          if (dtmfstate) {
            sendDtmf("6");
          } else {
            number.val(number.val() + "6");
          }

        }else if(index == 6){

          if (dtmfstate) {
            sendDtmf("7");
          } else {
            number.val(number.val() + "7");
          }

        }else if(index == 7){

          if (dtmfstate) {
            sendDtmf("8");
          } else {
            number.val(number.val() + "8");
          }

        }else if(index == 8){

          if (dtmfstate) {
            sendDtmf("9");
          } else {
            number.val(number.val() + "9");
          }

        }else if(index == 9){

          if (dtmfstate) {
            sendDtmf("*");
          } else {
            number.val(number.val() + "*");
          }

        }else if(index == 10){

          if (dtmfstate) {
            sendDtmf("0");
          } else {
            number.val(number.val() + "0");
          }

        }else if(index == 11){

          if (dtmfstate) {
            sendDtmf("#");
          } else {
            number.val(number.val() + "#");
          }

        }else if(index == 12){

            number.val("");

        }else if(index == 13){

            total = number.text();
            total = total.slice(0,-1);
            number.empty().append(total);

        }else if(index == 14){

            console.log(index);

        }else{ console.log(index); }
    });

});
