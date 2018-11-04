var start = new Date;

console.log("prev");

var seconds_left = 61;
var interval = setInterval(function() {
    $('#Timer').text(--seconds_left);

    if(seconds_left < 1){
        // alert("new person");

        seconds_left = 60;
    }
}, 1000);

