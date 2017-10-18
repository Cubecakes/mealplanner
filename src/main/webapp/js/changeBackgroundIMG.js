/*var bgIMG= document.getElementById('background-image');
        function myFunction() {
            alert(document.getElementById("background-image").style.backgroundImage);
        }
    var i = 0;
    setInterval(function() {
        bgIMG.style.backgroundImage = "url(/images/food_bg/" + i + ".jpg)";
        i = i + 1;
        if (i == 12) {
            i =  0;
        }
    }, 10000);*/

//xxx
//smooth change background

var imgs = new Array("0.jpg","1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg","10.jpg","11.jpg","12.jpg","13.jpg");
function changeBg() {
    var imgUrl = imgs[Math.floor(Math.random()*imgs.length)];
    $('#background-image').css('background-image', 'url(/images/food_bg/' + imgUrl + ')');
    $('#background-image').fadeIn(1000); //this is new, will fade in smoothly
}

function changeBackgroundSmoothly() {
    $('#background-image').fadeOut(1000, changeBg); //this is new, will fade out smoothly
}

setInterval(changeBackgroundSmoothly,6000);