CollectNixonBucks() {
    thresh = 50
    while(1) {
        ImageSearch, xPos, yPos, 0, 0, 2000, 1080, *45 icons/cashwad.bmp
        sclick(xPos+5, yPos+5)
        Sleep, 200
    }
}