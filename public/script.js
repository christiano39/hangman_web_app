const image = document.getElementById('image');
const guesses_div = document.getElementById('guesses');
let guesses = parseInt(guesses_div.textContent.split("").slice(-1).pop());
let cheat_visible = false;

switch (guesses) {
    case 8:
        image.src = "stage0.png";
        break;
    case 7:
        image.src = "stage1.png";
        break;
    case 6:
        image.src = "stage2.png";
        break;
    case 5:
        image.src = "stage3.png";
        break;
    case 4:
        image.src = "stage4.png";
        break;
    case 3:
        image.src = "stage5.png";
        break;
    case 2:
        image.src = "stage6.png";
        break;
    case 1:
        image.src = "stage7.png";
        break;
    case 0:
        image.src = "stage8.png";
        break;
    default:
        image.src = "stage0.png";
}

function showCheat() {
    cheat = document.getElementById('cheat');
    cheat.style.visibility = "visible";
    cheat_visible = true;
}

function hideCheat() {
    cheat = document.getElementById('cheat');
    cheat.style.visibility = "hidden";
    cheat_visible = true;
}

function toggleCheat() {
    if (cheat_visible) {
        hideCheat();
    }else{
        showCheat();
    }
}

