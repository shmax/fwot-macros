CollectNixonBucks() {
    ImageSearch, xPos, yPos, 430, 300, 2000, 1200, *35 icons/cashwad.bmp
    while(1) {
        Sleep, 200
        sclick(xPos, yPos)
        Sleep, 50
        ImageSearch, xPos, yPos, 430, 300, 2000, 1200, *35 icons/cashwad.bmp
    }
}