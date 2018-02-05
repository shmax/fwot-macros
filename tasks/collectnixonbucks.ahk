CollectNixonBucks() {
    ImageSearch, xPos, yPos, 430, 300, 2000, 1200, *155 icons/cashwad.bmp
    while(ErrorLevel == 0) {
        Sleep, 100
        sclick(xPos + 10, yPos + 10)
        Sleep, 50
        ImageSearch, xPos, yPos, 430, 300, 2000, 1200, *155 icons/cashwad.bmp
    }
}