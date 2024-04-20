void main() {

    int cnt1, cnt5, cnt10 = 0;

    while(1) {
        // int cnt1, cnt5, cnt10 = 0;

        putChar('\r');
        printInt(cnt1,10 | 5 << 16);
        putChar('\t');
        printInt(cnt5,10 | 5 << 16);
        putChar('\t');
        printInt(cnt10,10 | 5 << 16);

        delay(100);       // 0.1 s == 100 ms

        cnt10++;

        if (cnt10%2 == 0) {
            cnt5++;
        }
        if (cnt10%10 == 0) {
            cnt1++;
        }
    }
    return 0;
}